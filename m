Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWFHK2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWFHK2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWFHK2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:28:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:8250 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932143AbWFHK2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:28:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tWO5l2WFDA5JNzOwqiEMbcxRt7PjVEaoRd2YJMoqzn53fK+9A5/v9LsDq7xxsfwIZBvqopmrFymxYbQB3nb5lAqG2SM86LZaA+fhQkPWqFoPszioFiHLuRqAe6I5lA7mPmnVemJWx0VB0z4HJuKfc4U45zD5oUlSn6mTdsttWz0=
Message-ID: <6bffcb0e0606080328n1c58f562td20c1ef2bae76327@mail.gmail.com>
Date: Thu, 8 Jun 2006 12:28:42 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc6-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060607211455.GA6132@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060607211455.GA6132@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 07/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from
> the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

BUG at /usr/src/linux-rt/kernel/rtmutex.c:639!
------------[ cut here ]------------
kernel BUG at /usr/src/linux-rt/kernel/rtmutex.c:639!
invalid opcode: 0000 [#1]
PREEMPT SMP
Modules linked in: ipv6 w83627hf hwmon_vid hwmon i2c_isa af_packet
ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink
xt_tcpudp iptable_filter ip_tables x_tables p4_clockmod speedstep_lib
binfmt_misc thermal processor fan container parport_pc parport nvram
evdev sk98lin skge snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
snd_pcm_oss snd_mixer_oss i2c_i801 snd_pcm snd_timer snd soundcore
snd_page_alloc intel_agp ide_cd agpgart cdrom rtc unix
CPU:    1
EIP:    0060:[<c02ba67d>]    Not tainted VLI
EFLAGS: 00010202   (2.6.17-rc6-rt1 #9)
EIP is at rt_lock_slowlock+0x99/0x1b2
eax: 00000032   ebx: c60be1a0   ecx: c60be1c4   edx: 00000282
esi: eed13000   edi: f03481c8   ebp: eed13df8   esp: eed13d90
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process bash (pid: 2104, threadinfo=eed13000 task=eea54870
stack_left=3420 worst_left=-1)
Stack: c02cddd2 c02d4bb9 0000027f c015e320 c6226070 00000093 0000008c eed13dac
       eed13dac eed13db4 eed13db4 00000000 0000008c eed13dc4 eed13dc4 eed13dcc
       eed13dcc 00000000 00000000 11111111 11111111 11111111 11111111 ee516130
Call Trace:
 [<c0103f22>] show_stack_log_lvl+0x85/0x8f (36)
 [<c0104092>] show_registers+0x166/0x1e2 (60)
 [<c010445c>] die+0x17f/0x291 (52)
 [<c01045f7>] do_trap+0x89/0xa3 (32)
 [<c0104be7>] do_invalid_op+0x89/0x93 (180)
 [<c0103a07>] error_code+0x4f/0x54 (164)
 [<c02bad05>] rt_lock+0xb/0xd (8)
 [<c015e320>] kfree+0x30/0x86 (24)
 [<c01bd0f2>] selinux_task_free_security+0x1a/0x1c (8)
 [<c011d31c>] __put_task_struct+0x8d/0xc2 (12)
 [<c02b9910>] __schedule+0xebf/0xf01 (132)
 [<c02b99da>] preempt_schedule+0x3e/0x5e (16)
 [<c02bb227>] _raw_spin_unlock+0x23/0x25 (8)
 [<c02ba653>] rt_lock_slowlock+0x6f/0x1b2 (100)
 [<c02bad05>] rt_lock+0xb/0xd (8)
 [<c015ec9c>] kmem_cache_zalloc+0x4e/0xd9 (28)
 [<c015547d>] do_mmap_pgoff+0x340/0x5c7 (64)
 [<c01071e7>] sys_mmap2+0x87/0xa4 (36)
 [<c0102e73>] sysenter_past_esp+0x54/0x75 (-4020)
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c02b8acb>] .... __schedule+0x7a/0xf01
.....[<c02b99da>] ..   ( <= preempt_schedule+0x3e/0x5e)
.. [<c02bae55>] .... _raw_spin_lock+0x10/0x21
.....[<c02ba608>] ..   ( <= rt_lock_slowlock+0x24/0x1b2)
.. [<c02bae9a>] .... _raw_spin_lock_irqsave+0x14/0x3b
.....[<c010432c>] ..   ( <= die+0x4f/0x291)

Code: 00 e9 36 01 00 00 be 00 f0 ff ff 21 e6 8b 43 1c 83 e0 fc 3b 06
75 1f 68 7f 02 00 00 68 b9 4b 2d c0 68 d2 dd 2c c0 e8 7d 3f e6 ff <0f>
0b 7f 02 b9 4b 2d c0 83 c4 0c 8b 06 ba 04 00 00 00 87 10 89
EIP: [<c02ba67d>] rt_lock_slowlock+0x99/0x1b2 SS:ESP 0068:eed13d90
 <6>note: bash[2104] exited with preempt_count 2
BUG: soft lockup detected on CPU#1!
 [<c0104647>] show_trace+0xd/0xf (8)
 [<c010470c>] dump_stack+0x17/0x19 (12)
 [<c01438e1>] softlockup_tick+0xa2/0xb6 (32)
 [<c01272cf>] run_local_timers+0x12/0x14 (8)
 [<c0127430>] update_process_times+0x40/0x65 (20)
 [<c0132ec4>] handle_update+0x12/0x14 (8)
 [<c01115a7>] smp_apic_timer_interrupt+0x47/0x4f (12)
 [<c010393c>] apic_timer_interrupt+0x1c/0x24 (64)
 [<c02ba608>] rt_lock_slowlock+0x24/0x1b2 (100)
 [<c02bad05>] rt_lock+0xb/0xd (8)
 [<c015dd36>] kmem_cache_free+0x2e/0x51 (24)
 [<c0156f85>] anon_vma_unlink+0x4f/0x54 (20)
 [<c0153176>] free_pgtables+0x69/0x123 (36)
 [<c0153f59>] exit_mmap+0x9c/0x123 (48)
 [<c011be5b>] mmput+0x20/0x86 (16)
 [<c011f8a0>] exit_mm+0x110/0x118 (20)
 [<c0120dd0>] do_exit+0x1e5/0x89f (48)
 [<c0104548>] die+0x26b/0x291 (52)
 [<c01045f7>] do_trap+0x89/0xa3 (32)
 [<c0104be7>] do_invalid_op+0x89/0x93 (180)
 [<c0103a07>] error_code+0x4f/0x54 (164)
 [<c02bad05>] rt_lock+0xb/0xd (8)
 [<c015e320>] kfree+0x30/0x86 (24)
 [<c01bd0f2>] selinux_task_free_security+0x1a/0x1c (8)
 [<c011d31c>] __put_task_struct+0x8d/0xc2 (12)
 [<c02b9910>] __schedule+0xebf/0xf01 (132)
 [<c02b99da>] preempt_schedule+0x3e/0x5e (16)
 [<c02bb227>] _raw_spin_unlock+0x23/0x25 (8)
 [<c02ba653>] rt_lock_slowlock+0x6f/0x1b2 (100)
 [<c02bad05>] rt_lock+0xb/0xd (8)
 [<c015ec9c>] kmem_cache_zalloc+0x4e/0xd9 (28)
 [<c015547d>] do_mmap_pgoff+0x340/0x5c7 (64)
 [<c01071e7>] sys_mmap2+0x87/0xa4 (36)
 [<c0102e73>] sysenter_past_esp+0x54/0x75 (-4020)
---------------------------
| preempt count: 00010004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c02b8acb>] .... __schedule+0x7a/0xf01
.....[<c02b99da>] ..   ( <= preempt_schedule+0x3e/0x5e)
.. [<c02bae55>] .... _raw_spin_lock+0x10/0x21
.....[<c02ba608>] ..   ( <= rt_lock_slowlock+0x24/0x1b2)
.. [<c02bae55>] .... _raw_spin_lock+0x10/0x21
.....[<c02ba608>] ..   ( <= rt_lock_slowlock+0x24/0x1b2)
.. [<c02bae55>] .... _raw_spin_lock+0x10/0x21
.....[<c01438d1>] ..   ( <= softlockup_tick+0x92/0xb6)

Here is dmesg http://www.stardust.webpages.pl/files/rt/2.6.17-rc6-rt1/rt-dmesg
Here is config http://www.stardust.webpages.pl/files/rt/2.6.17-rc6-rt1/rt-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
