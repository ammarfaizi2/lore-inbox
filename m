Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbVLWNhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbVLWNhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 08:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbVLWNhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 08:37:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36543 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030416AbVLWNhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 08:37:06 -0500
Date: Fri, 23 Dec 2005 05:36:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.15rc6: ide oops+panic
Message-Id: <20051223053621.6c437cee.akpm@osdl.org>
In-Reply-To: <43AB20DA.2020506@domdv.de>
References: <43AB20DA.2020506@domdv.de>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> wrote:
>
> Attached are boot messages and panic captured via serial console, as
> well as the system config.
> 
> ...
>
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 280k freed
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at drivers/ide/ide-io.c:63
> invalid operand: 0000 [1] PREEMPT SMP 
> CPU 0 
> Modules linked in: snd_usb_audio snd_usb_lib snd_rawmidi snd_hwdep
> Pid: 0, comm: swapper Not tainted 2.6.15-rc6top #1
> RIP: 0010:[<ffffffff8038e995>] <ffffffff8038e995>{__ide_end_request+53}
> RSP: 0018:ffffffff806d67d0  EFLAGS: 00010046
> RAX: 0000000001000479 RBX: ffff810002f7b490 RCX: 0000000000000008
> RDX: 0000000000000000 RSI: ffff810002f7b490 RDI: ffffffff80730d98
> RBP: 0000000000000000 R08: 000000003b9aca00 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000064 R12: ffffffff80730d98
> R13: 0000000000000008 R14: 0000000000000001 R15: ffffffff80730c80
> FS:  00002aaaab1aaae0(0000) GS:ffffffff80751800(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 00002aaaaafbb7b0 CR3: 000000007e0e0000 CR4: 00000000000006e0
> Process swapper (pid: 0, threadinfo ffffffff8075a000, task ffffffff805d36c0)
> Stack: ffff810002f7b490 ffff81013feeacd0 ffff810002f5a550 0000000000000050 
>        0000000000000050 ffffffff80299aae 0000000000000246 ffff81013feeacd0 
>        ffffffff80730d98 ffffffff8038f0f2 
> Call Trace: <IRQ> <ffffffff80299aae>{blk_pre_flush_end_io+110}
>        <ffffffff8038f0f2>{ide_end_drive_cmd+946} <ffffffff8038f6f0>{drive_cmd_intr+288}
>        <ffffffff8038f5d0>{drive_cmd_intr+0} <ffffffff80390850>{ide_intr+400}
>        <ffffffff8015c7bc>{handle_IRQ_event+44} <ffffffff8015c8a1>{__do_IRQ+177}
>        <ffffffff80110c9f>{do_IRQ+47} <ffffffff8010e2d8>{ret_from_intr+0}
>        <ffffffff80390ad0>{ide_outb+0} <ffffffff80390ad6>{ide_outb+6}
>        <ffffffff803995b1>{ide_do_rw_disk+529} <ffffffff8049a036>{ip_rcv+1302}
>        <ffffffff80120000>{__ioremap+512} <ffffffff80390160>{ide_do_request+1648}
>        <ffffffff8038f0f2>{ide_end_drive_cmd+946} <ffffffff80390895>{ide_intr+469}
>        <ffffffff8015c7bc>{handle_IRQ_event+44} <ffffffff8015c8a1>{__do_IRQ+177}
>        <ffffffff80110c9f>{do_IRQ+47} <ffffffff8010e2d8>{ret_from_intr+0}
>         <EOI> <ffffffff8010ebf1>{kernel_thread+129} <ffffffff80390ad0>{ide_outb+0}
>        <ffffffff8010bd96>{default_idle+54} <ffffffff8010c012>{cpu_idle+98}
>        <ffffffff8075c835>{start_kernel+485} <ffffffff8075c294>{_sinittext+660}
>        
> 
> Code: 0f 0b 68 61 85 57 80 c2 3f 00 90 a8 02 74 0c 85 ed 7f 08 44 
> RIP <ffffffff8038e995>{__ide_end_request+53} RSP <ffffffff806d67d0>

Thanks.  Are you able to identify the most-recent kernel version which
didn't do this?

