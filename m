Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279596AbRKATQx>; Thu, 1 Nov 2001 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279592AbRKATQj>; Thu, 1 Nov 2001 14:16:39 -0500
Received: from aeon.tvd.be ([195.162.196.20]:36044 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S279588AbRKATQV>;
	Thu, 1 Nov 2001 14:16:21 -0500
Date: Thu, 1 Nov 2001 20:09:07 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <20010727221848.F1554-100000@gerard>
Message-ID: <Pine.LNX.4.05.10111011954520.2424-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ About SCSI tape corruption with sym53c8xx, some months ago ]

On Fri, 27 Jul 2001, Gérard Roudier wrote:
> On Fri, 27 Jul 2001, Geert Uytterhoeven wrote:
> > With some small modifications, I made 1.5a to work fine. No error burst. So the
> > problem is introduced between 1.5a and 1.5g.
> 
> Fine! But diffs between 1.5a and 1.5g are still large. :(
> Results with 1.5c would have divided the diffs by about 2. :(
> 
> > Unfortunately my DDS-1 drive seems to have died for real after this test :-(
> > I don't know yet whether I will replace it with a new tape drive or with a
> > CD-RW. Which means I may never find out which change caused the problem...
> 
> I expect the problem to pong again to me. For now, I plan to look into the
> 1.5g-1.5a source diffs and inspect each change. But as I will be in
> vacation for the next two weeks, I will not be able to work on this
> problem immediately.

Any progress on this?

> > I assume other people suffer from the same error burst problem, but they never
> > notice until they really want to restore data. Me myself only notived it by
> > accident, too.
> 
> Thanks for your testings and results.

I have good news and bad news. First the bad news...

In the mean time I replaced my broken HP C5136A with a Plextor PX-W1210S CD
rewriter. So far I only wrote CDRs and CDRWs with 2.2.18pre1 and a `known
good' (for tape) version of the Sym53c8xx driver.

I just tried writing a CDRW with test data (512000000 bytes, created with
http://home.tvd.be/cr26864/Download/genpseudorandom.c) using version 1.5g
of the ym53c8xx driver, and guess what happened!

| Error burst of 18 bytes detected at offset 0x361be0
|   Error data is a copy of the data at offset 0x3523e0 (shift = 63488)
| Error burst of 13 bytes detected at offset 0x361bf3
|   Error data is a copy of the data at offset 0x3523f3 (shift = 63488)
| Error burst of 18 bytes detected at offset 0x6a8ba0
|   Error data is a copy of the data at offset 0x6993a0 (shift = 63488)
| Error burst of 13 bytes detected at offset 0x6a8bb3
|   Error data is a copy of the data at offset 0x6993b3 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x2b96980
|   Error data is a copy of the data at offset 0x2b87180 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x3f351a0
|   Error data is a copy of the data at offset 0x3f259a0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x46d4de0
|   Error data is a copy of the data at offset 0x46c55e0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x8d2e7e0
|   Error data is a copy of the data at offset 0x8d1efe0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x8f5dea0
|   Error data is a copy of the data at offset 0x8f4e6a0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0xce732a0
|   Error data is a copy of the data at offset 0xce63aa0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0xd0455a0
|   Error data is a copy of the data at offset 0xd035da0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x114746a0
|   Error data is a copy of the data at offset 0x11464ea0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x1229e0a0
|   Error data is a copy of the data at offset 0x1228e8a0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x1246e620
|   Error data is a copy of the data at offset 0x1245ee20 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x162cd2e0
|   Error data is a copy of the data at offset 0x162bdae0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x16f82de0
|   Error data is a copy of the data at offset 0x16f735e0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x16f84420
|   Error data is a copy of the data at offset 0x16f74c20 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x1703e6e0
|   Error data is a copy of the data at offset 0x1702eee0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x1760eaa0
|   Error data is a copy of the data at offset 0x175ff2a0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x177ddbc0
|   Error data is a copy of the data at offset 0x177ce3c0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x1bcc5560
|   Error data is a copy of the data at offset 0x1bcb5d60 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x1bcc55e0
|   Error data is a copy of the data at offset 0x1bcb5de0 (shift = 63488)
| Error burst of 32 bytes detected at offset 0x1d0fd260
|   Error data is a copy of the data at offset 0x1d0eda60 (shift = 63488)
| Found a total of 670 errors (max 32 consecutive) in 23 error bursts

Thus the problem exists not only for tape drives, but also for CD writers! Main
difference is the shift of 63488 (= 31*2048) for CDs, compared to 10240 (block
size of tar) for tapes.
So far I haven't found any evidence of a similar problem for hard disks.

Now the good news: I have hardware to try finding the source of this problem
again ;-) If I'll find some time, I'll try driver version 1.5c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


