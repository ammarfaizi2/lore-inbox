Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267838AbUG3VDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267838AbUG3VDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUG3VDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:03:23 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62933 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S267838AbUG3VDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:03:20 -0400
Date: Fri, 30 Jul 2004 14:03:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: kumar.gala@freescale.com, tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, olh@suse.de, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040730210318.GS16468@smtp.west.cox.net>
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730224828.0f06e37a.pochini@shiny.it>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 10:48:28PM +0200, Giuliano Pochini wrote:

[snip]
> gcc 3.3.3 + binutils 2.15 fails quite soon here:
> 
>   AS      arch/ppc/kernel/l2cr.o
> arch/ppc/kernel/l2cr.S: Assembler messages:
> arch/ppc/kernel/l2cr.S:110: Error: Unrecognized opcode: `dssall'
> arch/ppc/kernel/l2cr.S:278: Error: Unrecognized opcode: `dssall'
> arch/ppc/kernel/l2cr.S:387: Error: Unrecognized opcode: `dssall'
> make[1]: *** [arch/ppc/kernel/l2cr.o] Error 1

Can you try with the following?

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

===== arch/ppc/Makefile 1.57 vs edited =====
--- 1.57/arch/ppc/Makefile	2004-07-28 21:58:36 -07:00
+++ edited/arch/ppc/Makefile	2004-07-29 12:21:33 -07:00
@@ -22,7 +22,7 @@
 
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
-AFLAGS		+= -Iarch/$(ARCH)
+aflags-y	+= -Iarch/$(ARCH)
 cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -Wno-uninitialized -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
@@ -33,10 +33,16 @@
 cflags-y	+= -mstring
 endif
 
+aflags-$(CONFIG_4xx)		+= -m405
 cflags-$(CONFIG_4xx)		+= -Wa,-m405
+aflags-$(CONFIG_6xx)		+= -maltivec
+cflags-$(CONFIG_6xx)		+= -Wa,-maltivec
+aflags-$(CONFIG_E500)		+= -me500
 cflags-$(CONFIG_E500)		+= -Wa,-me500
+aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
 cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
 
+AFLAGS += $(aflags-y)
 CFLAGS += $(cflags-y)
 
 head-y				:= arch/ppc/kernel/head.o

-- 
Tom Rini
http://gate.crashing.org/~trini/
