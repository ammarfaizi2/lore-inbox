Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTAWFlQ>; Thu, 23 Jan 2003 00:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTAWFlQ>; Thu, 23 Jan 2003 00:41:16 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:48540 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264883AbTAWFlP>; Thu, 23 Jan 2003 00:41:15 -0500
Date: Wed, 22 Jan 2003 23:50:16 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Kevin Lawton <kevinlawton2001@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please
 consider)
In-Reply-To: <20030123051119.18154.qmail@web80304.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0301222345110.21255-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Kevin Lawton wrote:

Three minor points:

o If you included the patch inline instead of as application/octet-stream, 
  it'd be easier to reply ;)

> +Nothing, it's Open Source.  Linux is obviously a GPL'd program.
> +Plex86 is an LGPL'd kernel module.  Though it's a separate
> +

o Something's missing there?


diff -urN linux-2.5.59/Makefile linux-2.5.59-hal/Makefile
--- linux-2.5.59/Makefile	Wed Jan 22 12:25:58 2003
+++ linux-2.5.59-hal/Makefile	Wed Jan 22 22:36:00 2003
@@ -264,6 +264,18 @@
 CFLAGS		+= -fomit-frame-pointer
 endif
 
+ifdef CONFIG_X86_HAL
+# On x86, if compiling for the Hardware Abstraction Layer
+# (running Linux as a guest OS in a Virtual Machine),
+# we need to insert some asm macros which redefine
+# the behaviour of instructions which modify the
+# interrupt flag.  You are probably not configuring for
+# this mode.  For more info, read 'Documentation/x86-hal.txt'.
+# This needs to be the first include any module sees.
+CFLAGS		+= -include include/asm/if.h
+AFLAGS		+= -include include/asm/if.h
+endif
+
 #
 # INSTALL_PATH specifies where to place the updated kernel and system map
 # images.  Uncomment if you want to place them anywhere other than root.
@@ -409,6 +421,10 @@
 #	their vmlinux.lds.S file
 
 AFLAGS_vmlinux.lds.o += -P -C -U$(ARCH)
+
+ifdef CONFIG_X86_HAL
+AFLAGS_vmlinux.lds.o += -DNO_X86_HAL_INCLUDES
+endif
 
 arch/$(ARCH)/vmlinux.lds.s: %.s: %.S scripts FORCE
 	$(call if_changed_dep,as_s_S)

o These modifications should be done from arch/i386/Makefile instead, 
  since they're obviously i386-specific.


