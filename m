Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285253AbRLSMtH>; Wed, 19 Dec 2001 07:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285246AbRLSMs5>; Wed, 19 Dec 2001 07:48:57 -0500
Received: from bach.teraflops.com ([213.173.140.3]:30472 "EHLO
	bach.teraflops.com") by vger.kernel.org with ESMTP
	id <S285253AbRLSMsn>; Wed, 19 Dec 2001 07:48:43 -0500
Message-Id: <5.1.0.14.2.20011219144636.03498a10@mail.teraflops.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 19 Dec 2001 14:48:48 +0200
To: linux-kernel@vger.kernel.org
From: Marko =?ISO-8859-1?Q?Kentt=E4l=E4?= <marko.kenttala@teraflops.com>
Subject: Kernel memory usage optimisations?
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on a project that uses Linux kernel version 2.4.16 on an 
embedded ARM device. Since we have limited memory (both RAM and Flash) I 
have tuned down some kernel internal defines to make it use less memory:

include/linux/major.h: MAX_CHRDEV 255->20, MAX_BLKDEV 255->10
include/linux/tty.h: MAX_NR_CONSOLES 63->3, MAX_NR_USER_CONSOLES 63->3
include/linux/kernel-stat.h: DK_MAX_MAJOR 16->4, DK_MAX_DISK 16->4
include/linux/sched.c: PIDHASH_SZ 1024->16
include/linux/tty.h: NR_PTYS 256->16, NR_LDISCS 16->4
kernel/printk.c: LOG_BUF_LEN 16384->2048

With these I have saved about 100 KB from bss. Do you see any dangerous 
side-effects in those modifications?

I understand that best area for saving memory usage is the C-library but 
are there any other kernel areas? I'm thinking of dropping swapfile support 
and maybe some other subsystems that are not needed in embedded device.

--
Marko Kenttälä, Software Engineer
TERAFLOPS Ltd., Member of Elektrobit Group
Mobile: +358 40 7501832, Fax: +358 3 2258484
http://www.teraflops.com, http://www.elektrobit.com

