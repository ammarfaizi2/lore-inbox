Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTK2Rlr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTK2Rlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:41:47 -0500
Received: from relay-1m.club-internet.fr ([194.158.104.40]:27872 "EHLO
	relay-1m.club-internet.fr") by vger.kernel.org with ESMTP
	id S263801AbTK2Rlk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:41:40 -0500
From: pinotj@club-internet.fr
To: manfred@colorfullife.com, torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Sat, 29 Nov 2003 18:41:36 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1070127696.1558.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I triggered the slab oops with a very small kernel -test11 (~700KB):

---
slab: double free detected in cache 'biovec-1', objp c12c2df0, objn 122, slabp c12c2000, s_mem c12c2280, bufctl ffffffff
---

Oops occurs very quickly during compilation.

Here is the .config file (I removed unset options). Full config can be found at http://cercle-daejeon.homelinux.org/misc/config-small.txt , if you want diff with other config for example.

BTW, I don't understand why I can't remove config about game port, mouse and DOS partition. Compilation without DMA fails.

I will reduce it again by removing FB and try unset some options in "linux for embbeded systems" and in debug.

Hope it can help find the problem.

Jerome Pinot

---
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

CONFIG_X86_PC=y
CONFIG_M386=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_NOHIGHMEM=y

CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y

CONFIG_BINFMT_ELF=y

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_IDEDMA=y

CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768

CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

CONFIG_XFS_FS=y

CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_RAMFS=y

CONFIG_MSDOS_PARTITION=y

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y

CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y
---

