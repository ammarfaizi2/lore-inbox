Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSHTW40>; Tue, 20 Aug 2002 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSHTW40>; Tue, 20 Aug 2002 18:56:26 -0400
Received: from waste.org ([209.173.204.2]:16797 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317473AbSHTW40>;
	Tue, 20 Aug 2002 18:56:26 -0400
Date: Tue, 20 Aug 2002 18:00:23 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: johan.adolfsson@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Message-ID: <20020820230023.GA19951@waste.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org> <03f401c24867$2d5260c0$b9b270d5@homeip.net> <20020820170601.GD19225@waste.org> <050b01c2486f$c6701880$b9b270d5@homeip.net> <20020820180257.GF19225@waste.org> <05da01c2487e$b2321120$b9b270d5@homeip.net> <20020820193408.GG19225@waste.org> <05fe01c24897$5e0a7380$b9b270d5@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05fe01c24897$5e0a7380$b9b270d5@homeip.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 12:17:26AM +0200, johan.adolfsson@axis.com wrote:

> I just compared the generated asm:
> Accurate timestamp scaled to ns: 45 instructions (resolution actually 40 ns)
> Approximate 40 ns resolution: 21 instructions
> Approximate 40 us resolution: 9 instructions
> For comparison one syscall path (gettimeofday()) is approx 400 instructions
> and the add_timer_randomness() function that only uses jiffies is 76
> instructions, so mayby I'm microoptimising here?
> Is it worth the cycles to get 40 ns resolution instead of 40us ?

Seems like it's probably worth the effort. In practice, such
difference often are lost in the noise compared to cache flushes, etc.
Does the 'correct' code suffer branch penalties or the like that might
make it significantly worse than the quick code? If not, then I'd say
definitely use it.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
