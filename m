Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHVPzJ>; Thu, 22 Aug 2002 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSHVPzI>; Thu, 22 Aug 2002 11:55:08 -0400
Received: from ALyon-209-1-13-54.abo.wanadoo.fr ([217.128.17.54]:27067 "EHLO
	alph.dyndns.org") by vger.kernel.org with ESMTP id <S293203AbSHVPzC>;
	Thu, 22 Aug 2002 11:55:02 -0400
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy
	calculation
From: Yoann Vandoorselaere <yoann@prelude-ids.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       cpufreq@lists.arm.linux.org.uk, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D65020D.5070201@iram.es>
References: <3D64D51C.9040603@iram.es> <20020822143115.15323@192.168.4.1> 
	<3D65020D.5070201@iram.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Aug 2002 17:59:19 +0200
Message-Id: <1030031960.15427.237.camel@alph>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 17:23, Gabriel Paubert wrote:
> Benjamin Herrenschmidt wrote:
> >>Well, first on sane archs which have an easily accessible, fixed
> >>frequency time counter, loops_per_jiffy should never have existed :-)
> >>
> >>Second, putting this code there means that one day somebody will
> >>inevitably try to use it outside of its domain of operation (like it
> >>happened for div64 a few months ago when I pointed out that it would not
> >>work for divisors above 65535 or so).
> > 
> > 
> > Well... it's clearly located inside kernel/cpufreq.c, so there is
> > little risk, though it may be worth a big bold comment
> 
> Hmm, in my experience people hardly ever read detailed comments even 
> when they are well-written. Perhaps if you called the function 
> imprecise_scale or coarse_scale, it might ring a bell.
> 
> Besides that functions should do one thing and do that *well*[1]. Well, 
> I'm usually not too dogmatic, but this function breaks the second rule
> beyond what I find acceptable.

At least it report *correct* result (when the old one was returning BS
because of the 32 bits integer overflow). Doing it well require per
architecture support.

 
> >>In this case a generic scaling function, while not a standard libgcc/C
> >>library feature has potentially more applications than this simple 
> >>cpufreq approximation. But I don't see very much the need for scaling a 
> >>long (64 bit on 64 bit archs) value, 32 bit would be sufficient.
> > 
> > 
> > Well... if you can write one, go on then ;) In my case, I'm happy
> > with Yoann implementation for cpufreq right now. Though I agree that
> > could ultimately be moved to arch code.

[...]

> [1] Documentation/CodingStyle, which also claims that functions should 
> be short and *sweet*. Well, I found the patch far too bitter ;-).

No wonder why you're loosing contributor with such comportment.

-- 
Yoann Vandoorselaere, http://www.prelude-ids.org

"Programming is a race between programmers, who try and make more and 
 more idiot-proof software, and universe, which produces more and more 
 remarkable idiots. Until now, universe leads the race"  -- R. Cook

