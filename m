Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316915AbSFLU1u>; Wed, 12 Jun 2002 16:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSFLU1t>; Wed, 12 Jun 2002 16:27:49 -0400
Received: from [80.116.158.38] ([80.116.158.38]:38204 "HELO xmerlin.org")
	by vger.kernel.org with SMTP id <S316915AbSFLU1n>;
	Wed, 12 Jun 2002 16:27:43 -0400
Message-ID: <3D07B086.2030708@studiobz.it>
Date: Wed, 12 Jun 2002 22:35:18 +0200
From: Christian Zoffoli <czoffoli@studiobz.it>
Organization: Studio B.Z. s.a.s.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.0.0) Gecko/00200205
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, osb4-bug@ide.cabal.tm,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OSB4 PATCH (was: Re: Serverworks OSB4 in impossible state)
In-Reply-To: <E17I4DK-0007Lt-00@the-village.bc.nu> <1023877839.23630.502.camel@biker.pdb.fsc.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck wrote:
> Am Mit, 2002-06-12 um 11.14 schrieb Alan Cox:
>  > Entirely agreed
> 
> I propose this patch to remedy the problem.
> 
> I don't know how to test if the drive is a seagate drive, and
> I think we don't want to do that, because it would end up in yet another
> blacklist.
> 
> I cannot test if this behaves correctly on machines that do expose the
> 4-byte shift bug - it would be great if somebody could test that.
> 
> Martin
> 
> --- drivers/ide/serverworks.c.orig	Tue Jun 11 11:24:59 2002
> +++ drivers/ide/serverworks.c	Wed Jun 12 12:00:36 2002
> @@ -547,7 +547,13 @@
>  			ide_hwif_t *hwif		= HWIF(drive);
>  			unsigned long dma_base		= hwif->dma_base;
>  	
> -			if(inb(dma_base+0x02)&1)
> +			/* If it's a disk on the OSB4, the DMA engine is still on,
> +			   and the device reports no error status, we are probably
> +			   facing the "4 byte shift" problem */
> +			if(drive->media == ide_disk && 
> +			   hwif->pci_dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE && 
> +			   inb(dma_base+0x02)&1 &&
> +			   OK_STAT (GET_STAT(), DRIVE_READY, BAD_STAT))
>  			{
>  #if 0		
>  				int i;
> 
> 


It works for me ...I have a supermicro 370DE6 (serverworks HE-SL) and a 
maxtor HD (5T030H3).


Christian

