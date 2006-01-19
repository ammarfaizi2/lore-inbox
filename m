Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWASLGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWASLGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWASLGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:06:09 -0500
Received: from mailout1.pacific.net.au ([61.8.0.84]:39894 "EHLO
	mailout1.pacific.net.au") by vger.kernel.org with ESMTP
	id S1161130AbWASLGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:06:08 -0500
Date: Thu, 19 Jan 2006 22:05:54 +1100
Message-Id: <200601191105.k0JB5sKN012313@typhaon.pacific.net.au>
From: "David Luyer" <david@luyer.net>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] Error 2"
In-Reply-To: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 10:47:13PM -0800, Miles Lane wrote:
> make all install modules modules_install
> /bin/sh: -c: line 0: syntax error near unexpected token `('
> /bin/sh: -c: line 0: `set -e; echo '  CHK    
> include/linux/version.h'; mkdir -p include/linux/;      if [ `echo -n
> "2.6.16-rc1-git1 .file null .ident
> GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo
> '"2.6.16-rc1-git1 .file null .ident
[...]

Happens for me also (on latest snapshot).

/dev/null is removed by this line in check-lxdialog.sh during a
'make menuconfig':

   echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null

This only happens if you don't have a libncursesw installed (not sure
if it is compiler dependant as well).

/dev/null being removed has many side-effects, this is just one of them.

Obviously 'cd /dev; ./MAKEDEV null' will fix.  Oh, and fixing the script
would be useful too ;-)

David.
-- 
Pacific Internet (Australia) Pty Ltd
Business card: http://www.luyer.net/bc.html
Important notice: http://www.pacific.net.au/disclaimer/
