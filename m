Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319612AbSH3QzW>; Fri, 30 Aug 2002 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319613AbSH3QzW>; Fri, 30 Aug 2002 12:55:22 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:50050 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319612AbSH3QzV>; Fri, 30 Aug 2002 12:55:21 -0400
To: Anssi Saari <as@sci.fi>
Cc: Sergio Bruder <sergio@bruder.net>, Andre Hedrick <andre@linux-ide.org>,
       vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is
 enabled
References: <200204092206.02376.roger.larsson@norran.net>
	<Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org>
	<20020414123935.GA6441@sci.fi> <20020830043346.GA5793@bruder.net>
	<87d6s0g9eq.fsf@plailis.homelinux.net> <20020830065142.GA10582@sci.fi>
	<874rdcg62f.fsf@plailis.homelinux.net> <20020830154225.GA6114@sci.fi>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Fri, 30 Aug 2002 18:58:09 +0200
Message-ID: <873cswuvvi.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anssi!

* Anssi Saari writes:
>On Fri, Aug 30, 2002 at 09:27:04AM +0200, Markus Plail wrote:
>>* Anssi Saari writes:
>>>I also don't have your DAO vs. TAO problem.
>>
>>Hmm.. you wrote that cdrdao gives the problem, but cdrecord doesn't.
>
>I doubt that. Even if I did, it's wrong.

Yes, sorry, it was Sergio.

>>And in a previous mail you wrote that you also have the problems when
>>writing audio CDs.
>
>Yes. Audio CDs and VCDs, to be exact. Probably anything other than
>vanilla ISO9660.

It's not only the content that matters, but the way the content is
written to CD. If you write your stuff in TAO or SAO (which can be DAO,
DAO alone isn't valid) it's no problem. Examples are:
- cdrecord -dao ...
- cdrdao --driver generic-mmc

If you write CDs in RAW modes, then there's the problem with the high
loads. Examples:
- cdrecord -raw96r/p (2448 bytes/sector)
- cdrecord -raw16    (2368 bytes/sector)
- cdrdao --driver generic-mmc-raw (2368 bytes/sector)

So for Sergio: Try using the generic-mmc without raw driver in cdrdao.

And audio CDs or (S)VCDs are written in mode2 (2352 bytes/sector) and
also cause the high loads, this time independent from the writing mode.
AFAIK this behaviour should be the same on any Linux system.

regards
Markus

