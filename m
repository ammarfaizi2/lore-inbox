Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSE2OIU>; Wed, 29 May 2002 10:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSE2OIT>; Wed, 29 May 2002 10:08:19 -0400
Received: from [195.63.194.11] ([195.63.194.11]:39685 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315374AbSE2OHB>; Wed, 29 May 2002 10:07:01 -0400
Message-ID: <3CF4D19F.9080402@evision-ventures.com>
Date: Wed, 29 May 2002 15:03:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Gerald Champagne <gerald@io.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <1022680784.2945.24.camel@wiley>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerald Champagne wrote:
>>- ide_driveid_update is gone. We don't report the drive id through 
>>/proc/ide and we don't have to update it any longer on the fly. Still 
>>someone out there complaining that it went away!?
> 
> 
> But the id information is still available through the ioctl interface. 
> ide_driveid_update was used to update the dma_ultra, dma_mword, and
> dma_lword fields in the id structure after changing the rate with an
> ioctl command.  Won't these fields be wrong if the rate is changed after
> initialization?  Won't "hdparm -i" show outdated and incorrect
> information.
> 
> It's good to see the duplicate identify routine go away, but the ioctl
> shouldn't return incorrect information.  Can the remaining identify
> routine be modified and called directly from the ioctl that returns the
> id information?
> 
> Gerald

Dear Gerald please look closer. The hdparm -i is executing the
drive id command directly and does *not* rely on the internally
permanently dragged around id structure. So the change I did
is entierly fine. Just go ahead and check whatever hdparm -i /dev/hdx
reports the proper thing after changing some dma setting.
It does - I did check it :-).

BTW> The next thing to be gone is simple the fact that we drag
around the id information permanently, where infact only
some capabilitie fields are sucked out of it and the
device identification string is only needed for reporting
during boot-up.


