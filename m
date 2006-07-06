Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWGFXXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWGFXXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWGFXXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:23:39 -0400
Received: from xenotime.net ([66.160.160.81]:10970 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751040AbWGFXXi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:23:38 -0400
Date: Thu, 6 Jul 2006 16:26:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: jamagallon@ono.com
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       jgarzik <jgarzik@pobox.com>
Subject: Re: 2.6.17-mm6 (try-3)
Message-Id: <20060706162622.8d5ac9a7.rdunlap@xenotime.net>
In-Reply-To: <20060706234425.678cbc2f@werewolf.auna.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705234347.47ef2600@werewolf.auna.net>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
	<20060705170228.9e595851.akpm@osdl.org>
	<20060706163646.735f419f@werewolf.auna.net>
	<20060706164802.6085d203@werewolf.auna.net>
	<20060706234425.678cbc2f@werewolf.auna.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(sorry to spam everyone, but I can't seem to reply to this
message and have it appear on lkml)

On Thu, 6 Jul 2006 23:44:25 +0200 J.A. Magallón wrote:

> On Thu, 6 Jul 2006 16:48:02 +0200, "J.A. Magallón" <jamagallon@ono.com> wrote:
> 
> > On Thu, 6 Jul 2006 16:36:46 +0200, "J.A. Magallón" <jamagallon@ono.com> wrote:
> > 
> > > On Wed, 5 Jul 2006 17:02:28 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > 
> > > This a shot till I can try to get a full dmesg.
> > > 
> > > http://belly.cps.unizar.es/~magallon/tmp/shot.jpg
> > > 
> > > Anyways, what I wanted to point above was that previous kernels talk
> > > about 'sda1(8,1)', and newer use 'dev(8,19)'.
> > > Perhaps somebedy did a strcpy( ... , "dev" ), instead of strcpy( ... , dev ) ?
> > > 
> > 
> > Hey !!. I disabled md and usb to get more useful messages in my screen, and
> > now I have realized that libata is managing my IDE drive !! And I did not
> > boot with any 'libata.atapi_enable'....
> > 
> > In -mm1,
> > sda -> 200Gb sata
> > hda -> HL-DT-ST DVDRAM GSA-4120B
> > hdb -> (zip drive)
> > hdc -> 120Gb ide
> > hdd -> DVD-ROM
> > 
> > In -mm6,
> > 
> > sda -> (zip drive) ?
> > sdb -> 120Gb
> > sdc -> 200Gb
> > 
> 
> Well, booting onto sdc1 let me get to single user mode at least so I got
> a full dmesg. Relevant parts for -mm1 and -mm6 are below (if you want it
> full I can provide). Basically it looks like libata 2.0 by default handles
> PATA drives. This can break a lot of systems. In my opinion, PATA hosts
> should be detected _after_ real sata hosts in the same chipset (now it
> looks like its done _before_). What is handled by IDE will break anyways,
> but this way at least real SATA will stay at the same /dev/sdX devices.
> 
> -mm1:
> ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> ICH5: IDE controller at PCI slot 0000:00:1f.1
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> 
> -mm6:
> 
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16

Yep, adding all of the libata-pata drivers mucked up the
/dev/sd* boot order.  :(
Perhaps they should follow all of the SATA drivers.  ?

---
~Randy
