Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVKJUqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVKJUqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVKJUqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:46:31 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:47588 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932100AbVKJUqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:46:18 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Kernel BUG at mm/rmap.c:487
Date: Thu, 10 Nov 2005 20:46:03 +0000
User-Agent: KMail/1.8.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511102046.03290.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

I was searching the list today for the subject line and found a response you 
had written to Sandro Tosi on the 5th of this month.

I've had a similar oops on 2.6.14, my memory is checked and is okay, however I 
cannot say reliably whether it is a kernel bug because I had the proprietary 
NVIDIA driver loaded at the time, which I'm aware is a taboo on this list.

My system is entirely different from the reporter's, I'm running an x86-64 
kernel, non-SMP but with PREEMPT. I've reported this to linux-bugs@nvidia.com 
who told me simply that "preempt kernels have known stability issues". Having 
recompiled without preempt, I have not yet encountered the problem, but since 
it's so rare it's impossible to reproduce anyway.

Here's the oops (though it's from a tainted kernel, so I don't expect you to 
even look at it ;-)).

I'm going to run with the patch you posted for a few weeks to see if it 
happens again (just to tempt fate, I'll keep preempt enabled).

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/rmap.c:487
invalid operand: 0000 [1] PREEMPT
CPU 0
Modules linked in: loop isofs zlib_inflate yenta_socket rsrc_nonstatic 
pcmcia_core nvidia forcedeth usbhid ehci_hcd ohci_hcd usbcore amd64_agp 
agpgart nls_iso8859_15 nls_cp850 vfat fat nls_base snd_emu10k1 snd_rawmidi 
snd_ac97_codec snd_ac97_bus snd_util_mem snd_hwdep tuner tvaudio msp3400 bttv 
video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom videodev 
lirc_i2c lirc_dev snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss 
snd soundcore w83627hf hwmon_vid hwmon i2c_isa i2c_core
Pid: 6040, comm: wine Tainted: P      2.6.14 #1
RIP: 0010:[<ffffffff80168505>] <ffffffff80168505>{page_remove_rmap+37}
RSP: 0018:ffff810028f13dc0  EFLAGS: 00210286
RAX: 00000000ffffffff RBX: 0000000000000020 RCX: ffffffff803de360
RDX: 0000000000000000 RSI: ffff81003edd84c0 RDI: ffff8100017fc1c0
RBP: ffff8100017fc1c0 R08: 0000000056bcd000 R09: ffff810028f13eb0
R10: ffff810028f12000 R11: 0000000000200206 R12: ffff81002e271e48
R13: 0000000056bcd000 R14: 0000000056bc9000 R15: 0000000056bcd000
FS:  000000005565a920(006b) GS:ffffffff80408800(0063) knlGS:0000000055a72bb0
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 0000000056a361c0 CR3: 0000000025417000 CR4: 00000000000006a0
Process wine (pid: 6040, threadinfo ffff810028f12000, task ffff810017bb29b0)
Stack: ffffffff801613f1 ffff810028f13eb0 0000000056bcd000 0000000056bc9000
       ffff81003eefc3f8 ffff81003edd84c0 ffff810028f13eb8 0000000000008000
       0000000000000000 00000000885a0f40
Call Trace:<ffffffff801613f1>{unmap_vmas+1089} 
<ffffffff80164e5e>{unmap_region+174}
       <ffffffff80165749>{do_munmap+569} 
<ffffffff801a24b3>{compat_sys_ioctl+787}
       <ffffffff80165838>{sys_munmap+72} <ffffffff8011d1a3>{cstar_do_call+27}

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
