Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTH1Fqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbTH1Fqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:46:34 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:6790 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263784AbTH1FkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:40:08 -0400
Date: Thu, 28 Aug 2003 08:40:00 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: TeJun Huh <tejun@aratech.co.kr>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030828053959.GA83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	TeJun Huh <tejun@aratech.co.kr>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel@vger.kernel.org
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030827064301.GF150921@niksula.cs.hut.fi> <20030827071259.GV83336@niksula.cs.hut.fi> <20030827092139.4d75ef4a.skraw@ithnet.com> <20030827073758.GW83336@niksula.cs.hut.fi> <20030828011341.GA19622@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030828011341.GA19622@atj.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 10:13:41AM +0900, you [TeJun Huh] wrote:
> 
>  Your problem sounds very simlar to the problem we were suffering.
> The problem was a spinlock deadlock inside drivers/char/random.c which
> is used by tcp to generate random initial sequence number.  The bug
> fix was checked into 2.4 tree on 28th July after the release of pre8
> at 14th July.

Uhh, I tried 2.4.22pre8 a while ago (I think it was Herbert Pötzl's
suggestion), and it locked up too. Shame that the fix didn't make it in
it...

I'll give .22-final a spin.
 
> This problem can happen on UP machine if the kernel is compiled with
> CONFIG_SMP.

This is UP box and the kernel is _not_ compiled with CONFIG_SMP.

> Because the offending routine is called only every five
> minutes and it should receive a SYN packet while it's connecting, it
> occurs rarely, but it happens when it happens.

In my case, the lock up seems clearly related to disk io: it usually happens
during the nightly oracle backup dump, and at some point it kept happening
while compiling kernel. (It's random, I can no longer reproduce it by just
compiling a kernel.)

Do you still think it could be the same one?

>  Please try 2.4.22.
> 
> P.S. This bug is a real headache.  We had many servers deployed and
> they all randomly locked up about every two or four weeks.  I believe
> people should be warned about this one.

What's really strange is that the box kept running with 2.4.20pre7 for
almost a year without problems (with the same oracle dump jub in nightly
cron), and then suddenly begun acting up on my the first day of my summer
vacation...


-- v --

v@iki.fi
