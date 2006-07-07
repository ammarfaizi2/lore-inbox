Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWGGP5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWGGP5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWGGP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:57:39 -0400
Received: from smtp.ono.com ([62.42.230.12]:5833 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932134AbWGGP5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:57:38 -0400
Date: Fri, 7 Jul 2006 17:55:09 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060707175509.14ea9187@werewolf.auna.net>
In-Reply-To: <1152288168.20883.8.camel@localhost.localdomain>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705234347.47ef2600@werewolf.auna.net>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
	<20060705170228.9e595851.akpm@osdl.org>
	<20060706163646.735f419f@werewolf.auna.net>
	<20060706164802.6085d203@werewolf.auna.net>
	<20060706234425.678cbc2f@werewolf.auna.net>
	<20060706145752.64ceddd0.akpm@osdl.org>
	<1152288168.20883.8.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.3.1cvs64 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 17:02:48 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Iau, 2006-07-06 am 14:57 -0700, ysgrifennodd Andrew Morton:
> > > ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> > > ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> > > ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> > > ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> > > 
> > 
> > Ah-hah, thanks.  I think this is a relatively-FAQ, but I forget the answer.
> > Alan's the man.
> 
> The "mixed" drivers/ide and drivers/scsi setup for the ICH is really
> ugly (look at the pci/quirks.c code for it to see just *how* ugly). It
> is still present but the default behaviour at the moment is to assume
> that you want to use libata for your drives.
> 
> For most distros I've tried this doesn't seem to break anything. Some
> older distros don't use labels for root searching so need root= passing
> the first time to fix it.
> 
> That bit of code is really Jeff code but I can certainly put a Kconfig
> line and submit a diff to allow users to pick whether their PIIX/ICH
> should be handled half and half if Andrew or Jeff think that is wise.
> 
> Alan
> 

I think it is enough to change the detection order, first real SATA and then
PATA, so the only drives that change names are the PATA ones.
(it that's easy enough...)

Mmm, I have thought on another thing. RAID devices do not store the /dev
node of pieces on the superblock, just drive IDs, isn't it ?

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
