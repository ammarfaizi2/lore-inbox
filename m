Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVAUUjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVAUUjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVAUUhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:37:43 -0500
Received: from mail4.utc.com ([192.249.46.193]:51355 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262500AbVAUUe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:34:59 -0500
Message-ID: <41F1675C.2010300@cybsft.com>
Date: Fri, 21 Jan 2005 14:34:36 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>, Bill Huey <bhuey@lnxw.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc1-V0.7.35-00
References: <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu>
In-Reply-To: <20050115133454.GA8748@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.35-00 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> The two dozen split out latency patches (including PREEMPT_BKL) that
> were in -mm are in BK now, so i've rebased the -RT patchset to
> 2.6.11-rc1. It would be nice to check for regressions (or the lack of
> them), to make sure everything latency-related has been properly merged
> upstream from -mm. (so that a new splitup cycle can start.)
> 

Ingo,

I just thought I would mention something that I have been experiencing 
with the last few versions of your patches on my workstation at the 
office. On my 2.6 dual xeon, if I have CONFIG_MICROCODE=m
I have had a heck of a time getting the -V0.7.35-02,03 kernels to boot. 
After disabling CONFIG_MICROCODE -V0.7.35-03 boots fine now. I tried 
this after finding the following in my log after a successful boot of 
-V0.7.35-01.

kr


Jan 21 11:53:50 swdev14 kernel: IA-32 Microcode Update Driver: v1.14 
<tigran@veritas.com>
Jan 21 11:53:50 swdev14 kernel: BUG: sleeping function called from 
invalid context hotplug(3795) at kernel/rt.c:1443
Jan 21 11:53:50 swdev14 kernel: BUG: scheduling while atomic: 
hotplug/0x00010000/3796
Jan 21 11:53:50 swdev14 smartd[4274]: smartd version 5.33 
[i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce Allen
Jan 21 11:53:51 swdev14 kernel: in_atomic():1 [00010000], irqs_disabled():1
Jan 21 11:53:51 swdev14 smartd[4274]: Home page is 
http://smartmontools.sourceforge.net/
Jan 21 11:53:51 swdev14 kernel:  [<c010366a>] <6>microcode: CPU3 updated 
from revision 0x0 to 0x38, date = 06042003
Jan 21 11:53:51 swdev14 smartd[4274]: Opened configuration file 
/etc/smartd.conf
Jan 21 11:53:51 swdev14 kernel: dump_stack+0x23/0x25 (20)
Jan 21 11:53:51 swdev14 smartd[4274]: Configuration file 
/etc/smartd.conf parsed.
Jan 21 11:53:51 swdev14 kernel:  [<c01180fa>] 
__might_sleep+0xd8/0xf3caller is schedule+0x38/0x12f
Jan 21 11:53:51 swdev14 smartd[4274]: Device: /dev/hda, opened
Jan 21 11:53:51 swdev14 kernel:  (36)
Jan 21 11:53:51 swdev14 kernel:  [<c0133bd0>]  [<c010366a>] 
__spin_lock+0x34/0x50 (24)
Jan 21 11:53:51 swdev14 kernel:  [<c0133c66>] 
_spin_lock_irqsave+0x1d/0x21dump_stack+0x23/0x25 (20)
Jan 21 11:53:51 swdev14 kernel:  [<c02a2376>] __schedule+0xa86/0xd95 (16)
Jan 21 11:53:51 swdev14 smartd[4274]: Device: /dev/hda, found in smartd 
database.
Jan 21 11:53:51 swdev14 kernel:  [<e08c872f>]  (120)
Jan 21 11:53:51 swdev14 kernel:  [<c02a26bd>] do_update_one+0x4e/0xb7 
[microcode] (44)
Jan 21 11:53:51 swdev14 smartd[4274]: Device: /dev/hda, is SMART 
capable. Adding to "monitor" list.
Jan 21 11:53:51 swdev14 kernel:  [<c010e6d0>] 
schedule+0x38/0x12fsmp_call_function_interrupt+0x45/0x65 (24)
Jan 21 11:53:51 swdev14 smartd[4274]: Monitoring 1 ATA and 0 SCSI devices
Jan 21 11:53:51 swdev14 kernel:  [<c01031ec>] 
call_function_interrupt+0x1c/0x24 (36)
Jan 21 11:53:51 swdev14 kernel:  [<c02a38f2>] __down_mutex+0x2aa/0x35a (176)
Jan 21 11:53:51 swdev14 kernel:  [<c0167f5f>]  (88)
Jan 21 11:53:51 swdev14 kernel: sys_fstat64+0x37/0x3d [<c0133be2>]  (100)
Jan 21 11:53:51 swdev14 smartd[4276]: smartd has fork()ed into 
background mode. New PID=4276.
Jan 21 11:53:51 swdev14 smartd: smartd startup succeeded
Jan 21 11:53:51 swdev14 kernel: __spin_lock+0x46/0x50 (24)
Jan 21 11:53:51 swdev14 kernel:  [<c0133c66>] 
_spin_lock_irqsave+0x1d/0x21 [<c0102804>] syscall_call+0x7/0xb (16)
Jan 21 11:53:51 swdev14 kernel:  [<e08c872f>]  (-8124)
Jan 21 11:53:51 swdev14 kernel: do_update_one+0x4e/0xb7 [microcode] (44)
Jan 21 11:53:51 swdev14 kernel:  [<c010e6d0>] ---------------------------
Jan 21 11:53:51 swdev14 kernel: smp_call_function_interrupt+0x45/0x65 (24)
Jan 21 11:53:52 swdev14 kernel:  [<c01031ec>] 
call_function_interrupt+0x1c/0x24| preempt count: 00010001 ]
Jan 21 11:53:52 swdev14 kernel: | 1-level deep critical section nesting:
Jan 21 11:53:52 swdev14 kernel: ----------------------------------------
Jan 21 11:53:52 swdev14 kernel: .. [<c0136ebd>] ....  (124)
Jan 21 11:53:52 swdev14 kernel: print_traces+0x1b/0x52
Jan 21 11:53:52 swdev14 kernel: .....[<c010366a>] ..   ( <= 
dump_stack+0x23/0x25)
Jan 21 11:53:52 swdev14 kernel:  [<c01333f5>] up_mutex+0x89/0x100
Jan 21 11:53:52 swdev14 sshd:  succeeded
Jan 21 11:53:52 swdev14 kernel:  (40)
Jan 21 11:53:52 swdev14 kernel:  [<c014eadc>] <3>BUG: scheduling while 
atomic: hotplug/0x00010000/3795
Jan 21 11:53:52 swdev14 kernel: caller is schedule+0x38/0x12f
Jan 21 11:53:52 swdev14 kernel: do_no_page+0x197/0x3b6 (64)
Jan 21 11:53:52 swdev14 kernel:  [<c014ef6e>] 
handle_mm_fault+0x15a/0x191 [<c010366a>] dump_stack+0x23/0x25 (48)
Jan 21 11:53:52 swdev14 kernel:  [<c0112291>]  (20)
Jan 21 11:53:52 swdev14 kernel: do_page_fault+0x1fc/0x61b (216)
Jan 21 11:53:52 swdev14 kernel:  [<c0103293>] error_code+0x2b/0x30 
[<c02a2376>] __schedule+0xa86/0xd95 (-518059332)
Jan 21 11:53:52 swdev14 kernel: ---------------------------
Jan 21 11:53:52 swdev14 kernel: | preempt count: 00010001 ]
Jan 21 11:53:52 swdev14 xinetd: xinetd startup succeeded
Jan 21 11:53:52 swdev14 kernel: | 1-level deep critical section nesting:
Jan 21 11:53:52 swdev14 kernel: ----------------------------------------
Jan 21 11:53:52 swdev14 kernel: .. [<c0136ebd>] ....  (120)
Jan 21 11:53:52 swdev14 ntpdate[4310]: can't find host wizard
Jan 21 11:53:52 swdev14 kernel: print_traces+0x1b/0x52
Jan 21 11:53:52 swdev14 kernel: .....[<c010366a>] ..   ( <= 
dump_stack+0x23/0x25)
Jan 21 11:53:52 swdev14 kernel:  [<c02a26bd>] schedule+0x38/0x12f
Jan 21 11:53:52 swdev14 kernel:  (36)
Jan 21 11:53:52 swdev14 kernel:  [<c02a38f2>] __down_mutex+0x2aa/0x35a (88)
Jan 21 11:53:52 swdev14 kernel:  [<c0133be2>] __spin_lock+0x46/0x50 (24)
Jan 21 11:53:52 swdev14 kernel:  [<c0133c66>] 
_spin_lock_irqsave+0x1d/0x21 (16)
Jan 21 11:53:52 swdev14 kernel:  [<e08c872f>] do_update_one+0x4e/0xb7 
[microcode] (44)
Jan 21 11:53:52 swdev14 kernel:  [<c010e6d0>] 
smp_call_function_interrupt+0x45/0x65 (24)
Jan 21 11:53:52 swdev14 kernel:  [<c01031ec>] 
call_function_interrupt+0x1c/0x24 (176)
Jan 21 11:53:52 swdev14 kernel:  [<c0167f5f>] sys_fstat64+0x37/0x3d (100)
Jan 21 11:53:52 swdev14 kernel:  [<c0102804>] syscall_call+0x7/0xb (-8124)
Jan 21 11:53:52 swdev14 kernel: ---------------------------
Jan 21 11:53:52 swdev14 kernel: | preempt count: 00010001 ]
Jan 21 11:53:52 swdev14 kernel: | 1-level deep critical section nesting:
Jan 21 11:53:52 swdev14 kernel: ----------------------------------------
Jan 21 11:53:52 swdev14 kernel: .. [<c0136ebd>] .... print_traces+0x1b/0x52
Jan 21 11:53:52 swdev14 kernel: .....[<c010366a>] ..   ( <= 
dump_stack+0x23/0x25)

