Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSFEJkY>; Wed, 5 Jun 2002 05:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSFEJkX>; Wed, 5 Jun 2002 05:40:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:41234 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314083AbSFEJkV>; Wed, 5 Jun 2002 05:40:21 -0400
Message-ID: <3CFDCEC5.6020900@evision-ventures.com>
Date: Wed, 05 Jun 2002 10:41:41 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
        zlatko.calusic@iskon.hr
Subject: Re: IDE{,-SCSI} trouble [2.5.20]
In-Reply-To: <200206042254.PAA00940@baldur.yggdrasil.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> Russell King wrote:
> 
>>On Tue, Jun 04, 2002 at 02:37:55PM -0700, Adam J. Richter wrote:
>>
>>>--- linux/drivers/ide/icside.c	2002-06-03 00:46:21.000000000 -0700
>>>+++ linux-2.5.20/drivers/ide/icside.c	2002-06-02 18:44:41.000000000 -0700
>>>@@ -275,9 +275,8 @@
>>> #define NR_ENTRIES 256
>>> #define TABLE_SIZE (NR_ENTRIES * 8)
>>> 
>>>-static int ide_build_sglist(struct ata_device *drive, struct request *rq)
>>>+static int ide_build_sglist(struct ata_channel *ch, struct request *rq)
>>> {
>>>-	struct ata_channel *ch = drive->channel;
>>> 	struct scatterlist *sg = ch->sg_table;
>>> 	int nents;
>>> 
>>
> 
>>Umm, you sure this is right?  ide_build_sglist takes an ata_channel
>>argument in my 2.5.20.
> 
> 
> 
> 	Right.  As the order of the file names in the diff confirms,
> I accidentally submitted a diff in reverse order.  You are also
> correct about:
> 
> 
>>If this is reversed, you also forgot to change where it is used in
>>icside.c.
> 
> 
> 	Russell: sorry for not cc'ing you in my original patch
> submission to Martin.  I infer that since you are adding another patch
> of your own and adding Martin to the recipient list that it is OK with
> you to volunteer Martin to combine your patch and mine in this case
> and submit them to Linus.
> 
> 	Martin: unless you, Russell, or anyone else sees a problem
> with this, could you please also apply the attached patch to icside.c,
> which I should have included in my original submission.  I missed my
> error when I checked for compiler warnings, because icside is not
> built on x86.
> 
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
> 
> 
> --- before/drivers/ide/icside.c	2002-06-02 18:44:41.000000000 -0700
> +++ linux/drivers/ide/icside.c	2002-06-04 15:31:21.000000000 -0700
> @@ -491,7 +492,7 @@
>  	 */
>  	BUG_ON(dma_channel_active(ch->hw.dma));
>  
> -	count = ch->sg_nents = ide_build_sglist(ch, rq);
> +	count = ch->sg_nents = ide_build_sglist(drive, rq);
>  	if (!count)
>  		return 1;

Yeep. Seems to be pretty "obviously correct".


