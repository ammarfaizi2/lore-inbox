Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbTLWWBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 17:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTLWWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 17:01:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:55239 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264903AbTLWWBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 17:01:09 -0500
Message-Id: <200312232201.hBNM15M05248@mail.osdl.org>
Date: Tue, 23 Dec 2003 14:00:56 -0800 (PST)
From: markw@osdl.org
Subject: 2.6.0 kernel panic with megaraid driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following panic on a system with linux-2.6.0 when I create a
significant amount of i/o on a lvm2 device using drives through a
megaraid controller:

------------[ cut here ]------------    
kernel BUG at include/linux/blkdev.h:550!
invalid operand: 0000 [#1]               
CPU:    0                 
EIP:    0060:[<c0272077>]    Not tainted
EFLAGS: 00010046                        
EIP is at scsi_request_fn+0x368/0x3a8
eax: 00000000   ebx: d2ffbd90   ecx: 000040d5   edx: d2ffbd90
esi: f7701c00   edi: f755d000   ebp: f7734a00   esp: f7533e7c
ds: 007b   es: 007b   ss: 0068                               
Process scsi_eh_3 (pid: 31, threadinfo=f7532000 task=f76c26b0)
Stack: f7734a00 00000202 f7734b50 f7532000 f7532000 f7532000 f7532000 f7701d84 
       d2ffbd90 f7734a00 f755d000 00000202 c023022e f7734a00 d2ffbd90 00000292 
       e5a46e00 f7701c00 e5a46e00 f755d000 00001055 c0270bb1 f7734a00 d2ffbd90 
Call Trace:                                                                    
 [<c023022e>] blk_insert_request+0x93/0xe1
 [<c0270bb1>] scsi_queue_insert+0x75/0xa7 
 [<c026cd0e>] scsi_dispatch_cmd+0x1b0/0x21b
 [<c026f530>] scsi_times_out+0x0/0x50      
 [<c026cfef>] scsi_softirq+0xb6/0xd1 
 [<c0127ca7>] do_softirq+0xc3/0xc5  
 [<c010d4c6>] do_IRQ+0x152/0x1a6  
 [<c010b70c>] common_interrupt+0x18/0x20
 [<c027007b>] scsi_eh_bus_reset+0x28/0x10d
 [<c0109c10>] __down_failed_interruptible+0x0/0xc
 [<c0270af4>] .text.lock.scsi_error+0xb9/0xc1    
 [<c0270727>] scsi_error_handler+0x0/0x142   
 [<c0108b11>] kernel_thread_helper+0x5/0xb
                                          
Code: 0f 0b 26 02 1f 35 35 c0 e9 58 fd ff ff 89 5c 24 04 89 2c 24 
 <0>Kernel panic: Fatal exception in interrupt                    
In interrupt handler - not syncing


The following megaraid driver output preceeds the panic on the console:

megaraid: ABORTING-a28b2 cmd=2a <c=0 t=11 l=0>                              
megaraid: ABORTING-a28b2[38], fw owner.       
megaraid: ABORTING-a28b3 cmd=2a <c=0 t=11 l=0>
megaraid: ABORTING-a28b3[35], fw owner.       
[a few more screens of this]
megaraid: reservation reset failed.    
megaraid: RESET-a28b2 cmd=2a <c=0 t=11 l=0>
megaraid: RESET-a28b2[38], fw owner.       
megaraid: reservation reset failed. 
megaraid: RESET-a28b2 cmd=2a <c=0 t=11 l=0>
megaraid: RESET-a28b2[38], fw owner.       
megaraid: reservation reset failed. 


I've been able to reproduce the problem by untarring several large files
on the lvm2 volume simultaneously.

Let me know if there's any additional information I can give.

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://developer.osdl.org/markw/
