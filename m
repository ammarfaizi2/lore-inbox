Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSDDPp6>; Thu, 4 Apr 2002 10:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSDDPps>; Thu, 4 Apr 2002 10:45:48 -0500
Received: from mail.sonytel.be ([193.74.243.200]:45819 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S313202AbSDDPpd>;
	Thu, 4 Apr 2002 10:45:33 -0500
Date: Thu, 4 Apr 2002 17:45:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE/SUPPORT_VLB_SYNC in 2.5.x
In-Reply-To: <3CAC28A7.1060500@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0204041740550.28139-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SUPPORT_VLB_SYNC is now unconditionally hardcoded to 1 in
drivers/ide/ide-taskfile.c.

While most architectures disable it, which no longer works:

| tux$ find include -type f | xargs grep SUPPORT_VLB_SYNC
| include/asm-cris/ide.h:#undef SUPPORT_VLB_SYNC
| include/asm-cris/ide.h:#define SUPPORT_VLB_SYNC 0
| include/asm-m68k/ide.h:#undef SUPPORT_VLB_SYNC
| include/asm-m68k/ide.h:#define SUPPORT_VLB_SYNC 0
| include/asm-mips/ide.h:#undef  SUPPORT_VLB_SYNC
| include/asm-mips/ide.h:#define SUPPORT_VLB_SYNC 0
| include/asm-ppc/ide.h:#undef	SUPPORT_VLB_SYNC
| include/asm-ppc/ide.h:#define SUPPORT_VLB_SYNC	0
| include/asm-sparc/ide.h:#undef  SUPPORT_VLB_SYNC
| include/asm-sparc/ide.h:#define SUPPORT_VLB_SYNC 0
| include/asm-sparc64/ide.h:#undef  SUPPORT_VLB_SYNC
| include/asm-sparc64/ide.h:#define SUPPORT_VLB_SYNC 0
| include/linux/ide.h:#ifndef SUPPORT_VLB_SYNC		/* 1 to support weird 32-bit chips */
| include/linux/ide.h:#define SUPPORT_VLB_SYNC	1	/* 0 to reduce kernel size */

Wouldn't it be better to enable it on architectures which can have a VESA local
bus (ia32 only?) only?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

