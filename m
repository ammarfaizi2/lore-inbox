Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUHESFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUHESFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUHESDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:03:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:52185 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267846AbUHESDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:03:01 -0400
Date: Thu, 5 Aug 2004 20:00:25 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
       tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040805180025.GA20390@suse.de>
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net> <20040805141257.GA14826@suse.de> <20040805165410.GA555@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040805165410.GA555@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Aug 05, Tom Rini wrote:

> On Thu, Aug 05, 2004 at 04:12:57PM +0200, Olaf Hering wrote:
> >  On Fri, Jul 30, Tom Rini wrote:
> > 
> > > 
> > > +aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
> > 
> > this should be -Wa,-mppc64bridge for some reasons.
> 
> That, er, doesn't make sense.  The assembler needs -Wa,?

This makes g5 32bit happy. aflags- is used with 'gcc $options', not for as
I'm not sure if the other aflags- should stay.

g5 has altivec, some include files use dsall in asm(). 
head.S will not compile without -maltivevec

diff -purNX /tmp/kernel_exclude.txt linux-2.6.8-rc3.orig/arch/ppc/Makefile linux-2.6.8-rc3/arch/ppc/Makefile
--- linux-2.6.8-rc3.orig/arch/ppc/Makefile	2004-08-05 17:35:10.636631000 +0000
+++ linux-2.6.8-rc3/arch/ppc/Makefile	2004-08-05 17:51:09.847355812 +0000
@@ -39,8 +39,8 @@ aflags-$(CONFIG_6xx)		+= -maltivec
 cflags-$(CONFIG_6xx)		+= -Wa,-maltivec
 aflags-$(CONFIG_E500)		+= -me500
 cflags-$(CONFIG_E500)		+= -Wa,-me500
-aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
 cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
+cflags-$(CONFIG_POWER4)		+= -Wa,-maltivec
 
 AFLAGS += $(aflags-y)
 CFLAGS += $(cflags-y)
diff -purNX /tmp/kernel_exclude.txt linux-2.6.8-rc3.orig/arch/ppc/kernel/Makefile linux-2.6.8-rc3/arch/ppc/kernel/Makefile
--- linux-2.6.8-rc3.orig/arch/ppc/kernel/Makefile	2004-08-05 17:35:10.665626000 +0000
+++ linux-2.6.8-rc3/arch/ppc/kernel/Makefile	2004-08-05 17:50:19.532770245 +0000
@@ -5,6 +5,9 @@
 ifdef CONFIG_PPC64BRIDGE
 EXTRA_AFLAGS		:= -Wa,-mppc64bridge
 endif
+ifdef CONFIG_POWER4
+EXTRA_AFLAGS		:= -Wa,-maltivec
+endif
 ifdef CONFIG_4xx
 EXTRA_AFLAGS		:= -Wa,-m405
 endif

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
