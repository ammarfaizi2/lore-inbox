Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312413AbSDSLHd>; Fri, 19 Apr 2002 07:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSDSLHc>; Fri, 19 Apr 2002 07:07:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30991 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312413AbSDSLHb>; Fri, 19 Apr 2002 07:07:31 -0400
Message-ID: <3CBFEBDA.1090304@evision-ventures.com>
Date: Fri, 19 Apr 2002 12:05:14 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-dj1 with IDE TCQ doesn't survive boot
In-Reply-To: <02e001c1e66d$8e927070$02c8a8c0@kroptech.com> <20020418061405.GF858@suse.de> <03c401c1e73b$7b3c2330$02c8a8c0@kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> Jens Axboe wrote:
> 
>>On Wed, Apr 17 2002, Adam Kropelin wrote:
>>
>>>Jens,
>>>
>>>Tried 2.5.8-dj1 here with IDE TCQ and it doesn't make it through
>>>bootup. The lockup (no oops) happens at various places, usually during
>>
>>- First try a later kernel, there have been lots of changes since 2.5.8
>>  wrt TCQ. 
> 
> 
> <snip>
> 
>>- If that doesn't change anything, please also try and disable
>>  CONFIG_BLK_DEV_IDE_TCQ_FULL.
> 
> 
> The problem persists in both cases, but there are subtle differences...
> 
> With CONFIG_BLK_DEV_IDE_TCQ_FULL it will lock regularly.
> The auto fsck at boot is good at killing it; it locked up at 51% last time.
> Occasionally it will make it as far as PostgreSQL and nfslock startup,
> but no further.
> 
> With !CONFIG_BLK_DEV_IDE_TCQ_FULL it survives fsck
> regularly. However, it still locks up around nfslock and PostgreSQL
> startup. Interestingly, if I disable those two items, it boots every
> time and (even more interestingly) I can start both by hand after
> boot and it "seems" stable.
> 
> 
>>If none of this makes it work, I'm hoping you can setup a serial console
>>and do some debug logging for me? If you can, I'll let you know how and
>>what to capture.
> 
> 
> Your wish is my command...
> 
> --Adam
> 
> P.S. The following messages in reference to the CDROM are now emitted
> during device detection. I assume it's because I have no media in the drive,
> but since this is new behavior with the patch you sent I figured I'd note it.
> 
> hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
> hdd: request sense failure: error=0x24
> hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
> hdd: request sense failure: error=0x24
> hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
> hdd: request sense failure: error=0x24

The problem is right now that the TCQ changes unfortunately make it necessary
to adjust the transport layer of the ide-cd driver as well. The problem is
known and I'm working on it.

