Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTHZWTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTHZWTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:19:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7158 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262971AbTHZWTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:19:30 -0400
Date: Wed, 27 Aug 2003 00:19:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small sparc Makefile cleanups
Message-ID: <20030826221922.GJ7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes checks for ancient gcc and binutils versions 
from arch/sparc/Makefile (and the "-g" is already better handled in 
the toplevel Makefile).

cu
Adrian

--- linux-2.6.0-test4-not-full/arch/sparc/Makefile.old	2003-08-27 00:08:31.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/sparc/Makefile	2003-08-27 00:14:46.000000000 +0200
@@ -7,25 +7,11 @@
 # Copyright (C) 1994 David S. Miller (davem@caip.rutgers.edu)
 #
 
-#
-# Uncomment the first CFLAGS if you are doing kgdb source level
-# debugging of the kernel to get the proper debugging information.
-
-IS_EGCS := $(shell if $(CC) -m32 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo y; else echo n; fi; )
-NEW_GAS := $(shell if $(LD) --version 2>&1 | grep 'elf64_sparc' > /dev/null; then echo y; else echo n; fi)
-
-ifeq ($(NEW_GAS),y)
 AS              := $(AS) -32
 LDFLAGS		:= -m elf32_sparc
-endif
 
-#CFLAGS := $(CFLAGS) -g -pipe -fcall-used-g5 -fcall-used-g7
-ifneq ($(IS_EGCS),y)
-CFLAGS := $(CFLAGS) -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
-else
 CFLAGS := $(CFLAGS) -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
 AFLAGS := $(AFLAGS) -m32
-endif
 
 #LDFLAGS_vmlinux = -N -Ttext 0xf0004000
 #  Since 2.5.40, the first stage is left not btfix-ed.
