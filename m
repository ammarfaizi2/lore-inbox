Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbVLVJBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbVLVJBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 04:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVLVJBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 04:01:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:31369 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965141AbVLVJBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 04:01:50 -0500
Date: Thu, 22 Dec 2005 10:01:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH/RFC 10/10] example of simple continuous gettimeofday
Message-ID: <20051222090112.GA6377@elte.hu>
References: <Pine.LNX.4.61.0512220028250.30930@scrub.home> <1135219395.5873.96.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135219395.5873.96.camel@leatherman>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> > - I still don't like the idea of a generic gettimeofday() as it prevents
> >   more optimized versions, e.g. on the one end with a 1MHz clock you only
> >   have usec resolution anyway and this allows to keep almost everything
> >   within 32bits. On the other end 64bit archs can avoid the "if (nsec >
> >   NSEC_PER_SEC)" by doing something like ppc64 does, but requires a
> >   different scaling of the values (to sec instead of nsec).
> 
> Fair enough. I agree arches should be able to have their own arch 
> specific implementations. If you really have to micro-optimize 
> everything, just don't enable CONFIG_GENERIC_TIME and have your own 
> timekeeping subsystem!
> 
> But at the same time, I don't like the idea of needlessly having 26 
> different versions of gettimeofday that do exactly the same thing 
> modulo a few bugs. :)

I like the first 9 patches, but regarding 10/10 i very much agree with 
John: it moves us to per-arch gettimeofday again, which is a big step 
backwards and reverts some of the biggest advantage of John's 
clocksource patchset!

Also, lets face it: with the union ktime_t type most of the '64-bit is 
slow on 32-bit' issues are much less of a problem. If some 32-bit arch 
wants to pull off its own timekeeping system, it can do so - but 
otherwise we want to move towards generic, unified (as far as it makes 
sense) and generally 64-bit-optimized subsystems. In 1995 i'd have 
agreed with Roman, but not in 2005.

	Ingo
