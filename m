Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268102AbTB1SWi>; Fri, 28 Feb 2003 13:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268105AbTB1SWi>; Fri, 28 Feb 2003 13:22:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5770 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268102AbTB1SWg>; Fri, 28 Feb 2003 13:22:36 -0500
Date: Fri, 28 Feb 2003 10:32:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 421] New: Panic from detach_pid 
Message-ID: <30210000.1046457175@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=421

           Summary: Panic from detach_pid
    Kernel Version: 2.5.63
            Status: NEW
          Severity: blocking
             Owner: rml@tech9.net
         Submitter: jkenefic@us.ibm.com


Distribution: 
 RedHat 8.0

Hardware Environment:  
 x86 8 processor system with 12Gb ram 
 2 30gb scsi, intel pro 1000
 and 5 client systems

Software Environment:  
 MySql server on 8-way, version 3.23.52-3
 dbgrinder.pl from ltp.sf.net on clients

Problem Description:
 A MySql database server running on an 8-way x86 system with load
 driven from 5 clients (7 instances of dbgrinder.pl on each system)
 produces the following panic.

oops   :  0002
cpu    :  5
eip    :  0060:[<c0131254>] Not tainted
eflags :  00010046
eip is at detach_pid + 0x1c/0xd4

eax: 6b6b6b6b ebx: 00000002 ecx: 6b6b6b6b edx: 6b6b6b6b
esi: edce6720 edi: 00004570 ebp: e0a05f1c exp: e0a05f10
ds: 007b es: 007b ss: 0068

Process mysqld (pid: 919, threadinfo=e0a04000 task=cafb7380)
Stack: edce6720 edce6720 00004570 e0a05f28 c01210d9 edcd6720 e0a05f44 c012127a
       edce6720 edce6720 edce6720 00000000 edce6729 e0a05f64 c0122dfa edce6720
       cafb741c edce67c4 edce6720 00000000 00000246 e0a05fbc c0123143 edce6720

Call Trace:
[<c01210d9>] --unhash_process +0x39/0x14c
[<c012127a>] release_task +0x8e/0x1a0
[<c0122dfa>] wait_task_zombie +0x19a/0x1b4
[<c0123143>] sys_wait4 +0x137/0x264
[<c011b518>] default_wake_function +0x0/0x1c
[<c0109297>] syscall_call +0x7/0xb

Code: 89 50 04 89 02 f0 ff 49 04 0f 94 c0 84 c0 0f 84 98 00 00 00
<6> Note: mysqld[919] exited with preempt_count 1


Steps to reproduce:

 1.)Install and start up Mysql on server,
 2.)Install dbgrinder.pl on 5 client systems
    Note: this will require DBI and DBD:mysql from cpan.org
 3.)Execute 7 instances of dbgringer.pl on each client all 
    pointed at the server, within 1 hour the server will panic


