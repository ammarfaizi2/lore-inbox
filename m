Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318631AbSHAGF5>; Thu, 1 Aug 2002 02:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318638AbSHAGF5>; Thu, 1 Aug 2002 02:05:57 -0400
Received: from [196.26.86.1] ([196.26.86.1]:11981 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318631AbSHAGF4>; Thu, 1 Aug 2002 02:05:56 -0400
Date: Thu, 1 Aug 2002 08:26:54 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: eject causes null null deref in wait_for_completion
Message-ID: <Pine.LNX.4.44.0208010825080.2454-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC eject with a CD does this, Looks odd.

Unable to handle kernel NULL pointer dereference at virtual address 00000011
c011832a
*pde = 0662e001
Oops: 0002
CPU:    0
EIP:    0010:[<c011832a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: c5d7a000
esi: c5d7bf28   edi: c5d7bf2c   ebp: c5d7befc   esp: c5d7beb0
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 ce14e660 c0117f30 00000000 00000000 c026ab54 c047832c cf5e5e04
       00000001 ce14e660 c0117f30 c5d7bf34 c5d7bf34 c5d7a000 c5d7bf28 c0243839
       00000000 c0478340 cf5e5e04 c5d7bf28 c024639f c0478340 00000000 00000001
Call Trace: [<c0117f30>] [<c026ab54>] [<c0117f30>] [<c0243839>] [<c024639f>]
   [<c011aa5f>] [<c0246433>] [<c0155a7a>] [<c015e687>] [<c014c5e6>] [<c010778f>]
Code: ff 43 10 81 7f 04 ad 4e ad de 74 1a 68 24 83 11 c0 68 d3 43

>>EIP; c011832a <wait_for_completion+11a/1d0>   <=====
Trace; c0117f30 <default_wake_function+0/40>
Trace; c026ab54 <do_ide_request+364/420>
Trace; c0117f30 <default_wake_function+0/40>
Trace; c0243839 <generic_unplug_device+119/170>
Trace; c024639f <blk_do_rq+7f/a0>
Trace; c011aa5f <__put_task_struct+1f/30>
Trace; c0246433 <block_ioctl+73/90>
Trace; c0155a7a <blkdev_ioctl+aa/100>
Trace; c015e687 <sys_ioctl+277/2fa>
Trace; c014c5e6 <sys_open+66/70>
Trace; c010778f <syscall_call+7/b>
Code;  c011832a <wait_for_completion+11a/1d0>
00000000 <_EIP>:
Code;  c011832a <wait_for_completion+11a/1d0>   <=====
   0:   ff 43 10                  incl   0x10(%ebx)   <=====
Code;  c011832d <wait_for_completion+11d/1d0>
   3:   81 7f 04 ad 4e ad de      cmpl   $0xdead4ead,0x4(%edi)
Code;  c0118334 <wait_for_completion+124/1d0>
   a:   74 1a                     je     26 <_EIP+0x26> c0118350 
<wait_for_completion+140/1d0>
Code;  c0118336 <wait_for_completion+126/1d0>
   c:   68 24 83 11 c0            push   $0xc0118324
Code;  c011833b <wait_for_completion+12b/1d0>
  11:   68 d3 43 00 00            push   $0x43d3

0xc011832a is in wait_for_completion (sched.c:1098).
1093                    __add_wait_queue_tail(&x->wait, &wait);
1094                    do {
1095                            __set_current_state(TASK_UNINTERRUPTIBLE);
1096                            spin_unlock_irq(&x->wait.lock);
1097                            schedule();
1098                            spin_lock_irq(&x->wait.lock);
1099                    } while (!x->done);
1100                    __remove_wait_queue(&x->wait, &wait);
1101            }
1102            x->done--;

-- 
function.linuxpower.ca

