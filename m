Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbRADILk>; Thu, 4 Jan 2001 03:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRADILa>; Thu, 4 Jan 2001 03:11:30 -0500
Received: from Cantor.suse.de ([194.112.123.193]:48401 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129477AbRADILY>;
	Thu, 4 Jan 2001 03:11:24 -0500
Date: Thu, 4 Jan 2001 09:11:18 +0100
From: Andi Kleen <ak@suse.de>
To: Daniel Phillips <phillips@innominate.de>
Cc: ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
Message-ID: <20010104091118.A18973@gruyere.muc.suse.de>
In-Reply-To: <3A53D863.53203DF4@sun.com> <3A5427A6.26F25A8A@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5427A6.26F25A8A@innominate.de>; from phillips@innominate.de on Thu, Jan 04, 2001 at 08:35:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 08:35:02AM +0100, Daniel Phillips wrote:
> A more ambitious way to proceed is to change spinlocks so they can sleep
> (not in interrupts of course).  There would not be any extra overhead

Imagine what happens when a non sleeping spinlock in a interrupt waits 
for a "sleeping spinlock" somewhere else...
I'm not sure if this is a good idea. Sleeping locks everywhere would
imply scheduled interrupts, which are nasty. 

I think a better way to proceed would be to make semaphores a bit more 
intelligent and turn them into something like adaptive spinlocks and use
them more where appropiate (currently using semaphores usually causes
lots of context switches where some could probably be avoided). Problem
is that for some cases like your producer-consumer pattern (which has been
used previously in unreleased kernel code BTW) it would be a pessimization
to spin, so such adaptive locks would probably need a different name.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
