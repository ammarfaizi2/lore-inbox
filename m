Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280629AbRKBJuS>; Fri, 2 Nov 2001 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280632AbRKBJt7>; Fri, 2 Nov 2001 04:49:59 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:34500 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S280631AbRKBJtr> convert rfc822-to-8bit; Fri, 2 Nov 2001 04:49:47 -0500
Date: Fri, 2 Nov 2001 08:04:47 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <Pine.LNX.4.05.10111011954520.2424-100000@callisto.of.borg>
Message-ID: <20011102074532.C708-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Nov 2001, Geert Uytterhoeven wrote:

>
> [ About SCSI tape corruption with sym53c8xx, some months ago ]
>
> On Fri, 27 Jul 2001, Gérard Roudier wrote:
> > On Fri, 27 Jul 2001, Geert Uytterhoeven wrote:
> > > With some small modifications, I made 1.5a to work fine. No error burst. So the
> > > problem is introduced between 1.5a and 1.5g.
> >
> > Fine! But diffs between 1.5a and 1.5g are still large. :(
> > Results with 1.5c would have divided the diffs by about 2. :(
> >
> > > Unfortunately my DDS-1 drive seems to have died for real after this test :-(
> > > I don't know yet whether I will replace it with a new tape drive or with a
> > > CD-RW. Which means I may never find out which change caused the problem...
> >
> > I expect the problem to pong again to me. For now, I plan to look into the
> > 1.5g-1.5a source diffs and inspect each change. But as I will be in
> > vacation for the next two weeks, I will not be able to work on this
> > problem immediately.
>
> Any progress on this?

I looked into the diffs, but stuff was too large to get any clue from. :(

> > > I assume other people suffer from the same error burst problem, but they never
> > > notice until they really want to restore data. Me myself only notived it by
> > > accident, too.
> >
> > Thanks for your testings and results.
>
> I have good news and bad news. First the bad news...

/* Let's rearrange your report */
goto good_news:	/* :-) */

> In the mean time I replaced my broken HP C5136A with a Plextor PX-W1210S CD
> rewriter. So far I only wrote CDRs and CDRWs with 2.2.18pre1 and a `known
> good' (for tape) version of the Sym53c8xx driver.
>
> I just tried writing a CDRW with test data (512000000 bytes, created with
> http://home.tvd.be/cr26864/Download/genpseudorandom.c) using version 1.5g
> of the ym53c8xx driver, and guess what happened!
>
> | Error burst of 18 bytes detected at offset 0x361be0
> |   Error data is a copy of the data at offset 0x3523e0 (shift = 63488)
> | Error burst of 13 bytes detected at offset 0x361bf3
> |   Error data is a copy of the data at offset 0x3523f3 (shift = 63488)
> | Error burst of 18 bytes detected at offset 0x6a8ba0
> |   Error data is a copy of the data at offset 0x6993a0 (shift = 63488)
> | Error burst of 13 bytes detected at offset 0x6a8bb3
> |   Error data is a copy of the data at offset 0x6993b3 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x2b96980
> |   Error data is a copy of the data at offset 0x2b87180 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x3f351a0
> |   Error data is a copy of the data at offset 0x3f259a0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x46d4de0
> |   Error data is a copy of the data at offset 0x46c55e0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x8d2e7e0
> |   Error data is a copy of the data at offset 0x8d1efe0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x8f5dea0
> |   Error data is a copy of the data at offset 0x8f4e6a0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0xce732a0
> |   Error data is a copy of the data at offset 0xce63aa0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0xd0455a0
> |   Error data is a copy of the data at offset 0xd035da0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x114746a0
> |   Error data is a copy of the data at offset 0x11464ea0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x1229e0a0
> |   Error data is a copy of the data at offset 0x1228e8a0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x1246e620
> |   Error data is a copy of the data at offset 0x1245ee20 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x162cd2e0
> |   Error data is a copy of the data at offset 0x162bdae0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x16f82de0
> |   Error data is a copy of the data at offset 0x16f735e0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x16f84420
> |   Error data is a copy of the data at offset 0x16f74c20 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x1703e6e0
> |   Error data is a copy of the data at offset 0x1702eee0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x1760eaa0
> |   Error data is a copy of the data at offset 0x175ff2a0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x177ddbc0
> |   Error data is a copy of the data at offset 0x177ce3c0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x1bcc5560
> |   Error data is a copy of the data at offset 0x1bcb5d60 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x1bcc55e0
> |   Error data is a copy of the data at offset 0x1bcb5de0 (shift = 63488)
> | Error burst of 32 bytes detected at offset 0x1d0fd260
> |   Error data is a copy of the data at offset 0x1d0eda60 (shift = 63488)
> | Found a total of 670 errors (max 32 consecutive) in 23 error bursts
>
> Thus the problem exists not only for tape drives, but also for CD writers! Main
> difference is the shift of 63488 (= 31*2048) for CDs, compared to 10240 (block
> size of tar) for tapes.

good_news:	/* :) */

> So far I haven't found any evidence of a similar problem for hard disks.
>
> Now the good news: I have hardware to try finding the source of this problem
> again ;-) If I'll find some time, I'll try driver version 1.5c.

I have CD/RW. I can run your test process on my machines and see how it
behaves (2xPIII/LE chipset and 1xAthlon/KT266 chipset).

As driver sym-2 is planned to replace sym53c8xx in the future, it would be
interesting to give it a try on your hardware. There are some source
available from ftp.tux.org, but I can provide you with a flat patch
against the stock kernel version you want. You may let me know.

Regards,
  Gérard.

