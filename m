Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130911AbRCFEWY>; Mon, 5 Mar 2001 23:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130913AbRCFEWP>; Mon, 5 Mar 2001 23:22:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55054 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130911AbRCFEV7>; Mon, 5 Mar 2001 23:21:59 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux 2.4.2-ac12
Date: 5 Mar 2001 20:21:54 -0800
Organization: Transmeta Corporation
Message-ID: <981ol2$rp$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0103052124250.1132-100000@groveland.analogic.com> <Pine.LNX.4.32.0103052121180.1029-100000@nic-31-c31-100.mn.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.32.0103052121180.1029-100000@nic-31-c31-100.mn.mediaone.net>,
Scott M. Hoffman <scott1021@mediaone.net> wrote:
>
> It may not be related, but out of five boot attempts, only one got past
>the IDE driver stage(ie, below from 2.4.2 :
>  VP_IDE: IDE controller on PCI bus 00 dev 39
>  VP_IDE: chipset revision 16
>  VP_IDE: not 100% native mode: will probe irqs later
>  ide: Assuming 33MHz system bus speed for PIO modes; override with
>  idebus=xx
>  VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1
>      ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
>      ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA)
>
>  I've had 2.4.2 running great for the past 10 days. Need any more info?

I'd love to hear anything you can come up with. What's the next step in
your boot process, ie what's the part that normally shows up but doesn't
with 2.4.2-ac12? Is this using IDE-SCSI, for example?

One thing that both 2.4.3-pre3 and -ac12 do is to not have allocate a
result buffer for TEST_UNIT_READY. I don't see why that should matter,
but can you try un-doing the patch to "scsi_error.c" and see if that
makes a difference. I'm worried about this report, and the buslogic
corruption thing.. 

Justin: there's another "2.4.3-pre2 corrupts all disks on a buslogic
controller" report. The interesting part is that 2.4.3-pre2 doesn't
actually contain any buslogic changes. The only generic-scsi changes
were yours. Ideas?

		Linus
