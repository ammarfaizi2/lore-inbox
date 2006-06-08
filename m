Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWFHKvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWFHKvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWFHKvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:51:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:14554 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932164AbWFHKvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:51:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sr7eEXX+k/2/184ox5mx3+r1xtia1h0atjGfryR5qUQYprAs582SCyrxruz2CHzVifK5BYGmWRZjlJ5RUVffaI3cIZNlL+tR8gMyxNwsw2OM0IQeNrzoti7gX974VNa5hG7VaHQnl1GohDZSQAihobP8W/wY49W/CG33+77pHd4=
Message-ID: <20f65d530606080351o1be35d15qc528f40c84e6279e@mail.gmail.com>
Date: Thu, 8 Jun 2006 22:51:17 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: IRQ sharing: BUG: spinlock lockup on CPU#0
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20f65d530606012317u7d49f476w4bfaa5b6cc08e94e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606020137_MC3-1-C164-9068@compuserve.com>
	 <20f65d530606012317u7d49f476w4bfaa5b6cc08e94e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We have updated all the 10 PCs kernel to 2.6.16.18. We only have 1 of
them running in IOAPIC mode (ie local APIC mode support), the rest are
in XT-PIC. The APIC machine crashed after 24 hours of operation. Below
is the stack trace. Is this related to the IO APIC, or should we be
worried about the XT-PIC machines too?

[4354161.283000] Unable to handle kernel NULL pointer dereference at virtual add
ress 00000008
[4354161.283000]  printing eip:
[4354161.283000] c0115dec
[4354161.283000] *pde = 00000000
[4354161.283000] Oops: 0002 [#1]
[4354161.283000] Modules linked in: zd1211 rt2570 autofs4 video button battery a
c uhci_hcd bt878 tuner tvaudio bttv video_buf compat_ioctl32 i2c_algo_bit v4l2_c
ommon btcx_risc ir_common tveeprom videodev i2c_i801 i2c_core snd_intel8x0 snd_a
c97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
 snd_page_alloc e100 mii dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod
[4354161.283000] CPU:    0
[4354161.283000] EIP:    0060:[<c0115dec>]    Not tainted VLI
[4354161.283000] EFLAGS: 00010017   (2.6.16.18 #3)
[4354161.283000] EIP is at scheduler_tick+0x76/0x287
[4354161.283000] eax: 00000000   ebx: 3fd1db7d   ecx: 6c53c678   edx: 000f7816
[4354161.283000] esi: ed103560   edi: 00000000   ebp: de18ba44   esp: de18ba28
[4354161.283000] ds: 007b   es: 007b   ss: 0068
[4354161.283000] Process ?.?? (pid: -1, threadinfo=de18a000 task=ed103560)
[4354161.283000] Stack: <0>00000000 de18ba40 2c9166c0 000f7816 ed103560 00000000
 00000000 de18ba54
[4354161.283000]        c0120aba de18bac4 00000000 de18ba64 c010588f 00000000 c0
33a3a0 de18ba8c
[4354161.283000]        c01357a5 00000000 00000000 de18bac4 de18bac4 00000000 c0
394b1c c0394b00
[4354161.283000] Call Trace:
[4354161.283000]  [<c0103951>] show_stack_log_lvl+0xa5/0xad
[4354161.283000]  [<c0103a8c>] show_registers+0x106/0x16f
[4354161.283000]  [<c0103c2e>] die+0xc1/0x13c
[4354161.283000]  [<c02dfd39>] do_page_fault+0x366/0x50e
[4354161.283000]  [<c01035ef>] error_code+0x4f/0x54
[4354161.283000]  [<c0120aba>] update_process_times+0x51/0x5e
[4354161.283000]  [<c010588f>] timer_interrupt+0x59/0x94
[4354161.283000]  [<c01357a5>] handle_IRQ_event+0x26/0x56
[4354161.283000]  [<c013584e>] __do_IRQ+0x79/0xcf
[4354161.283000]  [<c0104811>] do_IRQ+0x45/0x56
[4354161.283000]  [<c0103526>] common_interrupt+0x1a/0x20
[4354161.283000]  [<c013584e>] __do_IRQ+0x79/0xcf
[4354161.283000]  [<c0104811>] do_IRQ+0x45/0x56
[4354161.283000]  [<c0103526>] common_interrupt+0x1a/0x20
[4354161.283000]  [<c02dd492>] schedule+0x4b8/0x516
[4354161.283000]  [<f895e7bf>] videobuf_waiton+0xad/0x102 [video_buf]
[4354161.283000]  [<f89870af>] bttv_do_ioctl+0xb45/0x141e [bttv]
[4354161.283000]  [<f896a2be>] video_usercopy+0xb9/0x112 [videodev]
[4354161.283000]  [<f89879c4>] bttv_ioctl+0x3c/0x41 [bttv]
[4354161.283000]  [<c015ff68>] do_ioctl+0x48/0x52
[4354161.283000]  [<c016019a>] vfs_ioctl+0x16e/0x17d
[4354161.283000]  [<c01601ef>] sys_ioctl+0x46/0x63
[4354161.283000]  [<c0102a87>] sysenter_past_esp+0x54/0x75
[4354161.283000] Code: 48 8b 45 ec 8b 55 f0 3b 35 10 98 3d c0 a3 04 98 3d c0 89
15 08 98 3d c0 0f 84 16 02 00 00 a1 18 98 3d c0 39 46 28 74 0d 8b 46 04 <0f> ba
68 08 03 e9 ff 01 00 00 b8 e0 97 3d c0 e8 54 90 1c 00 8b
[4354161.283000]  <0>Kernel panic - not syncing: Fatal exception in interrupt
[4354161.283000]

Regards
Keith
