Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293556AbSBZJvR>; Tue, 26 Feb 2002 04:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293557AbSBZJvI>; Tue, 26 Feb 2002 04:51:08 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53255
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293556AbSBZJvC>; Tue, 26 Feb 2002 04:51:02 -0500
Date: Tue, 26 Feb 2002 01:37:55 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ken Brownfield <brownfld@irridia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
In-Reply-To: <E16feI5-0008WC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10202260131250.14807-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Alan Cox wrote:

> > I have a lot of ServerWorks OSB4 IDE hardware, which has the annoyingly
> > suboptimal behavior of corrupting filesystems when DMA is active.
> 
> With newer kernels you should get a panic because we spot the "I'm going
> to get 4 bytes stuck in the FIFO and DMA your inodes shifted 4 bytes down the
> disk behaviour" - at least in the cases I could study
> 
> What set up do you have ?
> 
> > Unfortunately, serverworks.c (in recent 2.4, at least) does not honor
> > the CONFIG_IDEDMA_AUTO config option -- it turns dma on only unless
> > "ide=nodma" is set on the kernel command line.
> 
> You actually really to just turn off UDMA from experience.
> 
> >  	if (hwif->dma_base) {
> > +#ifdef CONFIG_IDEDMA_AUTO
> >  		if (!noautodma)
> >  			hwif->autodma = 1;
> > +#endif
> 
> I would have expected this to be a fix in the core code to ignore
> hwif->autodma but I'll admit I've not looked to see if that is practical.

It is not practical and it was absorbed via distos which are/were
generally paranoid of DMA because of the total number of ATAPI devices
that live in SFF-8020/8070 but claim ATA/ATAPI-4 so who knows or cares.

The real solution for distros is to wrapper the dma_capable flags in the
module cores in 2.4 under the disk_only.  Also not setting
CONFIG_IDEDMA_AUTO will help but you are not permitted to invoke

echo using_dma:1 > /proc/ide/hda/settings

One of the issues to be address is a test for transfer modes, but have to
many other issues to address w/ clients to deal with distro issues.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

