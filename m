Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSLBOiw>; Mon, 2 Dec 2002 09:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSLBOiw>; Mon, 2 Dec 2002 09:38:52 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:14084 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264724AbSLBOiv>; Mon, 2 Dec 2002 09:38:51 -0500
Message-ID: <3DEB70FE.C422A3EB@aitel.hist.no>
Date: Mon, 02 Dec 2002 15:41:02 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [no] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 hang when copying files, handwritten trace included
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.50 hung when copying 800M.
mke2fs on a 10G partition, then try to copy
the entire /home there. Source and destionation
was on the same disk. After a while, this happened:

EIP: wake_up_forked_process+0xb8/0x18c
EAX: 5a5a5a5a   (suspicious)

trace:
do_fork
kernel_thread
pdflush
kernel_thread_helper
start_one_pdflush_thread
pdflush
__pdflush
__pdflush
background_writeout
kernel_thread_helper


The machine has 512M ram. It is a pentium IV 2.4GHz.
The kernel is compiled with smp (hoping for hyperthreading
but it haven't happened yet), preempt, devfs support (but
devfs isn't mounted anywhere currently) and IDE driver
for the SIS 5513.  

Both filesystems are ext2. The machine was in
single-user mode at the time.  I can reliably
reproduce this if a more detailed oops 
will help in debugging. I have 2G of swap space
on another IDE drive.

compiled with gcc 2.95.4 from debian testing

ide controller:
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]

I'm using dma, irq unmasking, 32-bit io and multiple 
sector transfers.

Helge Hafting
