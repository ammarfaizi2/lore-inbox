Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932297AbWFDWfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWFDWfw (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 18:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWFDWfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 18:35:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:62333 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932297AbWFDWfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 18:35:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Etlz7Qt2ZMD8Csl7x6wGBMy6o8JTU1NxaPz49p7Wuiec0x+tWBy2fRGdaczGgrDvQKtjKcSHxW9P7G3k/S5jH3Xf1TWmLF2vrWK4V4npbrXI9iJG7Uo+eVFMX6NteXT4gRLtMoCM0GsfGWx+n4o2USofKIE4HjSG6ld2AaFcsGs=
Message-ID: <6bffcb0e0606041535u10fdb7c2o9ac38d6fb80fd28d@mail.gmail.com>
Date: Mon, 5 Jun 2006 00:35:50 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3
Cc: "Andrew Morton" <akpm@osdl.org>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20060604213803.GC5898@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com>
	 <20060604024937.0fb57258.akpm@osdl.org>
	 <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com>
	 <20060604104121.GA16117@elte.hu>
	 <6bffcb0e0606040407u4f56f7fdyf5ec479314afc082@mail.gmail.com>
	 <20060604213803.GC5898@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > Unfortunately I can't compile this
> > Here is output from my build log
>
> > /usr/src/linux-mm/kernel/sched.c:3040: error: 'p' redeclared as
>
> i've uploaded a fixed version - does that work for you?

Yes, thanks.

Here is dmesg http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm3/mm-dmesg
Here is latency trace
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm3/mm-latency.bz2
Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm3/mm-config

Here is something new
Jun  4 23:59:44 ltg01-fedora kernel: hdd: set_drive_speed_status:
status=0x51 { DriveReady SeekComplete Error }
Jun  4 23:59:44 ltg01-fedora kernel: hdd: set_drive_speed_status:
error=0xb4 { AbortedCommand LastFailedSense=0x0b }
Jun  4 23:59:44 ltg01-fedora kernel: (          hdparm-1821 |#0): new
164424143 us user-latency.
Jun  4 23:59:44 ltg01-fedora kernel: stopped custom tracer.
Jun  4 23:59:44 ltg01-fedora kernel:
Jun  4 23:59:44 ltg01-fedora kernel: ============================
Jun  4 23:59:44 ltg01-fedora kernel: [ BUG: illegal lock usage! ]
Jun  4 23:59:44 ltg01-fedora kernel: ----------------------------
Jun  4 23:59:44 ltg01-fedora kernel: illegal {in-hardirq-W} ->
{hardirq-on-W} usage.
Jun  4 23:59:44 ltg01-fedora kernel: hdparm/1821 [HC0[0]:SC0[0]:HE1:SE1] takes:
Jun  4 23:59:44 ltg01-fedora kernel:  (ide_lock){++..}, at:
[<c0268388>] ide_dump_opcode+0x13/0x9b
Jun  4 23:59:44 ltg01-fedora kernel: {in-hardirq-W} state was registered at:
Jun  4 23:59:44 ltg01-fedora kernel:   [<c013b536>] lockdep_acquire+0x67/0x7f
Jun  4 23:59:44 ltg01-fedora kernel:   [<c0305755>] _spin_lock_irqsave+0x2d/0x3c
Jun  4 23:59:44 ltg01-fedora kernel:   [<c0265fff>] ide_intr+0x18/0x1ab
Jun  4 23:59:44 ltg01-fedora kernel:   [<c015062c>] handle_IRQ_event+0x1d/0x52
Jun  4 23:59:44 ltg01-fedora kernel:   [<c015169c>] handle_edge_irq+0x113/0x15a
Jun  4 23:59:44 ltg01-fedora kernel:   [<c0105857>] do_IRQ+0xa2/0xc7
Jun  4 23:59:44 ltg01-fedora kernel: irq event stamp: 2011
Jun  4 23:59:44 ltg01-fedora kernel: hardirqs last  enabled at (2011):
[<c0305b29>] _spin_unlock_irq+0x24/0x58
Jun  4 23:59:44 ltg01-fedora kernel: hardirqs last disabled at (2010):
[<c03056c9>] _spin_lock_irq+0x11/0x38
Jun  4 23:59:44 ltg01-fedora kernel: softirqs last  enabled at (2008):
[<c012630c>] __do_softirq+0xf0/0xf8
Jun  4 23:59:44 ltg01-fedora kernel: softirqs last disabled at (2001):
[<c0105741>] do_softirq+0x5e/0xd2
Jun  4 23:59:44 ltg01-fedora kernel:
Jun  4 23:59:44 ltg01-fedora kernel: other info that might help us debug this:
Jun  4 23:59:44 ltg01-fedora kernel: no locks held by hdparm/1821.
Jun  4 23:59:44 ltg01-fedora kernel:
Jun  4 23:59:44 ltg01-fedora kernel: stack backtrace:
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0104513>] show_trace+0x1b/0x20
Jun  4 23:59:44 ltg01-fedora kernel:  [<c01045f1>] dump_stack+0x1f/0x24
Jun  4 23:59:44 ltg01-fedora kernel:  [<c013976c>] print_usage_bug+0x1a5/0x1b1
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0139e90>] mark_lock+0x2ca/0x4f7
Jun  4 23:59:44 ltg01-fedora kernel:  [<c013aa96>] __lockdep_acquire+0x47e/0xaa4
Jun  4 23:59:44 ltg01-fedora kernel:  [<c013b536>] lockdep_acquire+0x67/0x7f
Jun  4 23:59:44 ltg01-fedora kernel:  [<c030552d>] _spin_lock+0x24/0x32
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0268388>] ide_dump_opcode+0x13/0x9b
Jun  4 23:59:44 ltg01-fedora kernel:  [<c02688b6>] ide_dump_status+0x4a6/0x4cc
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0267ae6>]
ide_config_drive_speed+0x32a/0x33a
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0262dc5>] piix_tune_chipset+0x2ed/0x2f8
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0262e31>]
piix_config_drive_xfer_rate+0x61/0xb5
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0263a82>] set_using_dma+0x2f/0x60
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0263bee>] ide_write_setting+0x4a/0xc3
Jun  4 23:59:44 ltg01-fedora kernel:  [<c02647ca>] generic_ide_ioctl+0x8a/0x47f
Jun  4 23:59:44 ltg01-fedora kernel:  [<f886003a>]
idecd_ioctl+0xfd/0x133 [ide_cd]
Jun  4 23:59:44 ltg01-fedora kernel:  [<c01f1fff>] blkdev_driver_ioctl+0x4b/0x5f
Jun  4 23:59:44 ltg01-fedora kernel:  [<c01f2783>] blkdev_ioctl+0x770/0x7bd
Jun  4 23:59:44 ltg01-fedora kernel:  [<c017dc0d>] block_ioctl+0x1f/0x21
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0189353>] do_ioctl+0x27/0x6e
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0189604>] vfs_ioctl+0x26a/0x280
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0189667>] sys_ioctl+0x4d/0x7e
Jun  4 23:59:44 ltg01-fedora kernel:  [<c0305ed2>] sysenter_past_esp+0x63/0xa1
Jun  4 23:59:44 ltg01-fedora kernel: ---------------------------
Jun  4 23:59:44 ltg01-fedora kernel: | preempt count: 00000001 ]
Jun  4 23:59:44 ltg01-fedora kernel: | 1-level deep critical section nesting:
Jun  4 23:59:44 ltg01-fedora kernel: ----------------------------------------
Jun  4 23:59:44 ltg01-fedora kernel: .. [<c030551b>] .... _spin_lock+0x12/0x32
Jun  4 23:59:44 ltg01-fedora kernel: .....[<c0268388>] ..   ( <=
ide_dump_opcode+0x13/0x9b)
Jun  4 23:59:44 ltg01-fedora kernel:
Jun  4 23:59:44 ltg01-fedora kernel: ide: failed opcode was: unknown

I get this when I do "hdparm -c 1 -d 1 /dev/hd{c,d}"

>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
