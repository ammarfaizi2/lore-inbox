Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269351AbUJWA1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbUJWA1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269538AbUJWAZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:25:30 -0400
Received: from smtp06.auna.com ([62.81.186.16]:31120 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S269351AbUJWAWf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:22:35 -0400
Date: Sat, 23 Oct 2004 00:22:31 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: pdc202xx_old broke boot [was Re: 2.6.9-mm1]
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20041022032039.730eb226.akpm@osdl.org>
	<1098490330l.28166l.0l@werewolf.able.es>
	<20041022172100.183f9fe1.akpm@osdl.org>
In-Reply-To: <20041022172100.183f9fe1.akpm@osdl.org> (from akpm@osdl.org on
	Sat Oct 23 02:21:00 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098490951l.6707l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.23, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > Hi all...
> > 
> > On 2004.10.22, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
> > > 
> > 
> > I upgraded from 2.6.9-rc3-mm3 to 2.6.9-mm1 and the system coould not boot.
> > What was before hde now was hda (guess ? root is on hde1...)
> 
> yikes.  Perhaps the PCI scanning order was changed?
>

I don't think so:

It is probed first:

> >  PDC20267: 100% native mode on irq 169
> > -PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
> > -    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:pio, hdb:pio
> > -    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:pio, hdd:DMA
> > -Probing IDE interface ide0...
> > -Probing IDE interface ide1...
> > +PDC20267: neither IDE port enabled (BIOS)

But does not result in any ide bus because there's no disk hanged...
And then comes the VIA:

> >  VP_IDE: IDE controller at PCI slot 0000:00:11.1
> >  VP_IDE: chipset revision 6
> >  VP_IDE: not 100% native mode: will probe irqs later
> >  VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
> > -    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:DMA, hdf:pio
> > -    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:DMA
> > +    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio

.. that gives ide0 -> hda, instead of ide2->hde.

Good time to try lilo+fstab+labels...

Do you know if fsck will work with labels in /etc/fstab ?
Because obviously udev does not create hdeX...
A real mess.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


