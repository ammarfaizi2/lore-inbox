Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317559AbSGORqP>; Mon, 15 Jul 2002 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317560AbSGORqO>; Mon, 15 Jul 2002 13:46:14 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:35496 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S317559AbSGORqK>;
	Mon, 15 Jul 2002 13:46:10 -0400
Message-ID: <000b01c22c28$05cd9bb0$0201a8c0@witek>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG 2.5.11-25] mremap hang
Date: Mon, 15 Jul 2002 19:49:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2.5.11 (at least, never tested earlier kernels) meine liebe RPM-updater
Poldek is not working. I've sent posts to lkml without any response. This is
decoded output from sysrq-t. Strace shows that poldek hangs on mremap().
Blagam zrobcie cos bo to idzie sie powiesic, nie moge nawet normalnie
pracowac. Dunno where the bug is, it's fully repeatable, anyone with PLD can
make it :)


<cut>
ksymoops 2.4.4 on i686 2.5.25.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.25/ (default)
     -m /boot/System.map-2.5.25-1.1 (specified)

Warning (expand_objects): object
/lib/modules/2.5.25-1.1/kernel/fs/ext2/ext2.o for module ext2 has changed
since load
Warning (expand_objects): object
/lib/modules/2.5.25-1.1/kernel/drivers/ide/ide-disk.o for module ide-disk
has changed since load
Warning (expand_objects): object
/lib/modules/2.5.25-1.1/kernel/drivers/ide/ide-mod.o for module ide-mod has
changed since load
poldek        D C1791E30     0  3452      1          3453   605 (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c016ee45>] [<c011051f>] [<c0110034>] [<c013023f>] [<c0130022>]
   [<c0125ff6>] [<c012606b>] [<c0124c5b>] [<c01088bc>] [<c012b9bc>]
[<c012bb39>]
   [<c012c0df>] [<c012c22e>] [<c010872b>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  poldek
>>EIP; c1791e30 <_end+14d9264/20551434>   <=====
Trace; c016ee45 <rwsem_down_read_failed+115/138>
Trace; c011051f <.text.lock.fault+7/78>
Trace; c0110034 <do_page_fault+0/4e4>
Trace; c013023f <__alloc_pages+47/1a0>
Trace; c0130022 <_alloc_pages+16/18>
Trace; c0125ff6 <do_anonymous_page+18a/1c4>
Trace; c012606b <do_no_page+3b/2dc>
Trace; c0124c5b <zap_pmd_range+3f/50>
Trace; c01088bc <error_code+34/40>
Trace; c012b9bc <move_one_page+2c/17c>
Trace; c012bb39 <move_page_tables+2d/7c>
Trace; c012c0df <do_mremap+557/658>
Trace; c012c22e <sys_mremap+4e/6f>
Trace; c010872b <syscall_call+7/b>


4 warnings issued.  Results may not be reliable.

</cut>

Witek Krecicki



