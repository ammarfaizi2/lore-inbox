Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269779AbRIFNAs>; Thu, 6 Sep 2001 09:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270253AbRIFNAi>; Thu, 6 Sep 2001 09:00:38 -0400
Received: from f45.law10.hotmail.com ([64.4.15.45]:23813 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S269779AbRIFNAd>;
	Thu, 6 Sep 2001 09:00:33 -0400
X-Originating-IP: [194.65.14.70]
From: "Mack Stevenson" <mackstevenson@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: reiser@namesys.com, _deepfire@mail.ru
Subject: Re: Basic reiserfs question
Date: Thu, 06 Sep 2001 15:00:48 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com>
X-OriginalArrivalTime: 06 Sep 2001 13:00:48.0625 (UTC) FILETIME=[F3049E10:01C136D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Mack Stevenson wrote:
> >
> > I would like to know whether log replays take place whenever the system 
>is
> > booted or only after it has been incorrectly shutdown. I occasionaly see
> > "Warning, log replay (...)" during the boot-up sequence although the 
>system
> > had been correctly shut down, and I would like to know if I should 
>worry.


>From: Hans Reiser <reiser@namesys.com>
>To: Mack Stevenson <mackstevenson@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Basic reiserfs question
>Date: Thu, 06 Sep 2001 01:50:59 +0400
>
>
>Are you using redhat?  Do your shutdown scripts unmount the filesystem only 
>if
>it is ext2?

I am using slackware (8.0), and the shutdown script on my system uses:

# Turn off swap, then unmount local file systems.
echo "Turning off swap."
swapoff -a
echo "Unmounting local file systems."
# Don't remount UMSDOS root volumes:
if [ ! "`mount | head -1 | cut -d ' ' -f 5`" = "umsdos" ]; then
  umount -a -r -t nonfs
  echo "Remounting root filesystem read-only."
  mount -n -o remount,ro /
else
  umount -a -r -t nonfs,noumsdos,nosmbfs
fi

# This never hurts:
sync

---

I guess that's not the probem, then... Actually, whenever I shutdown I never 
see any messages about the unmounting (or the mounting in readonly mode) 
failing, which only adds to my confusion.


>From: Samium Gromoff <_deepfire@mail.ru>
>To: linux-kernel@vger.kernel.org
>CC: mackstevenson@hotmail.com
>Subject: Re: Basic reiserfs question
>Date: Thu, 6 Sep 2001 03:35:49 +0000 (UTC)
>
>Actually you see "Warning" only when it is replaying log on
>fs mounted readonly.

Yes, that's the warning I see.


>I wander though why you see it only "occasionally"..
>Normally it replays log every time and you shouldnt bother.

Does it? I know next to nothing about these issues, but I thought that I had 
read somewhere that log replays only occurred after a system crashed and 
couldn't be shutdown properly.

Thank you both,

Mack S.




_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

