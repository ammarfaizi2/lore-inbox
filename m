Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUISSWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUISSWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 14:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUISSWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 14:22:16 -0400
Received: from pandora.x256.com ([66.28.104.9]:5539 "EHLO nexus.x256.com")
	by vger.kernel.org with ESMTP id S261711AbUISSWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 14:22:10 -0400
Date: Sun, 19 Sep 2004 11:22:18 -0700
From: hb@nexus.x256.com
To: linux-kernel@vger.kernel.org
Subject: Oops in Powermate driver 2.4.28-pre3
Message-ID: <20040919182218.GA5286@nexus.x256.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Hi, here is my Oops. It happens reliably from five minutes to two hours
after I boot with my RAID resyncing and constant I/O to the Powermate
device:

kernel BUG at sched.c:564!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011acb7>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286
eax: 00000018   ebx: cfcfdc5c   ecx: 00000000   edx: 00000001
esi: 00000000   edi: 00000000   ebp: ccf95b70   esp: ccf95b40
ds: 0018   es: 0018   ss: 0018
Process jukebox (pid: 1764, stackpage=ccf95000)
Stack: c03c1f3a cfcfe040 00200286 00000001 ccf94000 c135f000 ccf94000 cfcfd864
       cf9cc5a0 cfcfdc5c ccf94000 cfcfdc64 ccf95b78 c01079c3 00000001 ccf94000
       cfcfdc68 cfcfdc68 cfcfdc5c cfcfd800 c135f020 00000002 c0107b6c cfcfdc5c
Call trace:    [<c01079c3>] [<c0107b6c>] [<c0334c06>] [<c0333d72>] [<c010ace9>]
  [<c010af09>] [<c010d688>] [<c02ed3b3>] [<c02eacba>] [<c02e5f5a>] [<c036b83d>]
  [<c02eac20>] [<c010ace9>] [<c010af09>] [<c010d688>] [<c02fdd4e>] [<c02fe1a1>]
  [<c030940a>] [<c02f773b>] [<c02f75b8>] [<c0123176>] [<c0123023>] [<c0122dd6>]
  [<c010af58>] [<c010d688>] [<c0330dcb>] [<c03264bd>] [<c03345c6>] [<c033480b>]
  [<c03348a8>] [<c0338e00>] [<c0339bce>] [<c0142b3b>] [<c0108efb>]
Code: 0f 0b 34 02 9b ce 3f c0 e9 27 fb ff ff 0f 0b 2d 02 9b ce 3f


>>EIP; c011acb7 <schedule+517/540>   <=====

>>ebx; cfcfdc5c <_end+f805690/10400a94>
>>ebp; ccf95b70 <_end+ca9d5a4/10400a94>
>>esp; ccf95b40 <_end+ca9d574/10400a94>

Trace; c01079c3 <__down+73/d0>
Trace; c0107b6c <__down_failed+8/c>
Trace; c0334c06 <.text.lock.powermate+5/3f>
Trace; c0333d72 <hc_interrupt+122/220>
Trace; c010ace9 <handle_IRQ_event+79/b0>
Trace; c010af09 <do_IRQ+99/f0>
Trace; c010d688 <call_do_IRQ+5/d>
Trace; c02ed3b3 <idedisk_end_request+63/f0>
Trace; c02eacba <ide_dma_intr+9a/c0>
Trace; c02e5f5a <ide_intr+ea/180>
Trace; c036b83d <tcp_write_space+9d/a0>
Trace; c02eac20 <ide_dma_intr+0/c0>
Trace; c010ace9 <handle_IRQ_event+79/b0>
Trace; c010af09 <do_IRQ+99/f0>
Trace; c010d688 <call_do_IRQ+5/d>
Trace; c02fdd4e <__scsi_end_request+4e/230>
Trace; c02fe1a1 <scsi_io_completion+161/3f0>
Trace; c030940a <rw_intr+5a/1d0>
Trace; c02f773b <scsi_finish_command+ab/c0>
Trace; c02f75b8 <scsi_bottom_half_handler+c8/100>
Trace; c0123176 <bh_action+46/70>
Trace; c0123023 <tasklet_hi_action+63/b0>
Trace; c0122dd6 <do_softirq+d6/e0>
Trace; c010af58 <do_IRQ+e8/f0>
Trace; c010d688 <call_do_IRQ+5/d>
Trace; c0330dcb <sohci_submit_urb+2fb/5c0>
Trace; c03264bd <usb_submit_urb+3d/40>
Trace; c03345c6 <powermate_sync_state+d6/1d0>
Trace; c033480b <powermate_pulse_led+db/100>
Trace; c03348a8 <powermate_input_event+78/80>
Trace; c0338e00 <input_event+250/320>
Trace; c0339bce <evdev_write+ae/e0>
Trace; c0142b3b <sys_write+ab/170>
Trace; c0108efb <system_call+33/38>

Code;  c011acb7 <schedule+517/540>
00000000 <_EIP>:
Code;  c011acb7 <schedule+517/540>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011acb9 <schedule+519/540>
   2:   34 02                     xor    $0x2,%al
Code;  c011acbb <schedule+51b/540>
   4:   9b                        fwait
Code;  c011acbc <schedule+51c/540>
   5:   ce                        into
Code;  c011acbd <schedule+51d/540>
   6:   3f                        aas
Code;  c011acbe <schedule+51e/540>
   7:   c0 e9 27                  shr    $0x27,%cl
Code;  c011acc1 <schedule+521/540>
   a:   fb                        sti
Code;  c011acc2 <schedule+522/540>
   b:   ff                        (bad)
Code;  c011acc3 <schedule+523/540>
   c:   ff 0f                     decl   (%edi)
Code;  c011acc5 <schedule+525/540>
   e:   0b 2d 02 9b ce 3f         or     0x3fce9b02,%ebp

 <0>Kernel panic: Aiee, killing interrupt handler!


It appears to be the same every time. As far as I can tell it is an
interrupt re-entrancy problem.

I've had stability problems with many different 2.6 kernel versions so I
would very much prefer to stick with 2.4 and this is the only issue I have
encountered so far. If I don't do any I/O with the powermate device my
system appears to be stable. That device is very important to this system and
I would greatly appreciate it if someone could help me solve this. Tomorrow
I will try to fix it myself but it involves a lot of trial and error as
sometimes the problem takes a couple of hours to manifest itself.

I believe I have included all the information that the appropriate person
needs to fix this problem but if not please contact me.

Thank you,

      Nicholas

