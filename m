Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVESKZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVESKZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 06:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVESKY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 06:24:29 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:33926 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S261166AbVESKYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 06:24:21 -0400
Message-ID: <00e301c55c5c$eb83d7c0$0101010a@dioxide>
From: "linux" <kernel@wired-net.gr>
To: "lkml" <linux-kernel@vger.kernel.org>
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <20050518234022.GA5112@stusta.de> <20050519012658.GA27595@ca-server1.us.oracle.com> <20050519094517.GD5112@stusta.de>
Subject: 2.4 kernel threads
Date: Thu, 19 May 2005 13:24:20 +0300
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

While attempting to unload the kernel module which has created a kernel
thread whoch runs perfectly i get this oops:
Unable to handle kernel paging request at virtual address d08f364c
 printing eip:
c011d6ff
*pde = 01af0067
*pte = 00000000
Oops: 0002
parport_pc lp parport autofs pcnet_cs 8390 crc32 ds yenta_socket pcmcia_core
floppy microcode ext3 jbd
CPU:    0
EIP:    0060:[<c011d6ff>]    Not tainted
EFLAGS: 00010092

EIP is at interruptible_sleep_on_timeout [kernel] 0x4f (2.4.21-4.EL)
eax: d08f3648   ebx: 00000286   ecx: 00000286   edx: d08f3648
esi: 000001c3   edi: 00000000   ebp: cc445fdc   esp: cc445fb4
ds: 0068   es: 0068   ss: 0068
Process enigma (pid: 1622, stackpage=cc445000)
Stack: 00000000 cc444000 d08f3648 d08f3648 00000000 00000003 00000656
00000656
       d08f3060 00000000 cc445fec d08f310d 00000004 cc444000 00000000
c010945d
       d08f363c 00000000 00000000
Call Trace:   [<c010945d>] kernel_thread_helper [kernel] 0x5 (0xcc445ff0)

Code: 89 50 04 89 02 c7 45 e4 00 00 00 00 c7 45 e0 00 00 00 00 53

Kernel panic: Fatal exception



The module is being unloaded with the following procedure:
lock_kernel();
flag=1; /* This flag does a break in the for(;;) loop of the thread after
the interruptible_sleep_on_timeout , after the break current=NULL;*/
mb();
kill_proc(pid_thread,SIGKILL,1);
unlock_kernel();
kill_proc(2,SIGCHLD,1); /* assuming that keventd is running with PID 2 */

