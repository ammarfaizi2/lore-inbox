Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWIJKXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWIJKXG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIJKXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:23:06 -0400
Received: from novell.stoldgods.nu ([83.150.147.20]:54936 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP
	id S1750704AbWIJKXD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:23:03 -0400
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc6-mm1
Date: Sun, 10 Sep 2006 12:22:54 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
References: <200609091445.32744.novell@kiruna.se> <200609100237.51822.novell@kiruna.se> <20060909223533.0bdcdc3f.akpm@osdl.org>
In-Reply-To: <20060909223533.0bdcdc3f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609101222.55217.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 07:35, Andrew Morton wrote:
> On Sun, 10 Sep 2006 02:37:51 +0200
> Magnus M‰‰tt‰ <novell@kiruna.se> wrote:
> 
> > > > EIP:    0060:[<c04ad300>]    Tainted: P      VLI
> > >
> > > What caused the taint?
> > 
> > I was pretty sure it was listed somewhere, but I guess it wasn't.
> > nvidia graphics module, I can try without it tomorrow if needed.
> > 
> 
> That would be appreciated thanks.
> 
> But first you'd need to ensure that it's a repeatable oops.  If
> it's not, the removing the nvidia driver won't tell us if the nvidia
> driver caused it.  (It almost certainly didn't).

Forgot to mention that I had this (well, I'm not 100% it was exactly the
same) oops with 2.6.18-rc5-mm1.

Here is the oops with an untainted kernel:

[  161.078154] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
[  161.104908]  printing eip:
[  161.133157] c04ad300
[  161.158755] *pde = 00000000
[  161.186042] Oops: 0000 [#2]
[  161.212933] 4K_STACKS PREEMPT
[  161.240791] last sysfs file: /class/input/input1/name
[  161.274954] Modules linked in: snd_seq_midi snd_seq_oss ipaq usbserial eeprom snd_seq_dummy snd_pcm_oss snd_mixer_oss snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_page_alloc snd_util_mem snd_hwdep psmouse
[  161.428307] CPU:    0
[  161.428308] EIP:    0060:[<c04ad300>]    Not tainted VLI
[  161.428310] EFLAGS: 00010216   (2.6.18-rc6-mm1 #1)
[  161.531660] EIP is at svc_process+0x40/0x6a0
[  161.566957] eax: 00000000   ebx: eaf8c000   ecx: 00000000   edx: ead74d40
[  161.610544] esi: eaf8c070   edi: ffff5225   ebp: eaf93fb0   esp: eaf93f70
[  161.654260] ds: 007b   es: 007b   ss: 0068
[  161.689932] Process nfsd (pid: 4655, ti=eaf93000 task=eaf9caa0 task.ti=eaf93000)
[  161.712308] Stack: 00000046 eeedefe0 00000001 eeedefc4 00000000 eaf93f9c c04eaa1b eeedefc4
[  161.762411]        00000001 ead74d40 eaf8c04c eaf93fb0 c012d70b 00000000 ffff5226 ffff5225
[  161.812643]        eaf93fe0 c02784ba eaf8c000 eaf93fc4 00000000 fffffeff ffffffff fffffef8
[  161.862772] Call Trace:
[  161.917732]  [<c01041bf>] show_trace_log_lvl+0x2f/0x50
[  161.956879]  [<c01042a7>] show_stack_log_lvl+0x97/0xc0
[  161.995482]  [<c0104532>] show_registers+0x1f2/0x2a0
[  162.033228]  [<c01047dd>] die+0x12d/0x240
[  162.067860]  [<c011735c>] do_page_fault+0x3ac/0x650
[  162.104983]  [<c04eaeef>] error_code+0x3f/0x44
[  162.140705]  [<c02784ba>] nfsd+0x18a/0x2b0
[  162.175232]  [<c0103fb7>] kernel_thread_helper+0x7/0x10
[  162.213210]  =======================
[  162.246050] Code: 89 45 e8 8b 52 28 83 c6 70 89 55 e4 8b 40 04 83 f8 17 0f 86 6d 04 00 00 8b 5d 08 8b 83 9c 04 00 00 c7 83 a0 04 00 00 01 00 00 00 <8b> 00 89 04 24 e8 06 d4 ca ff c7 46 04 00 00 00 00 89 c1 89 43
[  162.354045] EIP: [<c04ad300>] svc_process+0x40/0x6a0 SS:ESP 0068:eaf93f70


And oops #1 just in case it's not unrelated (and the BUG just after it):
[  105.928488] BUG: unable to handle kernel paging request at virtual address b79505a0
[  105.928503]  printing eip:
[  105.928506] c013d14c
[  105.928509] *pde = 2d268067
[  105.928511] *pte = 00000000
[  105.928518] Oops: 0000 [#1]
[  105.952628] 4K_STACKS PREEMPT
[  105.977498] last sysfs file: /class/input/input1/name
[  106.008548] Modules linked in: snd_seq_midi snd_seq_oss ipaq usbserial eeprom snd_seq_dummy snd_pcm_oss snd_mixer_oss snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_page_alloc snd_util_mem snd_hwdep psmouse
[  106.150657] CPU:    0
[  106.150658] EIP:    0060:[<c013d14c>]    Not tainted VLI
[  106.150660] EFLAGS: 00010002   (2.6.18-rc6-mm1 #1)
[  106.241322] EIP is at trace_hardirqs_on+0x1c/0x150
[  106.273081] eax: 00000001   ebx: b794fba0   ecx: b794f2e0   edx: b7f61410
[  106.310907] esi: 00000008   edi: b7c08ff4   ebp: eee0dfa4   esp: eee0df8c
[  106.348781] ds: 007b   es: 007b   ss: 0068
[  106.378378] Process icecast (pid: 4446, ti=eee0d000 task=ee9d0050 task.ti=eee0d000)
[  106.401560] Stack: eee0df9c 00000046 00000000 00000000 00000000 00000008 00000000 c01033ba
[  106.445119]        b7f61410 b794f2e0 00000000 00000000 b794f3b0 00000000 00000008 b7c08ff4
[  106.489043]        b794f388 00000000 0000007b 0000007b 00000033 000000af b7f61410 00000073
[  106.533124] Call Trace:
[  106.576870]  [<c01041bf>] show_trace_log_lvl+0x2f/0x50
[  106.610486]  [<c01042a7>] show_stack_log_lvl+0x97/0xc0
[  106.643976]  [<c0104532>] show_registers+0x1f2/0x2a0
[  106.676895]  [<c01047dd>] die+0x12d/0x240
[  106.707110]  [<c011735c>] do_page_fault+0x3ac/0x650
[  106.740133]  [<c04eaeef>] error_code+0x3f/0x44
[  106.771908]  [<c01033ba>] sysenter_past_esp+0x93/0x99
[  106.805629]  =======================
[  106.834887] Code: c7 05 94 9a 8b c0 01 00 00 00 89 e5 c9 c3 90 55 89 e5 56 53 83 ec 10 a1 a0 29 63 c0 65 8b 1d 00 00 00 00 85 c0 0f 84 89 00 00 00 <8b> b3 00 0a 00 00 85 f6 75 7f 8b 0d 94 9a 8b c0 85 c9 0f 84 96

[  106.978502]  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
[  107.023854] in_atomic():0, irqs_disabled():1
[  107.058071]  [<c01041bf>] show_trace_log_lvl+0x2f/0x50
[  107.095140]  [<c0104207>] show_trace+0x27/0x30
[  107.129851]  [<c0104334>] dump_stack+0x24/0x30
[  107.164377]  [<c011d442>] __might_sleep+0xa2/0xc0
[  107.199995]  [<c013949e>] down_read+0x1e/0x60
[  107.234807]  [<c012e9b7>] blocking_notifier_call_chain+0x17/0x50
[  107.275150]  [<c0121881>] profile_task_exit+0x21/0x30
[  107.312713]  [<c012327b>] do_exit+0x1b/0x520
[  107.348071]  [<c01048e5>] die+0x235/0x240
[  107.382754]  [<c011735c>] do_page_fault+0x3ac/0x650
[  107.419931]  [<c04eaeef>] error_code+0x3f/0x44
[  107.455575]  [<c01033ba>] sysenter_past_esp+0x93/0x99
[  107.492825]  =======================
