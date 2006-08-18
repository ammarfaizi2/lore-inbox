Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWHRIaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWHRIaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWHRIaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:30:09 -0400
Received: from main.gmane.org ([80.91.229.2]:47777 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751173AbWHRIaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:30:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Greg Schafer <gschafer@zip.com.au>
Subject: Re: What's in kbuild.git for 2.6.19
Date: Fri, 18 Aug 2006 18:26:07 +1000
Message-ID: <pan.2006.08.18.08.26.03.994311@zip.com.au>
References: <20060813194503.GA21736@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp56d0.dsl.pacific.net.au
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 21:45:03 +0200, Sam Ravnborg wrote:

> Just a quick intro to what is pending in kbuild.git/lxdialog.git for 2.6.19.
> And a short status too.
> 
> Highlights:
> 	o unifdef is now included in the kernel source (used by
> 	  headers_* targets).

Hi Sam,

This apparently doesn't build:

  CHK     include/linux/version.h
  UPD     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/unifdef
/tmp/ccwcmPxS.o: In function `keywordedit':
unifdef.c:(.text+0x25c): undefined reference to `strlcpy'
collect2: ld returned 1 exit status
make[1]: *** [scripts/unifdef] Error 1
make: *** [headers_install] Error 2


AFAICT, strlcpy is a BSD'ism and isn't generally available to userland on
Linux (but of course the kernel has its own strlcpy implementation).
Debian solve this by including a separate strlcpy.c with the unifdef
source. See:

http://ftp.debian.org/debian/pool/main/u/unifdef/unifdef_1.0+20030701.orig.tar.gz

Regards
Greg

