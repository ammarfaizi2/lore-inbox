Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319437AbSH3GMX>; Fri, 30 Aug 2002 02:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319442AbSH3GMX>; Fri, 30 Aug 2002 02:12:23 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:49310 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319437AbSH3GMW>; Fri, 30 Aug 2002 02:12:22 -0400
To: Sergio Bruder <sergio@bruder.net>
Cc: Anssi Saari <as@sci.fi>, Andre Hedrick <andre@linux-ide.org>,
       vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is
 enabled
References: <200204092206.02376.roger.larsson@norran.net>
	<Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org>
	<20020414123935.GA6441@sci.fi> <20020830043346.GA5793@bruder.net>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Fri, 30 Aug 2002 08:14:53 +0200
In-Reply-To: <20020830043346.GA5793@bruder.net> (Sergio Bruder's message of
 "Fri, 30 Aug 2002 01:33:46 -0300")
Message-ID: <87d6s0g9eq.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergio!

* Sergio Bruder writes:
>On Sun, Apr 14, 2002 at 03:39:35PM +0300, Anssi Saari wrote:
>>(...)
>>
>>I have now tried the writer on an old Pentium motherboard with Intel
>>430HX chipset and PIIX3. The performance problems didn't happen there,
>>so I would guess this is more a problem with how Linux handles the VIA
>>686b southbridge.
>>
>>But what can I do to help fix this problem?

>We are now in 2.4.20-preBLAH time and appears that VIA 686b southbridge
>still has the same problem (and appears to be that dont surface with
>anothers controllers)

>Ive just burned a image (.cue/.bin) with cdrdao and my load went nuts,
>up to 5. Same motherboard chipset, same general conditions.  KT133a,
>VIA 686b southbridge, in that case with a LG combo drive (HL-DT-ST
>RW/DVD GCC-4120B), hard-disk as /dev/hda (with ReiserFS), combo drive
>as /dev/hdc.

>What is strange is that problem dont appears with ISO images
>(cdrecord-burned). There is any already-know solution for that problem
>with VIA686b IDE?

The problem isn't really the southbridge, the problem is, that the
kernel doesn't seem to use (I still didn't get a definitive answer)
DMA when doing things with bigger blocksizes (grabbing audio CDs,
writing DAO CDs). That's why you don't have a problem burning 'normal'
TAO CDs. It seems that older chipsets just deal way better with PIO
modes (the PIIX3 doesn't have DMA, does it?).
For me it helped at least a bit to do the following:
- Disable interrupt sharing for IDE devices
- hdparm -d1 -c3 -u0 -X34/66 /dev/burner

With this settings I have 30% processor usage when writing at speed 20,
as opposed to at least 60% I had before.

regards
Markus

