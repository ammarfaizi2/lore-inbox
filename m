Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317671AbSGJXTP>; Wed, 10 Jul 2002 19:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317672AbSGJXTO>; Wed, 10 Jul 2002 19:19:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45193 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317671AbSGJXTN>;
	Wed, 10 Jul 2002 19:19:13 -0400
Date: Wed, 10 Jul 2002 16:21:08 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Compile error (starfire ethernet) on 2.5.25 for crc32_le
Message-ID: <165080000.1026343268@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following compile error if I try to use the starfire
driver.

  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o /home/mbligh/linux-2.5.25/arch/i386/lib/lib.a lib/lib.a /home/mbligh/linux-2.5.25/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `set_rx_mode':
drivers/built-in.o(.text+0x2138c): undefined reference to `crc32_le'
make: *** [vmlinux] Error 1

starfire.c calls ether_crc_le which is defined in include/linux/crc32.h as
#define ether_crc_le(length, data) crc32_le(~0, data, length)

crc32_le is defined in lib/crc32.c .... which is only compiled if CONFIG_CRC32
is set  ... setting this fixes the problem ... shouldn't drivers that need this turn it
on automatically somehow?

M.

