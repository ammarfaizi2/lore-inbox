Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSIBIMM>; Mon, 2 Sep 2002 04:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318207AbSIBIMM>; Mon, 2 Sep 2002 04:12:12 -0400
Received: from p508475D0.dip.t-dialin.net ([80.132.117.208]:52710 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S318184AbSIBIML>;
	Mon, 2 Sep 2002 04:12:11 -0400
To: Andre Hedrick <andre@linux-ide.org>
Cc: Mike Isely <isely@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
References: <Pine.LNX.4.10.10208302313040.1033-100000@master.linux-ide.org>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Mon, 02 Sep 2002 10:16:14 +0200
In-Reply-To: <Pine.LNX.4.10.10208302313040.1033-100000@master.linux-ide.org> (Andre
 Hedrick's message of "Fri, 30 Aug 2002 23:24:38 -0700 (PDT)")
Message-ID: <m33css7qnl.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:

> On Sat, 31 Aug 2002, Mike Isely wrote:
>
>> On Fri, 30 Aug 2002, Andre Hedrick wrote:
>> 
>> > When you said you put it on primary channel, I realized that you have a
>> > system that breaks the rules of Promise and I am not sure.
>> 
>> What are the "rules of Promise" or where may I find such information?
>
> You do not want to sign the NDA's to get the data sheets, aquire all the
> hardware to test, generate tables of irregularities, query Promise, and
> then scratch your head why.
>
> I have a FastTrak 100 TX4 the BIOS fails to see beyond 128GB, but in
> practice it does.
>
> The PDC20267 will puke in 48-bit DMA, but run clean in 48-bit PIO :-/
> Oh but that is the primary channel, Seconday Channel is clean both ways :-\
>
> PDC20262 works in 48-bit DMA every where.
>
> PDC20265 similar to PDC20267 except yours.
>
> Rules are emperical tests and rants back at the OEM, and ....

Another data point: My experiences with 2.4.19-pre4-ac2 are remarkably
similar to Mike Isley's, but for a few interesting differences:

- 2.4.18 runs O.K.
- 2.4.19 hangs when checking for partitions
- 2.4.19-ac4 hangs, too
- 2.4.20-pre4 hangs, too
- 2.4.20-pre4-ac2 does not hang, but shows problems exactly as Mike is
  describing:
  - Claims 80pin cable is missing
  - wrong data read from disk, write based on wrong read trashes fs

My hardware:
o Promise PDC20262 On-Board on a GigaByte GA-6BX7+ (Intel 440BX)
o Maxtor 120G (4G120J6)

>> > grep "hwif->addressing" pdc202xx.c
>> > 
>> > Stub out the three lines.
>> > 
>> > Recompile and reboot, it will be fixed
>> 
>> Will do.  Thanks.  If you have a more permanent fix you'd like me to 
>> test, let me know.
>
> Oh another dang piece of the puzzle found and it does not fit anywhere!

Does this fix the bogus 80-pin message or does it just have to do with
block addressing and thus the "corruption" issue?

I'm asking because the 20262 seems to break ATAPI devices completely
once it was in a "wrong" mode. I.e. if my PX-W1610 on the second
channel is correctly detected as MDMA2 it works, if it is detected as
something else and I try to tweak it the channel and/or controller
hangs.

Can I somewhere get a complete picture of what is *supposed* to work
with the '62 and what not?

Thanks a lot!


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
