Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269640AbUJGMbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269640AbUJGMbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUJGMbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:31:13 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:54598 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269811AbUJGMRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:17:37 -0400
Message-ID: <44510.195.245.190.93.1097151376.squirrel@195.245.190.93>
Date: Thu, 7 Oct 2004 13:16:16 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, "Florian Schmidt" <mista.tapas@gmx.net>,
       mark_h_johnson@raytheon.com,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> 
      <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>   
    <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>   
    <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>   
    <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>   
    <20041007105230.GA17411@elte.hu>
In-Reply-To: <20041007105230.GA17411@elte.hu>
X-OriginalArrivalTime: 07 Oct 2004 12:17:35.0078 (UTC) FILETIME=[A0B10060:01C4AC67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
>
> i've released the -T3 VP patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
>

Didn't try this yet on my desktop (where those USB troubles roared), but
on my laptop there's already a showstopper with while trying to start
beloved jackd -R:

---
Unable to handle kernel paging request at virtual address 00010024
 printing eip:
c011995f
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: realtime commoncap snd_seq_oss snd_seq_midi_event
snd_seq snd_pcm_oss snd_mixer_oss snd_usb_usx2y snd_usb_lib snd_rawmidi
snd_seq_device snd_hwdep snd_ali5451 snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd soundcore prism2_cs p80211 ds yenta_socket pcmcia_core
natsemi crc32 ohci1394 ieee1394 loop subfs evdev ohci_hcd usbcore thermal
processor fan button battery ac
CPU:    0
EIP:    0060:[<c011995f>]    Not tainted VLI
EFLAGS: 00010086   (2.6.9-rc3-mm3-T3.0)
EIP is at profile_hit+0x2f/0x33
eax: 00010024   ebx: de1f8510   ecx: 00000000   edx: 00000000
esi: 00000001   edi: ffffffea   ebp: db32ef88   esp: db32ef88
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process jackd (pid: 6519, threadinfo=db32e000 task=dec4fa00)
Stack: db32efbc c0115431 00000002 c0104231 00000004 c0398460 c0102d2f
007d0f00
       00000046 0000001e 00001979 b75a1bb0 b7fa5a4c db32e000 c0104231
00001979
       00000001 b75a1dac b75a1bb0 b7fa5a4c bfffb9b8 0000009c 0000007b
0000007b
Call Trace:
 [<c0115431>] setscheduler+0xc4/0x254
 [<c0104231>] sysenter_past_esp+0x52/0x71
 [<c0102d2f>] sys_clone+0x40/0x42
 [<c0104231>] sysenter_past_esp+0x52/0x71
Code: b8 60 ff ff 8b 0d ec 16 3a c0 8b 15 e8 16 3a c0 8b 45 0c 83 ea 01 2d
28 02 10 c0 d3 e8 39 c2 0f 46 c2 8b 15 e4 16 3a c0 8d 04 82 <ff> 00 5d c3
55 89 e5 e8 85 60 ff ff b8 da ff ff ff 5d c3 55 89
 <6>note: jackd[6519] exited with preempt_count 2
Debug: sleeping function called from invalid context jackd(6519) at
kernel/fork.c:421
in_atomic():1, irqs_disabled():0
 [<c0116385>] __might_sleep+0xb5/0xc5
 [<c011921c>] vprintk+0x135/0x182
 [<c0116927>] mm_release+0x72/0xcf
 [<c01190e5>] printk+0x1d/0x1f
 [<c011b3a6>] do_exit+0x85/0x506
 [<c0112f0e>] do_page_fault+0x0/0x67e
 [<c0105539>] do_divide_error+0x0/0x13a
 [<c0112f0e>] do_page_fault+0x0/0x67e
 [<c01190e5>] printk+0x1d/0x1f
 [<c01133a7>] do_page_fault+0x499/0x67e
 [<c01c54dd>] __copy_from_user_ll+0x11/0x76
 [<c012efbc>] check_preempt_timing+0x18f/0x1fb
 [<c012f1ce>] sub_preempt_count+0x5c/0x8b
 [<c0117869>] copy_process+0x610/0xcfe
 [<c010eca6>] sched_clock+0x14/0x8d
 [<c012f1ce>] sub_preempt_count+0x5c/0x8b
 [<c01146c3>] wake_up_new_task+0x142/0x190
 [<c012efbc>] check_preempt_timing+0x18f/0x1fb
 [<c012f1ce>] sub_preempt_count+0x5c/0x8b
 [<c01146c3>] wake_up_new_task+0x142/0x190
 [<c0117869>] copy_process+0x610/0xcfe
 [<c0117869>] copy_process+0x610/0xcfe
 [<c01146c3>] wake_up_new_task+0x142/0x190
 [<c01146c3>] wake_up_new_task+0x142/0x190
 [<c0112f0e>] do_page_fault+0x0/0x67e
 [<c0104c8d>] error_code+0x2d/0x38
 [<c011995f>] profile_hit+0x2f/0x33
 [<c0115431>] setscheduler+0xc4/0x254
 [<c0104231>] sysenter_past_esp+0x52/0x71
 [<c0102d2f>] sys_clone+0x40/0x42
 [<c0104231>] sysenter_past_esp+0x52/0x71
scheduling while atomic: jackd/0x04000002/6519
 [<c02d21cc>] schedule+0x554/0x5f5
 [<c02d27f4>] cond_resched+0x5f/0x7f
 [<c011692c>] mm_release+0x77/0xcf
 [<c01190e5>] printk+0x1d/0x1f
 [<c011b3a6>] do_exit+0x85/0x506
 [<c0112f0e>] do_page_fault+0x0/0x67e
 [<c0105539>] do_divide_error+0x0/0x13a
 [<c0112f0e>] do_page_fault+0x0/0x67e
 [<c01190e5>] printk+0x1d/0x1f
 [<c01133a7>] do_page_fault+0x499/0x67e
 [<c01c54dd>] __copy_from_user_ll+0x11/0x76
 [<c012efbc>] check_preempt_timing+0x18f/0x1fb
 [<c012f1ce>] sub_preempt_count+0x5c/0x8b
 [<c0117869>] copy_process+0x610/0xcfe
 [<c010eca6>] sched_clock+0x14/0x8d
 [<c012f1ce>] sub_preempt_count+0x5c/0x8b
 [<c01146c3>] wake_up_new_task+0x142/0x190
 [<c012efbc>] check_preempt_timing+0x18f/0x1fb
 [<c012f1ce>] sub_preempt_count+0x5c/0x8b
 [<c01146c3>] wake_up_new_task+0x142/0x190
 [<c0117869>] copy_process+0x610/0xcfe
 [<c0117869>] copy_process+0x610/0xcfe
 [<c01146c3>] wake_up_new_task+0x142/0x190
 [<c01146c3>] wake_up_new_task+0x142/0x190
 [<c0112f0e>] do_page_fault+0x0/0x67e
 [<c0104c8d>] error_code+0x2d/0x38
 [<c011995f>] profile_hit+0x2f/0x33
 [<c0115431>] setscheduler+0xc4/0x254
 [<c0104231>] sysenter_past_esp+0x52/0x71
 [<c0102d2f>] sys_clone+0x40/0x42
 [<c0104231>] sysenter_past_esp+0x52/0x71
---

This jackd crash seems to show up due to CONFIG_DEBUG_PREEMPT being set
on, but not sure yet.

CU
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org




