Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265431AbUF2Ehn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUF2Ehn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbUF2Ehn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:37:43 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:11936 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265431AbUF2Egm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:36:42 -0400
Message-ID: <40E0F1D6.5090506@yahoo.com.au>
Date: Tue, 29 Jun 2004 14:36:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de>	 <200406261929.35950.mbuesch@freenet.de>	 <1088363821.1698.1.camel@teapot.felipe-alfaro.com>	 <200406272128.57367.mbuesch@freenet.de>	 <1088373352.1691.1.camel@teapot.felipe-alfaro.com>	 <Pine.LNX.4.58.0406281013590.11399@kolivas.org>	 <1088412045.1694.3.camel@teapot.felipe-alfaro.com>	 <40DFDBB2.7010800@yahoo.com.au>	 <1088423626.1699.0.camel@teapot.felipe-alfaro.com>	 <40E00AEA.4050709@kolivas.org> <1088442705.1699.7.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1088442705.1699.7.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Mon, 2004-06-28 at 22:11 +1000, Con Kolivas wrote:
> 
> 
>>The design of staircase would make renicing normal interactive things
>>- -ve values bad for the latency of other nice 0 tasks s is not
>>recommended for X or games etc. Initial scheduling latency is very
>>dependent on nice value in staircase. If you set a cpu hog to nice -5 it
>>will hurt audio at nice 0 and so on. Nicing latency unimportant things
>>with +ve values is more useful with this design. If you run X and
>>evolution at the same nice value they will get equal cpu share for
>>example so moving windows means redrawing evolution and X moving get
>>equal cpu. Nicing evolution +ve will make X smoother compared to
>>evolution redrawing and so on...
> 
> 
> OK, just a few thoughts...
> 
> 1. Both -mm3 and -np2 suffer from delays when redrawing "damaged"
> windows (windows which were covered and now are being exposed): while
> moving heavily a window over the screen, "damaged" windows are not
> redrawn. I would say this is a sign of starvation. However, this does
> not happen with -ck3 that is able to redraw "damaged' windows even while
> heavily moving a window all over the screen.
> 
> I can see this by looking at some icons that are lying on my desktop.
> With -mm3 and -np2, they are hardly redrawn while heavily moving a
> window all around. With -ck3, I can see the icons and their respective
> labels all the time.
> 
> 2. Both -mm3 and -np2 show a very smooth behavior when moving windows
> all around the screen. However, -ck3 is somewhat a little bit jerky. I
> think this is a consequence of point number 1.
> 

Try having X at a lower priority (higher nice) and it shouldn't get
as much of the CPU. I think this is really a fundamental tradeoff
that you can't do much about.

> 3. Both -mm3 and -ck3 are inmune to CPU hogs when mantaining
> interactivity: running "while true; do a=2; done" doesn't seem to affect
> the interactive behavior of them. I check this by running this CPU hog
> and hovering my mouse over KXDocker, which is a nice applet for KDE
> similar to the Mac OS X docker. KXDocker is another CPU hog by itself,
> but plays nicely with the "while true" loop. However, -np2 seems to
> suffer a little bit from starvation, as KXDocker animations don't feel
> smooth.
> 

Hmm, in that case bash should go straight down to lowest priority,
so it shouldn't impact too much on others' CPU usage... I'll see
what I can do though, timeslices could still be a little too big.
