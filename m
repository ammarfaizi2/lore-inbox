Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTACIcO>; Fri, 3 Jan 2003 03:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbTACIcO>; Fri, 3 Jan 2003 03:32:14 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:11175 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S267433AbTACIcN>; Fri, 3 Jan 2003 03:32:13 -0500
Message-ID: <00fe01c2b303$c3e67790$760010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Fw: Linux v2.5.54
Date: Fri, 3 Jan 2003 09:40:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o remove hugetlb syscalls

So finally they did it ...

But mmap(NULL, ...) is not yet supported, this is really sad.

And arch/i386/Kconfig and Documentation/vm/hugetlbpage.txt still document
the sys_alloc_hugepages()/sys_free_hugepages() syscalls.

A simple program that doesnt know at all how the memory is layed out by
kernel/glibc can not easily get some 4Mo pages in a single syscall.
sys_alloc_hugepage() was very convenient for that.

Another problem :

if you mount hugetlbfs in /huge, then create a file /huge/BIG of size 4Mo,
then use :

dd if=/huge/BIG of=/dev/null

the dd process hangs on 'D' state : the read() syscall just hang forever.

Thanks

