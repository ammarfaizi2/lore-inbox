Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbRLWBpQ>; Sat, 22 Dec 2001 20:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283056AbRLWBpH>; Sat, 22 Dec 2001 20:45:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283054AbRLWBo5>; Sat, 22 Dec 2001 20:44:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: AMD SC410 boot problems with recent kernels
Date: 22 Dec 2001 17:44:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a03cuj$661$1@cesium.transmeta.com>
In-Reply-To: <3C23B308.9080800@zytor.com> <Pine.LNX.4.33.0112221520300.10528-100000@callisto.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0112221520300.10528-100000@callisto.local>
By author:    Robert Schwebel <robert@schwebel.de>
In newsgroup: linux.dev.kernel
> 
> > what probably makes more sense to output is the value of %dx in your
> > code.
> 
> %dx? Do you mean %cx or do I not understand the code? ;)
> 

I mean %dx -- you'd built a 32-bit counter into %dx:%cx.

> > I would like to suggest making the following changes and try them out:
> >
> > a) Change A20_TEST_LOOPS to something like 32768 in the new kernel code.
> 
> Still reboots.
> 
> > b) Add a "call delay" between the movw and the cmpw in your old_loop
> >    and see if it suddenly breaks;
> 
> No, it still works.
> 
> > c) Check what your %dx value is (if it's nonzero, there might be an
> >    issue.)
> 
> I assume you mean in my old_wait code, at the lines where I give out the
> stuff to the LED ports? Neither %dl nor %dh has something different from
> 0 here. How could something come into %dx here?

It's part of the counter.  This seems to be *your* code, since there
is nothing even closely similar in any previous kernel, so I don't
know what you're trying to do here...

> > d) Once again, please complain to your motherboard/BIOS vendor and tell
> >    them to implement int 15h, ax=2401h.
> 
> I'll do that, but this won't help for the hundrets of boards which are
> still out there and worked fine with the previous code...

Doesn't change the fact that the board is still broken, and they
didn't provide the BIOS routine to compensate.  At that point, the
fact that the old code worked by accident is unfortunately irrelevant;
especially since you obviously have a workaround that you can use.

> > e) Add a strictly serializing instruction sequence, such as:
> >
> > 	pushw %dx
> > 	smsw %dx
> > 	lmsw %dx
> > 	popw %dx
> >
> >    ... where the "call delay" call is in a20_test.
> 
> Hope I understand you correctly - I'm not an assembler wizzard yet ;) Is
> this correct:
> 

No, but the sequence in verbatim either before or after the call
delay.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
