Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUJLQqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUJLQqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUJLQqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:46:11 -0400
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:59982 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S266128AbUJLQpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:45:50 -0400
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFBECDA4CA.06BA3FF5-ON86256F2B.005609F8@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Tue, 12 Oct 2004 11:39:33 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/12/2004 11:39:39 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i've uploaded -T7:
>
>
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T7

>
This crashes at boot time again. Several more scrolling messages that end
with
(all I can see on the screen)

Modules linked in: ext3 jbd
CPU:    1
EIP:    0060:[<c031563e>]    Not tainted VLI
EFLAGS: 00000046   (2.6.9-rc4-mm1-VP-T7)
EIP is at _spin_lock+0x43/0x70
eax: 00000001   ebx: c1406020   ecx: 0104ef60   edx: 00000001
esi: c166a000   edi: 00000002   ebp: c166bf04   esp: c166bef8
ds: 007b   es: 007b   ss: 0068   preempt: 00010002
Process ksoftirqd/1 (pid: 5, threadinfo=c166a000 task=c1659000)
Stack: 00000001 c1406020 c1436020 c166bf18 c011bbf0 c1436a00 c1406020
c1436a00
       c166bf48 c011c726 c1436020 c1406020 c166bf38 00000002 c1659000
c166bf48
       00000001 c1436a00 00000001 0104ef60 c166bfa4 c03146e3 00000001
c1436020
Call Trace:
 [<c011bbf0>] double_lock_balance+0x40/0x50
 [<c011c726>] load_balance_newidle+0x66/0xc0
 [<c03146e3>] schedule+0x733/0x830
 [<c0114b60>] mcount+0x14/0x18
 [<c01280c4>] ksoftirqd+0xd4/0xf0
 [<c013837b>] kthread_0xbb/0xc0
 [<c0127ff0>] ksoftirqd+0x0/0xf0
 [<c01382c0>] kthread+0x0/0xc0
 [<c0105b19>] kernel_thread_helper+0x5/0xc
Code: ff 21 e6 31 c0 86 03 84 c0 7e 0a 8b 5d f8 8b 75 fc 89 ec 5d c3 c7 04
24 01
 00 00 00 e8 0c 4d e2 ff 8b 46 08 a8 08 75 1e 8b 43 08 <85> c0 75 07 c7 43
08 01

Had to cycle power to get the machine back. Rebooting with max_cpus=1
crashed in a different way. Was able to get past mounting the disks and
some of the init script items before stopping at the same location with
a different call trace:

Call Trace:
 [<c011cb58>] scheduler_tick+0x148/0x490
 [<c012bee3>] update_process_times+0x43/0x60
 [<c0114b60>] mcount+0x14/0x18
 [<c012beef>] update_process_times_0x4f/0x60
 [<c0115141>] smp_apic_timer_interrupt+0xe1/0xf0
 [<c011cb73>] scheduler_tick+0x16e/0x490
 [<c010854a>] apic_timer_interrupt+0x1a/0x20
 [<c031007b>] unix_stream_recvmsg+0x5b/0x450
 [<c011cb7e>] scheduler_tick+0x16e/0x490
 [<c012bee3>] update_process_times+0x43/0x60
 [<c0114b60>] mcount+0x14/0x18
 [<c012beef>] update_process_times+0x4f/0x60
 [<c0115141>] smp_apic_timer_interrupt+0xe1/0xf0
 [<c01225d4>] release_console_sem+0x64/0xe0
 [<c012236d>] printk+0x1d/0x30

Will send you more messages if they made it to disk separately.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

