Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRCSIFq>; Mon, 19 Mar 2001 03:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131375AbRCSIFg>; Mon, 19 Mar 2001 03:05:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6924 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131369AbRCSIFW>;
	Mon, 19 Mar 2001 03:05:22 -0500
Date: Mon, 19 Mar 2001 07:33:56 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
Message-ID: <20010319073356.A16622@flint.arm.linux.org.uk>
In-Reply-To: <200103031249.f23Cn4R01208@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103031249.f23Cn4R01208@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Mar 03, 2001 at 12:49:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2001 at 12:49:04PM +0000, Russell King wrote:
> Hi,
> 
> I've noticed that one of my machines here suffers from the "time going
> backwards problem" and so started thinking about the x86 solution.
> 
> I've come to the conclusion that it has a hole which could cause it
> to return the wrong time in one specific case:
> 
> - in do_gettimeofday(), we disable irqs (read_lock_irqsave)
> - the ISA timer wraps, but we've got interrupts disabled, so no update
>   of xtime or jiffies occurs
> - in do_slow_gettimeoffset(), we read the timer, which has wrapped
> - since jiffies_p != jiffies, we do not apply any correction
> - our idea of time is now one jiffy slow.

I never heard any response to this.  Could some knowledgeable person please
take a look at it?

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

