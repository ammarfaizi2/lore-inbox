Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbSLaCNw>; Mon, 30 Dec 2002 21:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbSLaCNw>; Mon, 30 Dec 2002 21:13:52 -0500
Received: from services.erkkila.org ([24.97.94.217]:13744 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id <S267123AbSLaCNu>;
	Mon, 30 Dec 2002 21:13:50 -0500
Message-ID: <3E10FF55.8040302@erkkila.org>
Date: Tue, 31 Dec 2002 02:22:13 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021220
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: patch breaks uni with apic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch causes uni+apic to fail during link, as send_IPI_self is
undefined from arch/i386/kernel/irq.c  enable_irq.

Kernel logs from previous kernel seem to think i have an apic =).

-pee


ChangeSet 1.1006, 2002/12/30 14:03:14-08:00, James.Bottomley@steeleye.com

	[PATCH] Fix hw_irq to test the proper CONFIG variable


# This patch includes the following deltas:
#	           ChangeSet	1.1005  -> 1.1006
#	include/asm-i386/hw_irq.h	1.16    -> 1.17
#

  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0x4510): In function `enable_irq':
: undefined reference to `send_IPI_self'
make: *** [.tmp_vmlinux1] Error 1

