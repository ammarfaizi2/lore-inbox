Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbTBFXBm>; Thu, 6 Feb 2003 18:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267696AbTBFXBl>; Thu, 6 Feb 2003 18:01:41 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:16389 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267697AbTBFXAt>; Thu, 6 Feb 2003 18:00:49 -0500
Date: Fri, 7 Feb 2003 00:09:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>, <greg@kroah.com>, <jgarzik@pobox.com>
Subject: [PATCH] Restore module support. 
In-Reply-To: <20030204233310.AD6AF2C04E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302062358140.32518-100000@serv>
References: <20030204233310.AD6AF2C04E@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 Feb 2003, Rusty Russell wrote:

> I'm going to stop here, since I don't think you understand what I am
> proposing, nor how the current system works: this makes is extremely
> difficult to describe changes, and time consuming.

Rusty, if you continue to ignore criticism, I have only one answer left:

http://www.xs4all.nl/~zippel/restore-modules-2.5.59.diff

These numbers are quite interesting:

$ diffstat restore-modules-2.5.59.diff
 arch/i386/kernel/Makefile          |    1
 arch/i386/kernel/cpu/mtrr/if.c     |    1
 arch/i386/kernel/entry.S           |    6
 arch/i386/kernel/module.c          |  111 -
 arch/i386/mm/extable.c             |    1
 drivers/char/agp/Makefile          |    2
 drivers/char/misc.c                |    1                                                                                                                  
 drivers/eisa/eisa-bus.c            |    1
 drivers/input/serio/serport.c      |    1                                                                                                                  
 fs/filesystems.c                   |   27
 fs/proc/proc_misc.c                |   12
 include/asm-generic/percpu.h       |    1
 include/asm-generic/vmlinux.lds.h  |   15
 include/asm-i386/module.h          |   57
 include/linux/init.h               |  130 -
 include/linux/module.h             |  817 ++++++------
 include/linux/moduleloader.h       |   43
 include/linux/moduleparam.h        |  126 -
 init/Kconfig                       |   40
 init/main.c                        |  109 +
 kernel/Makefile                    |    8
 kernel/extable.c                   |   41
 kernel/intermodule.c               |  182 --
 kernel/kallsyms.c                  |    5
 kernel/kmod.c                      |    2
 kernel/ksyms.c                     |    7
 kernel/module.c                    | 2448 +++++++++++++++++--------------------
 kernel/params.c                    |  336 -----
 net/ipv4/netfilter/ip_nat_helper.c |    2
 scripts/Makefile.modinst           |    8
 sound/sound_core.c                 |    1
 31 files changed, 1805 insertions(+), 2737 deletions(-)

$ size linux-2.5.59-org/vmlinux linux-2.5.59-mod/vmlinux
   text    data     bss     dec     hex filename
3403915  864229  338052 4606196  4648f4 linux-2.5.59-org/vmlinux
3361448  863393  342020 4566861  45af4d linux-2.5.59-mod/vmlinux

This patch still has modversion disabled, when Kai finishes the new 
modversion support, I'll add the support for it to modutils.

bye, Roman

