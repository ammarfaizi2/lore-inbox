Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUH3AIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUH3AIj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 20:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUH3AIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 20:08:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268367AbUH3AIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 20:08:21 -0400
Message-ID: <41326FE1.2050508@redhat.com>
Date: Sun, 29 Aug 2004 20:08:01 -0400
From: Neil Horman <nhorman@redhat.com>
Reply-To: nhorman@redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Marc_Str=E4mke?= <marcstraemke.work@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the
   IDE bus)
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com> <cgsuq2$7cb$1@sea.gmane.org>
In-Reply-To: <cgsuq2$7cb$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Strämke wrote:

> Neil Horman wrote:
>
>> Its been awhile, but the last time that I looked at the relevant 
>> code, there was a table of drive vendor/device strings that were used 
>> to identify CFA devices and differentiate them from regular ide 
>> devices.  If this particular device isn't a match in that table, it 
>> would be mis-identified, and that could be leading to your above 
>> problem.
>> Neil
>>
>
> Thx for the suggestion. The only table i could find is in 
> drive_is_flashcard, which is only checked if drive->removable is set, 
> which is not the case with the newer card (but is with the old one).
> Another thing which is weird is that the old card returns an 
> id->config value of 0x848a which according to manuals from SanDisk is 
> for a Compactflash card NOT running in True Ide mode, but instead in 
> memory mapped IO mode (iam no expert for Compactflash, so i dont even 
> know the exact difference), but as far as i can tell are both cards 
> wired by the IDE adapter so that they should run in True IDE mode, and 
> if i understand the Compactflash specification correctly, this is the 
> only mode of operation which is electrically compatible with the 
> IDE/ATA bus, isnt it?
> I tried forcing both the drive->removable and drive->is_flash flags to 
> the true, my dmesg output then shows me the card as a CFA DISK drive, 
> but i still get the same errors when reading or writing from/to the 
> device.
>
> TIA for any further hints,
> Marc
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

What kernel are you looking at?  I'm looking at 2.4.21, and it seems to 
get checked more-or-less universally.  Also, I noticed this:
|| !strncmp(id->model, "SunDisk SDCFB", 13)    /* SunDisk */
I've not heard of SunDisk.  SunDisk->SanDisk == Typo?
Are you using a SanDisk CFA card?  Could this perhaps be part of your issue?
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

