Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSHTR7C>; Tue, 20 Aug 2002 13:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSHTR7C>; Tue, 20 Aug 2002 13:59:02 -0400
Received: from waste.org ([209.173.204.2]:43485 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317022AbSHTR7B>;
	Tue, 20 Aug 2002 13:59:01 -0400
Date: Tue, 20 Aug 2002 13:02:57 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: johan.adolfsson@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Message-ID: <20020820180257.GF19225@waste.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org> <03f401c24867$2d5260c0$b9b270d5@homeip.net> <20020820170601.GD19225@waste.org> <050b01c2486f$c6701880$b9b270d5@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050b01c2486f$c6701880$b9b270d5@homeip.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 07:34:02PM +0200, johan.adolfsson@axis.com wrote:
> > > Put an inline function or macro in asm/timex.h (?) together with an
> > > ARCH_HAS_RANDOM_TIMESTAMP define?
> > 
> > I don't think we want to make it specific to random. I think we just
> > want to call it hires. 
> > 
> > > E.g. like this for i386:
> > > #define ARCH_HAS_RANDOM_TIMESTAMP
> > > #define RANDOM_TIMESTAMP(time, num) do{\
> ..  
> > > And then in random.c:
> > > ifdef ARCH_HAS_RANDOM_TIMESTAMP
> > >   RANDOM_TIMESTAMP(time, num);
> > > #else
> > >   time = jiffies;
> > > #endif
> > 
> > Again, too random-specific. And we need a way to get the timescale.
> > Perhaps something like:
> > 
> > speed=get_timestamp_khz;
> > lowbits=get_hires_timestamp();
> 
> But isn't the "num ^= high;" a way to improve the randomness
> and the high value doesn't really need to be linear to the time?

No, the high order bits aren't very interesting at all. Don't worry
about that bit, it's just cuteness.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
