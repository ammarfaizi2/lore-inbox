Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313090AbSDYMJf>; Thu, 25 Apr 2002 08:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313093AbSDYMJe>; Thu, 25 Apr 2002 08:09:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:22544 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313090AbSDYMJd>; Thu, 25 Apr 2002 08:09:33 -0400
Message-ID: <3CC7E358.8050905@evision-ventures.com>
Date: Thu, 25 Apr 2002 13:07:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com> <1019583551.1392.5.camel@turbulence.megapathdsl.net> <1019584497.1393.8.camel@turbulence.megapathdsl.net> <3CC66794.5040203@evision-ventures.com> <20020424091151.GD812@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:
> On Wed, Apr 24 2002, Martin Dalecki wrote:

>>OK I assume that the oops happens inside the ide-scsi module.
>>This will be fixed in one of the forthcomming patch sets.
> 
> 
> Are you sure this isn't just due to ->special being set, and
> ide_end_request() assuming it's an ar? From ide-cd, that is.


Yes I know it's all the same. However unfortunately
it's *not easy* to back out the ->special use from
the drivers that do it. We have the following sutuation:

1. Generic BIO code checking for ->special and deciding whatever
it should trying to merge request or not.

2. Gneric ATA code setting ->special for ata_request passing.

3. CD-ROM ATAPI code using ->special for passing packet commands
and failed commands.

4. ide-scsi using it for the same purspose as CD-ROM

5. ide-floppy not using it at all buf abusing the ->buffer member
    for precisely the same purpose.

And unfortunately there is *no* easy solution for any of the
above circumstances without breaking far too many things.

The conclusion simply is: unless the above issues are fixed
the TCQ stuff has simply to be backed out again anbd live
separately from the main code chain. :-(.


