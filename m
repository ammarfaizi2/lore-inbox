Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbULNGys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbULNGys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 01:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbULNGyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 01:54:47 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:43783
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261435AbULNGyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 01:54:44 -0500
Date: Mon, 13 Dec 2004 22:51:55 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Rene Herman <rene.herman@keyaccess.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.10-rc2+] ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED
 SOON!
In-Reply-To: <58cb370e04121313473057143b@mail.gmail.com>
Message-ID: <Pine.LNX.4.10.10412132250240.1278-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bart,

Recall there is a mixed breed out there ... some do some don't.
Also I need your snail mail address, I have a case of hardware to send you
way.  Since you have managed to not go insane yet ... I want to help you
get there with ease.

Cheers,

Andre

Andre Hedrick
LAD Storage Consulting Group

On Mon, 13 Dec 2004, Bartlomiej Zolnierkiewicz wrote:

> On Sun, 05 Dec 2004 20:23:13 +0100, Rene Herman
> <rene.herman@keyaccess.nl> wrote:
> > Hi Bart.
> 
> Hi,
>  
> > I see your 2004-11-01 IDE update:
> > 
> > http://lkml.org/lkml/2004/11/1/158
> > 
> > obsoleted the idex=ata66 option, saying that it "should be handled by
> > host drivers needing it". As far as I can see, amd74xx does not handle this?
> > 
> > I do need a way to force an 80c cable on this AMD756 (ATA66 max) board,
> > since the BIOS doesn't seem to be setting the cable bits correctly.
> 
> Ugh, I checked AMD datasheets and AMD756 doesn't support host
> side cable detection.  Well, we can try doing disk side only for it.
> [ ATi and ITE (in -ac kernels) drivers are also doing this. ]
> 
> --- amd74xx.c.orig	2004-11-02 14:17:14.000000000 +0100
> +++ amd74xx.c	2004-12-13 22:41:50.406229168 +0100
> @@ -344,10 +344,8 @@
>  			break;
>  
>  		case AMD_UDMA_66:
> -			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
> -			for (i = 24; i >= 0; i -= 8)
> -				if ((u >> i) & 4)
> -					amd_80w |= (1 << (1 - (i >> 4)));
> +			/* no host side cable detection */
> +			amd_80w = 0x03;
>  			break;
>  	}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

