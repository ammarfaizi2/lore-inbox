Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWHGUmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWHGUmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWHGUmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:42:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:27355 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932257AbWHGUmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:42:51 -0400
Date: Mon, 7 Aug 2006 13:42:41 -0700
From: Greg KH <greg@kroah.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] kbuild fixes for 2.6.18
Message-ID: <20060807204241.GA11510@kroah.com>
References: <20060807192708.GA12937@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807192708.GA12937@mars.ravnborg.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 09:27:09PM +0200, Sam Ravnborg wrote:
> Hi Greg.
> Please apply to 2.6.18.
> 
> Pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-2.6.18.git

Thanks, pulled and pushed out.

Oh, I just got a few reports of 2.6.18-rc3 not building with external
trees very well, and something like the following would be required:

--- linux-2.6.17/arch/sh/Makefile-dist        2006-08-07 20:42:33.000000000 +0200
+++ linux-2.6.17/arch/sh/Makefile     2006-08-07 21:08:26.000000000 +0200
@@ -173,7 +173,7 @@
 archprepare: maketools include/asm-sh/.cpu include/asm-sh/.mach

 PHONY += maketools FORCE
-maketools:  include/linux/version.h FORCE
+maketools: $(objtree)/include/linux/version.h FORCE

for all instances of the version.h file.

Was this fixed in -rc4 and I should update the SuSE kernel to it (well,
I'll do that anyway later today...), or is this something that you did
not know about?

thanks,

greg k-h
