Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSFDWzo>; Tue, 4 Jun 2002 18:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316909AbSFDWzn>; Tue, 4 Jun 2002 18:55:43 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:24979 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316900AbSFDWzl>; Tue, 4 Jun 2002 18:55:41 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 4 Jun 2002 15:54:52 -0700
Message-Id: <200206042254.PAA00940@baldur.yggdrasil.com>
To: dalecki@evision-ventures.com, rmk@arm.linux.org.uk
Subject: Re: IDE{,-SCSI} trouble [2.5.20]
Cc: linux-kernel@vger.kernel.org, zlatko.calusic@iskon.hr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>On Tue, Jun 04, 2002 at 02:37:55PM -0700, Adam J. Richter wrote:
>> --- linux/drivers/ide/icside.c	2002-06-03 00:46:21.000000000 -0700
>> +++ linux-2.5.20/drivers/ide/icside.c	2002-06-02 18:44:41.000000000 -0700
>> @@ -275,9 +275,8 @@
>>  #define NR_ENTRIES 256
>>  #define TABLE_SIZE (NR_ENTRIES * 8)
>>  
>> -static int ide_build_sglist(struct ata_device *drive, struct request *rq)
>> +static int ide_build_sglist(struct ata_channel *ch, struct request *rq)
>>  {
>> -	struct ata_channel *ch = drive->channel;
>>  	struct scatterlist *sg = ch->sg_table;
>>  	int nents;
>>  

>Umm, you sure this is right?  ide_build_sglist takes an ata_channel
>argument in my 2.5.20.


	Right.  As the order of the file names in the diff confirms,
I accidentally submitted a diff in reverse order.  You are also
correct about:

>If this is reversed, you also forgot to change where it is used in
>icside.c.

	Russell: sorry for not cc'ing you in my original patch
submission to Martin.  I infer that since you are adding another patch
of your own and adding Martin to the recipient list that it is OK with
you to volunteer Martin to combine your patch and mine in this case
and submit them to Linus.

	Martin: unless you, Russell, or anyone else sees a problem
with this, could you please also apply the attached patch to icside.c,
which I should have included in my original submission.  I missed my
error when I checked for compiler warnings, because icside is not
built on x86.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- before/drivers/ide/icside.c	2002-06-02 18:44:41.000000000 -0700
+++ linux/drivers/ide/icside.c	2002-06-04 15:31:21.000000000 -0700
@@ -491,7 +492,7 @@
 	 */
 	BUG_ON(dma_channel_active(ch->hw.dma));
 
-	count = ch->sg_nents = ide_build_sglist(ch, rq);
+	count = ch->sg_nents = ide_build_sglist(drive, rq);
 	if (!count)
 		return 1;
 
