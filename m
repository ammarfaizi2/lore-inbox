Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbULOLfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbULOLfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 06:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbULOLfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 06:35:37 -0500
Received: from holomorphy.com ([207.189.100.168]:36798 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262329AbULOLf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 06:35:29 -0500
Date: Wed, 15 Dec 2004 03:35:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
Message-ID: <20041215113515.GJ771@holomorphy.com>
References: <20041213020319.661b1ad9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213020319.661b1ad9.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 02:03:19AM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/
> - Lots of new patches, lots of little fixes all over the place.
> - Probably the major change is the readahead rework, which may have
>   significant performance impacts on some workloads.  Not necessarily good,
>   either...
> - See below for the list of 31 patches which I have pending for 2.6.10.  If
>   there are other patches here which should go in, please let me know.

This appears to have trouble on em64t; not only does the following happen,
but some odd userspace programs (e.g. ssh) appear to be failing.

Shutting down powersaved                                                       cut here ] --------- [please bite here ] ---------
KDdoneernel BUG at pageattr:156
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in: joydev st sr_mod floppy usbserial parport_pc lp parport thermal processor fan button battery snd_intel8x0 snd_ac97_codec snd_pcm ac snd_timer ipv6 snd soundcore snd_page_alloc usbhid af_packet i2c_i801 i2c_core hw_random e1000 uhci_hcd usbcore evdev dm_mod ext3 jbd aic79xx ata_piix libata sd_mod scsi_mod
P
Unloid: 20985, comm: rmmod Not tainted 2.6.10-rc3-mm1
fffffff8012169a>{__change_page_attr+730}69a>] s ()
RSP: 0018:ffff81017ae93cc8  EFLAGS: 00010282
AX: 00000000fec001e3 RBX: 8000000000000163 RCX: 0000000000000000
oRne                                               DX: 0000000000000054 RSI: 00000000000fec00 RDI: ffff81000000f000
R
Shutting downBP: 8000000000000163 R08: 03fffffffffff000 R09: 0000000000000000
Rsound driver10: ffff81017e1227c0 R11: 0000000000000001 R12: ffff8100010002a0
R13: ffff8100fec00000 R14: ffff81000000cfb0 R15: 0000000000000002
FS:  00002aaaaade26e0(0000) GS:ffffffff8054c580(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000058c13c CR3: 00000001793f3000 CR4: 00000000000006e0
Process rmmod (pid: 20985, threadinfo ffff81017ae92000, task ffff810170ade740)
Stack: ffff8100fec00000 00000000000fec00 0000000000000000 0000000000000001
       ffffffff7fffffff ffffffff801218ac 0000000000000000 0000000000000163
       8000000000000163 ffff81017cba8cc0
Call Trace:<ffffffff801218ac>{change_page_attr_addr+140} <ffffffff80120c7d>{iounmap+429}
       <ffffffff881fcc4e>{:snd_intel8x0:snd_intel8x0_free+254}
       <ffffffff8815b3d7>{:snd:snd_device_free+247} <ffffffff8815b4be>{:snd:snd_device_free_all+126}
       <ffffffff88156423>{:snd:snd_card_free+419} <ffffffff80197441>{dput+33}
       <ffffffff881fc5e1>{:snd_intel8x0:snd_intel8x0_remove+17}
       <ffffffff8022905c>{pci_device_remove+44} <ffffffff802807f7>{device_release_driver+119}
       <ffffffff802808ad>{bus_remove_driver+141} <ffffffff80281209>{driver_unregister+9}
       <ffffffff80229267>{pci_unregister_driver+23} <ffffffff801527c4>{sys_delete_module+500}
       <ffffffff8016e9ea>{sys_munmap+90} <ffffffff8010e4fe>{system_call+126}


Code: 0f 0b 8f 4a 37 80 ff ff ff ff 9c 00 41 8b 04 24 f6 c4 08 74
RIP <ffffffff8012169a>{__change_page_attr+730} RSP <ffff81017ae93cc8>

