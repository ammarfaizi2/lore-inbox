Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSGGKei>; Sun, 7 Jul 2002 06:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSGGKeh>; Sun, 7 Jul 2002 06:34:37 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:7859 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315278AbSGGKee>; Sun, 7 Jul 2002 06:34:34 -0400
Date: Sun, 7 Jul 2002 12:55:11 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ide__sti induced deadlock?
Message-ID: <Pine.LNX.4.44.0207071254310.1441-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart, Martin
	This looks like it might be the work of ide__sti

CPU:    0
EIP:    0010:[<c02507f1>]    Not tainted
EFLAGS: 00000086
eax: c0256a90   ebx: c15d2d34   ecx: c15d2ce4   edx: cd5b1de8
esi: c0455d9c   edi: cd5b0000   ebp: 0000000f   esp: cd5b1d84
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 686, threadinfo=cd5b0000 task=cdb40080)
Stack: c0256a90 00000286 c15d2ce4 00000000 04000001 0000000f c0109bae 0000000f
       c0455d9c cd5b1de8 cd5b0000 c03ea9e0 c03ea9f0 0000000f c0109f1b 0000000f
       cd5b1de8 c15d2ce4 c15d2ce4 00000000 cd5b0000 c0455ee4 cd5b0000 c0430c40
Call Trace: [<c0256a90>] [<c0109bae>] [<c0109f1b>] [<c0107efa>] [<c0230dbf>]
   [<c023113d>] [<c014b235>] [<c0117730>] [<c0188ba0>] [<c01175cb>] [<c0117730>] 

   [<c018b386>] [<c018b140>] [<c01057f6>] [<c018b160>]

Code: 80 3b 00 f3 90 7e f9 e9 33 fb ff ff 80 3f 00 f3 90 7e f9 e9

>>EIP; c02507f1 <.text.lock.ide+3c/6b>   <=====
Trace; c0256a90 <task_out_intr+0/210>
Trace; c0109bae <handle_IRQ_event+5e/90>
Trace; c0109f1b <do_IRQ+11b/1e0>
Trace; c0107efa <common_interrupt+22/28>
Trace; c0230dbf <generic_unplug_device+14f/170>
Trace; c023113d <blk_run_queues+13d/150>
Trace; c014b235 <__wait_on_buffer+65/a0>
Trace; c0117730 <default_wake_function+0/40>
Trace; c0188ba0 <journal_commit_transaction+ea0/1485>
Trace; c01175cb <schedule+3cb/4f0>
Trace; c0117730 <default_wake_function+0/40>
Trace; c018b386 <kjournald+226/360>
Trace; c018b140 <commit_timeout+0/10>
Trace; c01057f6 <kernel_thread+26/30>
Trace; c018b160 <kjournald+0/360>
Code;  c02507f1 <.text.lock.ide+3c/6b>
00000000 <_EIP>:
Code;  c02507f1 <.text.lock.ide+3c/6b>   <=====
   0:   80 3b 00                  cmpb   $0x0,(%ebx)   <=====
Code;  c02507f4 <.text.lock.ide+3f/6b>
   3:   f3 90                     repz nop
Code;  c02507f6 <.text.lock.ide+41/6b>
   5:   7e f9                     jle    0 <_EIP>
Code;  c02507f8 <.text.lock.ide+43/6b>
   7:   e9 33 fb ff ff            jmp    fffffb3f <_EIP+0xfffffb3f> c0250330
<ata_irq_request+50/230>
Code;  c02507fd <.text.lock.ide+48/6b>
   c:   80 3f 00                  cmpb   $0x0,(%edi)
Code;  c0250800 <.text.lock.ide+4b/6b>
   f:   f3 90                     repz nop
Code;  c0250802 <.text.lock.ide+4d/6b>
  11:   7e f9                     jle    c <_EIP+0xc> c02507fd
<.text.lock.ide+48/6b>
Code;  c0250804 <.text.lock.ide+4f/6b>
  13:   e9 00 00 00 00            jmp    18 <_EIP+0x18> c0250809
<.text.lock.ide+54/6b>


-- 
function.linuxpower.ca

