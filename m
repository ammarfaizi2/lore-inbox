Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSGATSY>; Mon, 1 Jul 2002 15:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSGATSX>; Mon, 1 Jul 2002 15:18:23 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45574
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316217AbSGATSW>; Mon, 1 Jul 2002 15:18:22 -0400
Date: Mon, 1 Jul 2002 12:19:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: hd_geometry question.
In-Reply-To: <200207011802.07212.schwidefsky@de.ibm.com>
Message-ID: <Pine.LNX.4.10.10207011217520.11012-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

Are you looking at how the IDEMA proposal will be addressed in Linux ?
This beign 4096byte physical with 512byte logical and failure to do a full
8 sector logical write wil cause a read-write-modify to the physical.

Cheers,

On Mon, 1 Jul 2002, Martin Schwidefsky wrote:

> Hi,
> I have a question about the start field in the hd_geometry structure. We used
> 
> 	geo->start = device->major_info->gendisk.part[MINOR(kdev)].start_sect
> 		>> device->sizes.s2b_shift;
> 
> in the old dasd driver but now we use
> 
> 	geo.start = get_start_sect(kdev);
> 
> to set the start field. One variant is wrong because the start sector differ if
> the block size is not 512 byte. The first variant calculates the start sector
> based on physical blocks (e.g. with 4096 bytes instead of 512 bytes). The
> second variant calulcates a "soft" start sector based on logical 512 byte
> blocks. Whats correct, first or second variant ?? I tend to favor the first
> variant because struct hd_geometry describes the physical geometry
> (number of heads, sectors, cylinders and start sector) but I am not 100%
> sure about it.
> 
> blue skies,
>   Martin.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

