Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268143AbUHFPif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268143AbUHFPif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268154AbUHFPdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:33:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:14527 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268148AbUHFPcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:32:50 -0400
Date: Fri, 6 Aug 2004 17:32:42 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
       tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040806153242.GA20335@suse.de>
References: <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net> <20040805141257.GA14826@suse.de> <20040805165410.GA555@smtp.west.cox.net> <20040805180025.GA20390@suse.de> <20040805181425.GD555@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040805181425.GD555@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Aug 05, Tom Rini wrote:

> On Thu, Aug 05, 2004 at 08:00:25PM +0200, Olaf Hering wrote:
> >  On Thu, Aug 05, Tom Rini wrote:
> > 
> > > On Thu, Aug 05, 2004 at 04:12:57PM +0200, Olaf Hering wrote:
> > > >  On Fri, Jul 30, Tom Rini wrote:
> > > > 
> > > > > 
> > > > > +aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
> > > > 
> > > > this should be -Wa,-mppc64bridge for some reasons.
> > > 
> > > That, er, doesn't make sense.  The assembler needs -Wa,?
> > 
> > This makes g5 32bit happy. aflags- is used with 'gcc $options', not for as
> > I'm not sure if the other aflags- should stay.
> 
> I mistook AFLAGS for being always invoked with gas, which is not the
> case.  Lets do the following:
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

and this one to enable altivec, because ppc64bridge disables altivec
again.
g5 32bit has CONFIG_POWER4=y and CONFIG_PPC64BRIDGE=y


diff -purNX /tmp/kernel_exclude.txt linux-2.6.8-rc3.trini/arch/ppc/Makefile linux-2.6.8-rc3.trini.fixed/arch/ppc/Makefile
--- linux-2.6.8-rc3.trini/arch/ppc/Makefile	2004-08-06 15:21:00.668653640 +0000
+++ linux-2.6.8-rc3.trini.fixed/arch/ppc/Makefile	2004-08-06 15:25:17.039320563 +0000
@@ -35,9 +35,9 @@ endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
-cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
+cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
 
 AFLAGS += $(cpu-as-y)
 CFLAGS += $(cpu-as-y)

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
