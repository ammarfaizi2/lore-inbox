Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWIJAiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWIJAiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 20:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWIJAiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 20:38:12 -0400
Received: from novell.stoldgods.nu ([83.150.147.20]:57565 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP id S965058AbWIJAiK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 20:38:10 -0400
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc6-mm1
Date: Sun, 10 Sep 2006 02:37:51 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
References: <200609091445.32744.novell@kiruna.se> <20060909112724.a214197b.akpm@osdl.org>
In-Reply-To: <20060909112724.a214197b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609100237.51822.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

On Saturday 09 September 2006 20:27, Andrew Morton wrote:
> On Sat, 9 Sep 2006 14:45:32 +0200
>
> Magnus M‰‰tt‰ <novell@kiruna.se> wrote:

> > I got this oops on my machine when I ran df on another one which
> > have mounted a few NFS shares from my machine. I got 5 more
> > pretty much identical ones within 10 seconds after the first one
> > (haven't seen any more after these though). Also, dmesg is filled
> > with, about a gazillion of these:
> > [15164.017991] RPC request reserved 9136 but used 9268
> > [15164.037431] RPC request reserved 9136 but used 9268
> > [15164.052988] RPC request reserved 9136 but used 9268
> >
> > Files are also getting corrupted when transfered from my machine,
> > but using my machine as client works fine.
>
> OK, so the NFS server isn't happy.
>
> > oops here:
> >
> > Error (regular_file): read_ksyms stat /proc/ksyms failed
>
> You don't need to run ksymoops at all in 2.6 - simply enable
> CONFIG_KALLSYMS and the kernel does the rest.

Oh, didn't know that!

> > No modules in ksyms, skipping objects
> > No ksyms, skipping lsmod
> > BUG: unable to handle kernel NULL pointer dereference at virtual
> > address 00000000
> > c04ad300
> > *pde = 00000000
> > Oops: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[<c04ad300>]    Tainted: P      VLI
>
> What caused the taint?

I was pretty sure it was listed somewhere, but I guess it wasn't.
nvidia graphics module, I can try without it tomorrow if needed.

Ah, it was only listed in the original one:

[  218.012273] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
[  218.012289]  printing eip:
[  218.012292] c04ad300
[  218.012294] *pde = 00000000
[  218.012302] Oops: 0000 [#1]
[  218.021009] 4K_STACKS PREEMPT
[  218.030577] last sysfs file: /class/input/input1/name
[  218.046224] Modules linked in: snd_seq_midi snd_seq_oss ipaq usbserial nvidia agpgart eeprom snd_seq_dummy snd_pcm_oss snd_mixer_oss snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_page_alloc snd_util_mem snd_hwdep psmouse
[  218.142717] CPU:    0
[  218.142718] EIP:    0060:[<c04ad300>]    Tainted: P      VLI
[  218.142720] EFLAGS: 00210212   (2.6.18-rc6-mm1 #1)
[  218.182388] EIP is at svc_process+0x40/0x6a0
[  218.195608] eax: 00000000   ebx: e5299000   ecx: 00000000   edx: e8843620
[  218.216639] esi: e5299070   edi: ffff84de   ebp: e52a0fb0   esp: e52a0f70
[  218.237666] ds: 007b   es: 007b   ss: 0068
[  218.250352] Process nfsd (pid: 5040, ti=e52a0000 task=e52a5570 task.ti=e52a0000)
[  218.272754] Stack: 00200046 eb499aa0 00000001 eb499a84 00000000 e52a0f9c c04eaa1b eb499a84
[  218.299267]        00000001 e8843620 e529904c e52a0fb0 c012d70b 00000002 ffff84de ffff84de
[  218.325781]        e52a0fe0 c02784ba e5299000 e52a0fc4 00000000 fffffeff ffffffff fffffef8
[  218.352294] Call Trace:
[  218.360459]  [<c01041bf>] show_trace_log_lvl+0x2f/0x50
[  218.394276]  [<c01042a7>] show_stack_log_lvl+0x97/0xc0
[  218.428065]  [<c0104532>] show_registers+0x1f2/0x2a0
[  218.461416]  [<c01047dd>] die+0x12d/0x240
[  218.491904]  [<c011735c>] do_page_fault+0x3ac/0x650
[  218.525178]  [<c04eaeef>] error_code+0x3f/0x44
[  218.557331]  [<c02784ba>] nfsd+0x18a/0x2b0
[  218.588522]  [<c0103fb7>] kernel_thread_helper+0x7/0x10
[  218.623405]  =======================
[  218.653244] Code: 89 45 e8 8b 52 28 83 c6 70 89 55 e4 8b 40 04 83 f8 17 0f 86 6d 04 00 00 8b 5d 08 8b 83 9c 04 00 00 c7 83 a0 04 00 00 01 00 00 00 <8b> 00 89 04 24 e8 06 d4 ca ff c7 46 04 00 00 00 00 89 c1 89 43
[  218.755843] EIP: [<c04ad300>] svc_process+0x40/0x6a0 SS:ESP 0068:e52a0f70



Regards,
Magnus M‰‰tt‰
