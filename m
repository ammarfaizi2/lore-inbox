Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132675AbRADMpS>; Thu, 4 Jan 2001 07:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132973AbRADMpI>; Thu, 4 Jan 2001 07:45:08 -0500
Received: from Cantor.suse.de ([194.112.123.193]:45578 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132675AbRADMot>;
	Thu, 4 Jan 2001 07:44:49 -0500
Date: Thu, 4 Jan 2001 13:44:35 +0100
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: Andi Kleen <ak@suse.de>, Daniel Phillips <phillips@innominate.de>,
        ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
Message-ID: <20010104134435.A25106@gruyere.muc.suse.de>
In-Reply-To: <3A53D863.53203DF4@sun.com> <3A5427A6.26F25A8A@innominate.de> <20010104091118.A18973@gruyere.muc.suse.de> <20010104233211.A20942@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104233211.A20942@linuxcare.com>; from anton@linuxcare.com.au on Thu, Jan 04, 2001 at 11:32:11PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 11:32:11PM +1100, Anton Blanchard wrote:
>  
> > I think a better way to proceed would be to make semaphores a bit more 
> > intelligent and turn them into something like adaptive spinlocks and use
> > them more where appropiate (currently using semaphores usually causes
> > lots of context switches where some could probably be avoided). Problem
> > is that for some cases like your producer-consumer pattern (which has been
> > used previously in unreleased kernel code BTW) it would be a pessimization
> > to spin, so such adaptive locks would probably need a different name.
> 
> Like solaris adaptive mutexes? It would be interesting to test,
> however considering read/write semaphores are hardly ever used these
> days we want to be sure they are worth it before adding yet another
> synchronisation primitive.

A bit similar, yes, but much simpler @-)

The problem is that current Linux semaphores are very costly locks -- they
always cause a context switch.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
