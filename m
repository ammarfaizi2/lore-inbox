Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUADDcT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 22:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUADDcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 22:32:19 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:54534 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265100AbUADDcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 22:32:17 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1073186591@astro.swin.edu.au>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
In-reply-to: <200401041242.47410.kernel@kolivas.org>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-25573-3125-200401041423-tc@hexane.ssi.swin.edu.au>
Date: Sun, 4 Jan 2004 14:32:13 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> said on Sun, 4 Jan 2004 12:42:47 +1100:
> On Sun, 4 Jan 2004 10:35, Willy Tarreau wrote:
> > 6) Conclusion
> > =============
> >
> > Under 2.4, xterm uses jump scrolling which it does not use by default under
> > 2.6 if X responds fast enough. The first dirty solution which comes to mind
> > is to renice X to >+10 to slow it a bit so that xterm hits the high water
> > level and jumps.
> >
> > But it's not an effect of the scheduler alone, but a side effect of the
> > scheduler and xterm both trying to automatically adjust their behaviour in
> > a different manner. 
> 
> Not quite. The scheduler retains high priority for X for longer so it's no new 
> dynamic adjustment of any sort, just better cpu usage by X (which is why it's 
> smoother now at nice 0 than previously). 
> 
> > If either the scheduler or xterm was a bit smarter or 
> > used different thresholds, the problem would go away. It would also explain
> > why there are people who cannot reproduce it. Perhaps a somewhat faster or
> > slower system makes the problem go away. Honnestly, it's the first time
> > that I notice that my xterms are jump-scrolling, it was so much fluid
> > anyway.
> 
> Very thorough but not a scheduler problem as far as I'm concerned. Can you not 
> disable smooth scrolling and force jump scrolling?

AFAIK the definition of jump scrolling is that if xterm is falling
behind, it jumps. Jump scrolling is enabled by default.

What this slowness means is that xterm is getting CPU at just the
right moments that it isn't falling behind, so it doesn't jump - which
means X gets all the CPU to redraw, which means your ls/dmesg anything
else that reads from disk[1] doesn't get any CPU. 

Xterm is already functioning as designed - you can't force jump
scrolling to jump more - it is at the mercy of how it gets
scheduled. If there is nothing more in the pipe to draw, it has to
draw.

These bloody interactive changes to make X more responsive are at the
expense of anything that does *real* work.


[1] Others say that it only affects them first time through - after
something is cached, it goes back to normal speed. For me - it is slow
*all* the time. If I pipe it to cat or tail or something, it is a
*lot* quicker.



-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Beware of Programmers who carry screwdrivers.
