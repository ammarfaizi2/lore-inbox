Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVLOVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVLOVZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVLOVZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:25:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751111AbVLOVZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:25:50 -0500
Message-ID: <43A1DE94.8050105@redhat.com>
Date: Thu, 15 Dec 2005 16:22:28 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: perfctr-devel@lists.sourceforge.net, perfmon@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] 2.6.15-rc5-git3 perfmon2 new code base + libpfm
 available
References: <20051215104604.GA16937@frankl.hpl.hp.com>
In-Reply-To: <20051215104604.GA16937@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Hello,
> 
> I have released a new version of the perfmon base package.
> This release is relative to 2.6.15-rc5-git3.
> 
> I have also updated the library, libpfm-3.2, to match the kernel
> level changes. 

Hi Stephane,

I downloaded the new version of perfmon and the matching libpfm. I built 
everything on a p6 based machine. The kernel booted fine. I tried the 
task_smpl_user in the libpfm examples. That crashed the kernel. What was 
on the xterm:

$ ./task_smpl_user ls
measuring at plm=0x8
programming 2 PMCS and 2 PMDS
Segmentation fault

The related oops /var/log/messages:

Dec 15 15:54:40 trek kernel: Unable to handle kernel paging request at 
virtual address 6b6b6ba7
Dec 15 15:54:40 trek kernel:  printing eip:
Dec 15 15:54:40 trek kernel: c0202b51
Dec 15 15:54:40 trek kernel: *pde = 6b6b6b6b
Dec 15 15:54:40 trek kernel: Oops: 0000 [#1]
Dec 15 15:54:40 trek kernel: SMP
Dec 15 15:54:40 trek kernel: Modules linked in: ipv6 lp autofs4 rfcomm 
l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack nfnetlink 
iptable_filter ip_tables dm_mirror dm_mod video button battery ac 
parport_pc parport snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_cs46xx snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_emu10k1 
snd_seq_midi_event snd_seq snd_rawmidi snd_seq_device snd_pcm_oss 
snd_ac97_codec snd_mixer_oss snd_ac97_bus snd_pcm snd_util_mem floppy 
snd_hwdep snd_timer emu10k1_gp snd gameport soundcore snd_page_alloc 
3c59x mii i2c_i801 hw_random uhci_hcd shpchp i2c_core ext3 jbd
Dec 15 15:54:40 trek kernel: CPU:    0
Dec 15 15:54:40 trek kernel: EIP:    0060:[<c0202b51>]    Not tainted VLI
Dec 15 15:54:40 trek kernel: EFLAGS: 00010286   (2.6.15-rc5-git3-perfop)
Dec 15 15:54:40 trek kernel: EIP is at pfm_smpl_fmt_put+0x11/0x60
Dec 15 15:54:40 trek kernel: eax: d6ee6ab0   ebx: 6b6b6b6b   ecx: 
00000000   edx: 00000cf4
Dec 15 15:54:40 trek kernel: esi: cf9f2000   edi: 00000000   ebp: 
00000000   esp: cfc1ff00
Dec 15 15:54:40 trek kernel: ds: 007b   es: 007b   ss: 0068
Dec 15 15:54:40 trek kernel: Process task_smpl_user (pid: 2654, 
threadinfo=cfc1f000 task=d6ee6ab0)
Dec 15 15:54:40 trek kernel: Stack: ffffffda c0201ee7 00000000 c010400c 
d6ee6ab0 d6dea570 d6dea740 00000000
Dec 15 15:54:40 trek kernel:        d7010a34 00802140 00000000 00000000 
00000000 cfc1ff68 d2d5b9a4 00000000
Dec 15 15:54:40 trek kernel:        0000003c 00000000 cfc1f000 00000000 
cfc1ff68 00000000 cfc1f000 c0203f98
Dec 15 15:54:40 trek kernel: Call Trace:
Dec 15 15:54:40 trek kernel:  [<c0201ee7>] __pfm_create_context+0x167/0x440
Dec 15 15:54:40 trek kernel:  [<c010400c>] __switch_to+0x15c/0x220
Dec 15 15:54:40 trek kernel:  [<c0203f98>] sys_pfm_create_context+0x78/0xe0
Dec 15 15:54:40 trek kernel:  [<c010569d>] syscall_call+0x7/0xb
Dec 15 15:54:40 trek kernel: Code: 00 01 00 00 ff 00 b8 80 4c 44 c0 e8 
9a d2 16 00 89 d8 5b c3 31 db eb ee 89 f6 85 c0 53 89 c3 74 39 b8 80 4c 
44 c0 e8 5f d2 16 00 <8b> 53 3c 85 d2 74 1b b8 00 f0 ff ff 21 e0 8b 40 
10 c1 e0 07 8d


-Will
