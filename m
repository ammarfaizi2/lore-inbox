Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWJXIPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWJXIPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWJXINt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:49 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:44261 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932431AbWJXINX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:23 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 0/8] AVR32 update
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:38 +0200
Message-Id: <1161677566706-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a relatively minor AVR32 update which fixes a few problems I
and some other people have run into when working on various drivers.
I'm sorry if this comes a bit late, but since none of this is very
critical, I've been sitting on the patches for a while to see if I
can gather up some more updates before sending it to you.

By the way, I've got access to an externally visible git repository
now, so the next update will probably be a git pull request if that's
ok with everyone.

Haavard

Ben Nizette:
      AVR32: add io{read,write}{8,16,32}{be,} support

Haavard Skinnemoen:
      AVR32: Minor Makefile cleanup
      AVR32: Silence some compile warnings
      AVR32: Don't try to iounmap P2 segment addresses
      AVR32: Fix oversize immediates in atomic.h
      AVR32: Implement and export __raw_{read,write}s[bwl]
      AVR32: Use __raw MMIO access for internal peripherals
      AVR32: Update defconfig

 arch/avr32/Makefile                    |   21 ++-
 arch/avr32/boot/images/Makefile        |    4 -
 arch/avr32/configs/atstk1002_defconfig |  253 ++++++++++++++++++++------------
 arch/avr32/kernel/avr32_ksyms.c        |    9 +
 arch/avr32/kernel/kprobes.c            |    2 
 arch/avr32/kernel/module.c             |    4 -
 arch/avr32/kernel/ptrace.c             |    2 
 arch/avr32/lib/Makefile                |    1 
 arch/avr32/lib/io-readsb.S             |   47 ++++++
 arch/avr32/lib/io-writesb.S            |   52 +++++++
 arch/avr32/mach-at32ap/hsmc.h          |    4 -
 arch/avr32/mach-at32ap/intc.h          |    6 +
 arch/avr32/mach-at32ap/pio.h           |    6 +
 arch/avr32/mach-at32ap/sm.h            |    6 +
 arch/avr32/mm/init.c                   |    2 
 arch/avr32/mm/ioremap.c                |    2 
 include/asm-avr32/atomic.h             |    8 +
 include/asm-avr32/io.h                 |   33 ++++
 18 files changed, 340 insertions(+), 122 deletions(-)
 create mode 100644 arch/avr32/lib/io-readsb.S
 create mode 100644 arch/avr32/lib/io-writesb.S
