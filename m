Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSFFBUH>; Wed, 5 Jun 2002 21:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316654AbSFFBUG>; Wed, 5 Jun 2002 21:20:06 -0400
Received: from jaded.cynicism.com ([206.129.95.68]:51208 "HELO
	jaded.cynicism.com") by vger.kernel.org with SMTP
	id <S316653AbSFFBT7>; Wed, 5 Jun 2002 21:19:59 -0400
Date: Wed, 5 Jun 2002 18:19:53 -0700 (PDT)
From: Derek Vadala <derek@cynicism.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.3.96.1020604144204.5024D-100000@gatekeeper.tmr.com>
Message-ID: <Pine.GSO.4.21.0206051716530.16571-100000@gecko.roadtoad.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Bill Davidsen wrote:

> On Sun, 2 Jun 2002, Derek Vadala wrote:
> 
> > You can always fake this effect by combining two 8-disk RAID-5s into a
> > RAID-0. It's not technically RAID-6, but can withstand a 2-disk failure,
> > although not _any_ 2-disk failure.
> 
> I think (hope) you meant 1+5, which will stand any three disk failure, and
> up to 1+N/2 if just the right drives fail. They never do, of course.

I did mean RAID-0 combined with RAID-5. You can search for RAID-50 for
more info. The configuration you describe (RAID-5s combined into a mirror)
would have a disk overhead that is worse than RAID-10/RAID-0+1. For two
5-disk RAID-5s combined into a RAID-1 you end up using six of your disks
for parity and disk mirroring:

  RAID-1 --------> RAID-5 (D0,D1,D2,D3,P0)
              |--> RAID-5 (D0,D1,D2,D3,P0)
   (four disks used for data, only one from each RAID-5 can fail)

With RAID-10:

  RAID-0 --------> RAID-1 (D0,D0)
              |--> RAID-1 (D1,D1)
              |--> RAID-1 (D2,D2)
              |--> RAID-1 (D3,D3)
              |--> RAID-1 (D4,D4)
   (five disks used for data, one from each mirror can fail)

With RAID-50:

  RAID-0 --------> RAID-5 (D0,D2,D4,D6,P0)
              |--> RAID-5 (D1,D3,D5,D7,P0)

   (two disks wasted only one from each RAID-5 can fail)

I believe that I/O performance would be similar for each
configuration. I'll try to run some tests in the next few days.

> I doubt it. Unless you run a system with heavy CPU demand there are lots
> of cycles for this stuff. I run 0+1 several places and I don't see serious
> CPU load. I would be very interested in RAID-6 in the kernel, but I have

Mirroing doesnt hit the CPU nearly as much as RAID-5 does. I suspect
RAID-6 would incur greater overhead because of its double parity blocks.
But, there's no point in arguing about kernel RAID-6 without data to back
it up.

---
Derek Vadala, derek@cynicism.com, http://www.cynicism.com/~derek

