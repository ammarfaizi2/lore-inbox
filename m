Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSHTTaL>; Tue, 20 Aug 2002 15:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSHTTaL>; Tue, 20 Aug 2002 15:30:11 -0400
Received: from waste.org ([209.173.204.2]:44011 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317257AbSHTTaK>;
	Tue, 20 Aug 2002 15:30:10 -0400
Date: Tue, 20 Aug 2002 14:34:09 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: johan.adolfsson@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Message-ID: <20020820193408.GG19225@waste.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org> <03f401c24867$2d5260c0$b9b270d5@homeip.net> <20020820170601.GD19225@waste.org> <050b01c2486f$c6701880$b9b270d5@homeip.net> <20020820180257.GF19225@waste.org> <05da01c2487e$b2321120$b9b270d5@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05da01c2487e$b2321120$b9b270d5@homeip.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 09:20:50PM +0200, johan.adolfsson@axis.com wrote:
> > > > Perhaps something like:
> > > > 
> > > > speed=get_timestamp_khz;
> > > > lowbits=get_hires_timestamp();
> > > 
> > > But isn't the "num ^= high;" a way to improve the randomness
> > > and the high value doesn't really need to be linear to the time?
> > 
> > No, the high order bits aren't very interesting at all. Don't worry
> > about that bit, it's just cuteness.
> 
> ok:-)
> But if the the timestamp doesn't have to be entirely accurate
> the name should perhaps reflect that, since at least on the cris arch
> you can save some cycles if you can accept a glitch now and then.

Describe this glitch again? Bear in mind that resolution is a very
different matter than accuracy. Jiffies are not accurate in any
absolute sense, but they are monotonic. And unless you've got
interrupts shut off, even get_cycles can only giving you the time
when it stores the timestamp in the register, which may have little to
do with the time the next instruction that uses it executes.

> We want to be able to separate it from similar functions used
> for high-res timers etc. which need a more accurate function.

Bear in mind that most arches won't have this sort of difficulty so in
the bigger picture, this might be overkill. Put a comment next to the
generic function that says "might not be accurate" and when a user of
the interface comes along that actually cares about accuracy, the
situation can be reevaluated.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
