Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUHCDHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUHCDHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 23:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUHCDHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 23:07:30 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:64718 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264984AbUHCDH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 23:07:29 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: sam@ravnborg.org
Date: Tue, 03 Aug 2004 13:07:26 +1000
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Can't cross compile IA32 kernels using separate build directory
Message-Id: <E1BrpeA-0002QH-00@berry.gelato.unsw.EDU.AU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sam,
   Trying to cross compile a kernel for IA32, on a system without an asm/boot.h
fails (e.g., IA64)

Here's a patch to add in -Iinclude2 when building tools/build.o so that 
asm/boot.h is picked up from the right place.

Index: linux-2.6-wip/arch/i386/boot/Makefile
===================================================================
--- linux-2.6-wip.orig/arch/i386/boot/Makefile	2004-08-03 12:58:02.287223257 +1000
+++ linux-2.6-wip/arch/i386/boot/Makefile	2004-08-03 12:59:34.661245563 +1000
@@ -31,7 +31,7 @@
 
 host-progs	:= tools/build
 
-HOSTCFLAGS_build.o := -Iinclude
+HOSTCFLAGS_build.o := -Iinclude -Iinclude2
 
 # ---------------------------------------------------------------------------
 
