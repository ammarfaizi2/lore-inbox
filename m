Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSDSAp3>; Thu, 18 Apr 2002 20:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313507AbSDSAp2>; Thu, 18 Apr 2002 20:45:28 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:19193 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S311147AbSDSAp2>;
	Thu, 18 Apr 2002 20:45:28 -0400
Message-ID: <03c401c1e73b$7b3c2330$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <02e001c1e66d$8e927070$02c8a8c0@kroptech.com> <20020418061405.GF858@suse.de>
Subject: Re: 2.5.8-dj1 with IDE TCQ doesn't survive boot
Date: Thu, 18 Apr 2002 20:45:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Apr 17 2002, Adam Kropelin wrote:
>> Jens,
>> 
>> Tried 2.5.8-dj1 here with IDE TCQ and it doesn't make it through
>> bootup. The lockup (no oops) happens at various places, usually during
>
> - First try a later kernel, there have been lots of changes since 2.5.8
>   wrt TCQ. 

<snip>

> - If that doesn't change anything, please also try and disable
>   CONFIG_BLK_DEV_IDE_TCQ_FULL.

The problem persists in both cases, but there are subtle differences...

With CONFIG_BLK_DEV_IDE_TCQ_FULL it will lock regularly.
The auto fsck at boot is good at killing it; it locked up at 51% last time.
Occasionally it will make it as far as PostgreSQL and nfslock startup,
but no further.

With !CONFIG_BLK_DEV_IDE_TCQ_FULL it survives fsck
regularly. However, it still locks up around nfslock and PostgreSQL
startup. Interestingly, if I disable those two items, it boots every
time and (even more interestingly) I can start both by hand after
boot and it "seems" stable.

> If none of this makes it work, I'm hoping you can setup a serial console
> and do some debug logging for me? If you can, I'll let you know how and
> what to capture.

Your wish is my command...

--Adam

P.S. The following messages in reference to the CDROM are now emitted
during device detection. I assume it's because I have no media in the drive,
but since this is new behavior with the patch you sent I figured I'd note it.

hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x24
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x24
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x24


