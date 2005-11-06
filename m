Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVKFO7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVKFO7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 09:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVKFO7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 09:59:48 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:21164 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S1750914AbVKFO7s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 09:59:48 -0500
Date: Sun, 6 Nov 2005 16:59:47 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andi Kleen <ak@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@ScaleMP.com)" <shai@scalemp.com>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping - K3
Message-ID: <20051106145947.GH3423@mea-ext.zmailer.org>
References: <20051106131112.GE24739@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106131112.GE24739@granada.merseine.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 03:11:12PM +0200, Muli Ben-Yehuda wrote:
> Hi Andi,
> 
> Here's the latest version of the dma_ops patch, updated to address
> your comments. The patch is against Linus's tree as of a few minutes
> ago and applies cleanly to 2.6.14-git9. Tested on AMD64 with gart,
> swiotlb, nommu and iommu=off. There are still a few cleanups left, but
> I'd appreciate it if this could see wider testing at this
> stage. Please apply...

  Works mostly.
There is some problem which I am not sure of is it related
to this at all or not.  BUG report attached below.

My machine has 4 GB memory, and is ASUS A8N-SLI board with
Amd64 Athlon X2 processor on it.

     /Matti Aarnio


PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 58, io mem 0xca102000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usb 1-2: new high speed USB device using ehci_hcd and address 2
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at arch/x86_64/kernel/traps.c:336
invalid operand: 0000 [1] SMP 
CPU 0 
Modules linked in: ohci_hcd ehci_hcd tuner tvaudio msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx_risc tveeprom videodev ns558 gameport parport_pc parport i2c_nforce2 i2c_core shpchp snd_mpu401 snd_mpu401_uart snd_rawmidi snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ext3 jbd raid1 sata_nv sata_sil libata sd_mod scsi_mod
Pid: 17, comm: khubd Not tainted 2.6.14-git9 #1
RIP: 0010:[<ffffffff801108d0>] <ffffffff801108d0>{out_of_line_bug+0}
RSP: 0018:ffff810037eb7be0  EFLAGS: 00010206
RAX: ffffffff00000000 RBX: ffff81013dbee070 RCX: 000000013db02928
RDX: 000000013db02930 RSI: ffff81013db02928 RDI: ffff81000c90ad50
RBP: 000000013db02928 R08: 0000000000000000 R09: ffff81013dbee070
R10: 000000000000000f R11: ffffffff802320b0 R12: ffff81013eff3178
R13: ffff81013dbee09c R14: ffff81013de7cad8 R15: 0000000000000010
FS:  00002aaaaaacf3f0(0000) GS:ffffffff80581800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaab8800f CR3: 000000013dab2000 CR4: 00000000000006e0
Process khubd (pid: 17, threadinfo ffff810037eb6000, task ffff810037e7e0c0)
Stack: ffffffff80232842 0000000000000400 ffffffff8051c4e0 0000000000000246 
       0000000000000246 000000000000537c ffffffff8013c358 ffff810037eb7cd8 
       ffffffff803c36c0 ffffffff8051c523 
Call Trace:<ffffffff80232842>{hcd_submit_urb+1938} <ffffffff8013c358>{release_console_sem+424}
       <ffffffff8013cfe0>{vprintk+800} <ffffffff802336bf>{usb_start_wait_urb+143}
       <ffffffff8017305f>{poison_obj+63} <ffffffff80172e1c>{dbg_redzone1+28}
       <ffffffff80233a6e>{usb_control_msg+254} <ffffffff8022f096>{hub_port_init+614}
       <ffffffff8023018c>{hub_thread+1548} <ffffffff80385d7f>{thread_return+95}
       <ffffffff8017305f>{poison_obj+63} <ffffffff80153b80>{autoremove_wake_function+0}
       <ffffffff8022fb80>{hub_thread+0} <ffffffff80153620>{keventd_create_kthread+0}
       <ffffffff801537eb>{kthread+219} <ffffffff801380fd>{schedule_tail+77}
       <ffffffff8010fdf6>{child_rip+8} <ffffffff80153620>{keventd_create_kthread+0}
       <ffffffff80153710>{kthread+0} <ffffffff8010fdee>{child_rip+0}

Code: 0f 0b 68 ad 46 3a 80 c2 50 01 c3 66 66 90 66 90 48 83 ec 18 
RIP <ffffffff801108d0>{out_of_line_bug+0} RSP <ffff810037eb7be0>
