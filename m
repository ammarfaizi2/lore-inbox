Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTBDGmd>; Tue, 4 Feb 2003 01:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbTBDGmd>; Tue, 4 Feb 2003 01:42:33 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:21265 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267125AbTBDGmc>; Tue, 4 Feb 2003 01:42:32 -0500
Message-Id: <200302040643.h146gps10473@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: [PATCH *] use 64 bit jiffies
Date: Tue, 4 Feb 2003 08:41:13 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0302022347440.24857-100000@gans.physik3.uni-rostock.de> <200302030644.h136iXs04935@Port.imtp.ilyichevsk.odessa.ua> <20030203082800.GT821@mea-ext.zmailer.org>
In-Reply-To: <20030203082800.GT821@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 February 2003 10:28, Matti Aarnio wrote:
> On Mon, Feb 03, 2003 at 08:42:59AM +0200, Denis Vlasenko wrote:
> > On 3 February 2003 00:55, Tim Schmielau wrote:
> > > Just a note that I have rediffed for 2.5.55 the patches that use
> > > the 64 bit jiffies value to avoid uptime and process start time
> > > wrap after 49.5 days. I will push them Linus-wards when he's
> > > back. They can be retrieved from
>
> ....
>
> > Wow... your patches are STILL not included??
> > My 2.4 based server approaches 250 days uptime, it would be a shame
> > to be unable to have uptime < 50 days with 2.5
>
> You don't need to have 64-bit jiffy for things like internal
> timers, nor for uptime tracking.
>
> Timers have well behaving constructs to use 32-bit jiffy quite
> successfully, and 64-bit values, especially atomicish, in 32-bit
> register-poor machines (i386) are damn difficult.
>
> I do have a number of machines with 100 to 300 day uptimes, all
> with "mere" 32-bit jiffy.  With 1000 Hz clock that means at least
> one full wrap-around of jiffy.

Your processes will show strange start times, CPU times etc.
This will happen in 2.5 pretty soon (after 50 days uptime).

However, this is a bit cosmetic. There is a much more serious problem:

		Jiffy Wrap Bugs

There were reports of machines hanging on jiffy wrap.
This is typically a result of incorrect jiffy use in some driver.
Ask Tim - he is hunting those problems regularly, but he is outnumbered
by buggy driver authors. :(

There is a better solution to ensure correct jiffy wrap handling in
*ALL* kernel code: make jiffy wrap in first five minutes of uptime.
Tim has a patch for such config option. This is almost right.
This MUST NOT be a config option, it MUST be mandatory in every
kernel. Driver writers would be bitten by their own bugs and will
fix it themself. Tim, what do you think?
--
vda
