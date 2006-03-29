Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWC2IQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWC2IQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 03:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWC2IQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 03:16:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53590 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750773AbWC2IQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 03:16:36 -0500
Date: Wed, 29 Mar 2006 10:16:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, viro@ftp.linux.org.uk
Subject: Re: 2.6.16-git4: kernel BUG at block/ll_rw_blk.c:3497
Message-ID: <20060329081642.GU8186@suse.de>
References: <44288882.4020809@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44288882.4020809@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27 2006, Mark Lord wrote:
> This popped up during heavy RAID5 testing today (2.6.16-git4).
> The SATA drives are being run by a modified sata_mv that I'm testing,
> and it seems to be behaving now, except for the BUG below:
> 
> Cheers
> 
> ------------[ cut here ]------------
> kernel BUG at block/ll_rw_blk.c:3497!
> invalid opcode: 0000 [#1]
> PREEMPT SMP
> Modules linked in: sata_mv libata raid5 xor snd_pcm_oss snd_pcm snd_timer 
> snd_page_alloc snd_mixer_oss snd soundcore edd pl2303 usbserial usblp 
> usbhid evdev joydev sg sr_mod ide_cd cdrom af_packet ohci_hcd sworks_agp 
> agpgart e100 mii i2c_piix4 i2c_core usbcore sd_mod dm_mod scsi_mod
> CPU:    1
> EIP:    0060:[<b0209e76>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.16-git4 #1)
> EIP is at put_io_context+0x66/0x80
> eax: 00000000   ebx: b1ac096c   ecx: e3ced12c   edx: ef25b798
> esi: ed72a570   edi: ed72aa20   ebp: 00000000   esp: d2619f78
> ds: 007b   es: 007b   ss: 0068
> Process cat (pid: 16399, threadinfo=d2618000 task=ed72a570)
> Stack: <0>b19acba0 b0124ea5 00000004 d2619fbc d2619fbc b035c26b 00000001 
> 00000000
>        e043b660 d2618000 00000000 b0125097 00000000 3abf1f04 3abf1f04 
>        d2618000
>        b0102e1b 00000000 00000000 00000000 3abf1f04 3abf1f04 aff1e8d8 
>        000000fc
> Call Trace:
>  [<b0124ea5>] do_exit+0x295/0x410
>  [<b0125097>] do_group_exit+0x37/0xa0
>  [<b0102e1b>] sysenter_past_esp+0x54/0x75
> Code: 75 22 b8 00 e0 ff ff 21 e0 ff 48 14 8b 40 08 a8 08 75 24 89 da 5b a1 
> 44 b8 46 b0 e9 65 6a f5 ff ff d2 eb d0 90 ff d2 eb d9 5b c3 <0f> 0b a9 0d 
> 2c ac 36 b0 89 f6 eb 9b e8 79 f2 12 00 eb d5 8d b4
>  <1>Fixing recursive fault but reboot is needed!

Auch, so that's

        BUG_ON(atomic_read(&ioc->refcount) == 0);

triggering. What sort of testing were you running, exactly?

Al, any ideas?

-- 
Jens Axboe

