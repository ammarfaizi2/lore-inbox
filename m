Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282171AbRK1Q0c>; Wed, 28 Nov 2001 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283078AbRK1Q0W>; Wed, 28 Nov 2001 11:26:22 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:47091 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282171AbRK1Q0M>;
	Wed, 28 Nov 2001 11:26:12 -0500
Date: Wed, 28 Nov 2001 09:26:00 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
Message-ID: <20011128092600.Q730@lynx.no>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200111272209.fARM9tk18991@ns.caldera.de> <Pine.LNX.4.33.0111271628430.1629-100000@penguin.transmeta.com> <20011128135508.A21418@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011128135508.A21418@caldera.de>; from hch@caldera.de on Wed, Nov 28, 2001 at 01:55:08PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2001  13:55 +0100, Christoph Hellwig wrote:
> > > While we are at breaking scsi, would you take a patch to remove the
> > > old-style (2.0) scsi error handling completly, forcing drivers still
> > > using it to be fixed?  Early 2.5 looks like a good time for that to me..
> 
> --- ../master/linux-2.5.1-pre2/drivers/scsi/aic7xxx_old/aic7xxx.h	Sun Mar  4 23:30:18 2001
> +++ linux/drivers/scsi/aic7xxx_old/aic7xxx.h	Wed Nov 28 13:35:21 2001
> @@ -55,7 +55,6 @@
>  	present: 0,		/* number of 7xxx's present   */\
>  	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
>  	use_clustering: ENABLE_CLUSTERING,			\
> -	use_new_eh_code: 0					\
>  }
>  
>  extern int aic7xxx_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));

What would be nice in the case of drivers that don't use the new error
handling code is to add something like:

#warning "Uses obsolete SCSI error code, see Documentation/2.5/scsi-error.txt"

for a hint as to the reason why it no longer compiles, and a short guide
on how to update the drivers.

The same would be good for Jens' changes - his document could be put into
2.5/bio.txt or something, so any currently out-of-kernel coders can find it.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

