Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265712AbTFNTx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbTFNTx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 15:53:58 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30223 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265712AbTFNTxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 15:53:55 -0400
Date: Sat, 14 Jun 2003 22:07:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SH Port - Makefile
Message-ID: <20030614200744.GA3921@mars.ravnborg.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org
References: <20030614193055.GA3673@mars.ravnborg.org> <20030614194510.GD2216@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030614194510.GD2216@linux-sh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 02:45:12PM -0500, Paul Mundt wrote:
> Okay, the main reason why I needed to do this was so that a make clean
> would get the proper directory path. The problem was that machdir-y
> wasn't getting the board name correctly since at make clean time the
> CONFIG_SH_xxx names weren't being resolved.

The following should do the trick.
I also rearranged a few things.

Whith respect to removing the framepointer from CFLAGS.
There is already a CONFIG option for that CONFIG_FRAME_POINTER.
It would be much cleaner using that one in combination
with CONFIG_SH_KGDB

	Sam

===== arch/sh/Makefile 1.16 vs edited =====
--- 1.16/arch/sh/Makefile	Sat Jun 14 14:30:11 2003
+++ edited/arch/sh/Makefile	Sat Jun 14 22:03:10 2003
@@ -14,17 +14,6 @@
 # this architecture
 #
 
-#
-# We don't necessarily agree with the top-level Makefile with regards to what
-# does and does not qualify as a noconfig_targets rule. In this case, we're
-# still dependant on .config settings in order for core-y (machdir-y in
-# particular) to resolve the proper directory. So we just manually include it
-# if it hasn't been already..
-# 
-ifndef include_config
--include .config
-endif
-
 cpu-y				:= -mb
 cpu-$(CONFIG_CPU_LITTLE_ENDIAN)	:= -ml
 
@@ -66,24 +55,24 @@
 core-y				+= arch/sh/kernel/ arch/sh/mm/
 
 # Boards
-machdir-$(CONFIG_SH_SOLUTION_ENGINE)		:= se/770x
-machdir-$(CONFIG_SH_7751_SOLUTION_ENGINE)	:= se/7751
-machdir-$(CONFIG_SH_STB1_HARP)			:= harp
-machdir-$(CONFIG_SH_STB1_OVERDRIVE)		:= overdrive
-machdir-$(CONFIG_SH_HP620)			:= hp6xx/hp620
-machdir-$(CONFIG_SH_HP680)			:= hp6xx/hp680
-machdir-$(CONFIG_SH_HP690)			:= hp6xx/hp690
-machdir-$(CONFIG_SH_CQREEK)			:= cqreek
-machdir-$(CONFIG_SH_DMIDA)			:= dmida
-machdir-$(CONFIG_SH_EC3104)			:= ec3104
-machdir-$(CONFIG_SH_SATURN)			:= saturn
-machdir-$(CONFIG_SH_DREAMCAST)			:= dreamcast
-machdir-$(CONFIG_SH_CAT68701)			:= cat68701
-machdir-$(CONFIG_SH_BIGSUR)			:= bigsur
-machdir-$(CONFIG_SH_SH2000)			:= sh2000
-machdir-$(CONFIG_SH_ADX)			:= adx
-machdir-$(CONFIG_SH_MPC1211)			:= mpc1211
-machdir-$(CONFIG_SH_UNKNOWN)			:= unknown
+machdir-$(CONFIG_SH_SOLUTION_ENGINE)		:= se/770x/
+machdir-$(CONFIG_SH_7751_SOLUTION_ENGINE)	:= se/7751/
+machdir-$(CONFIG_SH_STB1_HARP)			:= harp/
+machdir-$(CONFIG_SH_STB1_OVERDRIVE)		:= overdrive/
+machdir-$(CONFIG_SH_HP620)			:= hp6xx/hp620/
+machdir-$(CONFIG_SH_HP680)			:= hp6xx/hp680/
+machdir-$(CONFIG_SH_HP690)			:= hp6xx/hp690/
+machdir-$(CONFIG_SH_CQREEK)			:= cqreek/
+machdir-$(CONFIG_SH_DMIDA)			:= dmida/
+machdir-$(CONFIG_SH_EC3104)			:= ec3104/
+machdir-$(CONFIG_SH_SATURN)			:= saturn/
+machdir-$(CONFIG_SH_DREAMCAST)			:= dreamcast/
+machdir-$(CONFIG_SH_CAT68701)			:= cat68701/
+machdir-$(CONFIG_SH_BIGSUR)			:= bigsur/
+machdir-$(CONFIG_SH_SH2000)			:= sh2000/
+machdir-$(CONFIG_SH_ADX)			:= adx/
+machdir-$(CONFIG_SH_MPC1211)			:= mpc1211/
+machdir-$(CONFIG_SH_UNKNOWN)			:= unknown/
 
 incdir-y			:= $(machdir-y)
 
@@ -91,7 +80,7 @@
 incdir-$(CONFIG_SH_7751_SOLUTION_ENGINE)	:= se7751
 incdir-$(CONFIG_SH_HP600)			:= hp6xx
 
-core-y				+= arch/sh/boards/$(machdir-y)/
+core-y				+= arch/sh/boards/$(machdir-y)
 
 # Companion chips
 core-$(CONFIG_HD64461)	+= arch/sh/cchips/hd6446x/hd64461/
@@ -103,7 +92,6 @@
 
 libs-y				+= arch/sh/lib/	$(LIBGCC)
 
-boot := arch/sh/boot
 
 AFLAGS_vmlinux.lds.o := -traditional
 
@@ -119,11 +107,10 @@
 
 	$(Q)$(MAKE) $(build)=arch/sh/tools include/asm-sh/machtypes.h
 
-BOOTIMAGE=arch/sh/boot/zImage
-zImage: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) $(BOOTIMAGE)
+boot := arch/sh/boot
 
-compressed: zImage
+zImage: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) arch/sh/boot/zImage
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)

