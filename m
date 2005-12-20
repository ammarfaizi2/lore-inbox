Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVLTQI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVLTQI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVLTQI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:08:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750768AbVLTQI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:08:28 -0500
Message-ID: <43A82BAE.1010008@nc.rr.com>
Date: Tue, 20 Dec 2005 11:05:02 -0500
From: William Cohen <wcohen@nc.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: William Cohen <wcohen@redhat.com>, perfctr-devel@lists.sourceforge.net,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] 2.6.15-rc5-git3 perfmon2 new code base + libpfm
 available
References: <20051215104604.GA16937@frankl.hpl.hp.com> <43A1DE94.8050105@redhat.com> <20051215215921.GJ18331@frankl.hpl.hp.com> <43A1ECDF.9040200@nc.rr.com> <20051215231510.GC18796@frankl.hpl.hp.com>
In-Reply-To: <20051215231510.GC18796@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Will,
> 
> Ok, I found the two bugs you ran into. I also found
> a third one somewhat similar.
> 
> Could you try the attached patch on top of what
> you have?
> 
> I will check all the copy_from/to() tomorrow.
> 
> Thanks.

Have you tried running the examples without the kernel module installed? 
I think that one of the tracebacks in the earlier email was due to that. 
Like the following:

Dec 20 10:39:01 trek kernel: Call Trace:
Dec 20 10:39:01 trek kernel:  [<c0201ee7>] __pfm_create_context+0x167/0x440
Dec 20 10:39:01 trek kernel:  [<c010400c>] __switch_to+0x15c/0x220
Dec 20 10:39:01 trek kernel:  [<c0203f98>] sys_pfm_create_context+0x78/0xe0
Dec 20 10:39:01 trek kernel:  [<c010569d>] syscall_call+0x7/0xb

I tried the patch. Things are still not working on the p6 machine with 
the module installed. for "./task_smpl ls". The associated kernel backtrace:


Dec 20 10:29:47 trek kernel: Unable to handle kernel paging request at 
virtual address 6b6b6ba7
Dec 20 10:29:47 trek kernel:  printing eip:
Dec 20 10:29:47 trek kernel: c0202b51
Dec 20 10:29:47 trek kernel: *pde = 00000000
Dec 20 10:29:47 trek kernel: Oops: 0000 [#1]
Dec 20 10:29:47 trek kernel: SMP
Dec 20 10:29:47 trek kernel: Modules linked in: perfmon_p6 ipv6 lp 
autofs4 rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack 
nfnetlink iptable_filter ip_tables dm_mirror dm_mod video button battery 
ac parport_pc parport snd_cs46xx snd_seq_dummy snd_emu10k1_synth 
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_oss 
snd_seq_midi_event snd_emu10k1 snd_seq snd_rawmidi snd_pcm_oss 
snd_seq_device snd_mixer_oss snd_ac97_codec snd_ac97_bus snd_pcm 
snd_util_mem emu10k1_gp floppy gameport 3c59x snd_hwdep snd_timer snd 
snd_page_alloc soundcore mii uhci_hcd hw_random i2c_i801 shpchp i2c_core 
ext3 jbd
Dec 20 10:29:47 trek kernel: CPU:    1
Dec 20 10:29:47 trek kernel: EIP:    0060:[<c0202b51>]    Not tainted VLI
Dec 20 10:29:47 trek kernel: EFLAGS: 00010282   (2.6.15-rc5-git3-perfop)
Dec 20 10:29:47 trek kernel: EIP is at pfm_smpl_fmt_put+0x11/0x60
Dec 20 10:29:47 trek kernel: eax: d6cc3ab0   ebx: 6b6b6b6b   ecx: 
d8be87a0   edx: d8be8900
Dec 20 10:29:47 trek kernel: esi: d2434000   edi: 00000001   ebp: 
00000001   esp: d707cee0
Dec 20 10:29:47 trek kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 10:29:47 trek kernel: Process task_smpl (pid: 2574, 
threadinfo=d707c000 task=d6cc3ab0)
Dec 20 10:29:47 trek kernel: Stack: 00000001 c0205813 c0156569 6b000246 
c1336ae0 d2ab36e8 d2ab375c d7203548
Dec 20 10:29:47 trek kernel:        00000286 00000000 00000010 00000010 
d2ab375c d2b8ab58 d7203548 c0172475
Dec 20 10:29:47 trek kernel:        00000000 d2ab36e8 d7f8fb68 d2b8ab58 
d245dc7c d2f18664 d7276d9c 00000001
Dec 20 10:29:47 trek kernel: Call Trace:
Dec 20 10:29:47 trek kernel:  [<c0205813>] pfm_close+0x113/0x3d0
Dec 20 10:29:47 trek kernel:  [<c0156569>] poison_obj+0x29/0x60
Dec 20 10:29:47 trek kernel:  [<c0172475>] __fput+0xb5/0x1a0
Dec 20 10:29:47 trek kernel:  [<c01625e9>] remove_vma+0x39/0x50
Dec 20 10:29:47 trek kernel:  [<c016477b>] exit_mmap+0xab/0x100
Dec 20 10:29:47 trek kernel:  [<c0123423>] mmput+0x33/0xa0
Dec 20 10:29:47 trek kernel:  [<c0128816>] do_exit+0xf6/0x3d0
Dec 20 10:29:47 trek kernel:  [<c0109da8>] do_syscall_trace+0x218/0x22a
Dec 20 10:29:47 trek kernel:  [<c0128b67>] do_group_exit+0x37/0xa0
Dec 20 10:29:47 trek kernel:  [<c010569d>] syscall_call+0x7/0xb
Dec 20 10:29:47 trek kernel: Code: 00 01 00 00 ff 00 b8 80 4c 44 c0 e8 
aa d2 16 00 89 d8 5b c3 31 db eb ee 89 f6 85 c0 53 89 c3 74 39 b8 80 4c 
44 c0 e8 6f d2 16 00 <8b> 53 3c 85 d2 74 1b b8 00 f0 ff ff 21 e0 8b 40 
10 c1 e0 07 8d
Dec 20 10:29:47 trek kernel:  <1>Fixing recursive fault but reboot is 
needed!

-Will
