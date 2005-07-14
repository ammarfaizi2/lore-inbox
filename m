Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVGNMTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVGNMTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVGNMTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:19:52 -0400
Received: from styx.suse.cz ([82.119.242.94]:63909 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261225AbVGNMTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:19:51 -0400
Date: Thu, 14 Jul 2005 14:19:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050714121950.GB1072@ucw.cz>
References: <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <m34qaxlm57.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34qaxlm57.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 12:25:40PM +0200, Krzysztof Halasa wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > And in short-term things, the timeval/jiffie conversion is likely to be a 
> > _bigger_ issue than the crystal frequency conversion.
> >
> > So we should aim for a HZ value that makes it easy to convert to and from
> > the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> > good values for that reason. 864 is not.
> 
> Probably only theoretical, and probably the hardware isn't up to it...
> But what if we have:
> - 64-bit jiffies done in hardware (a counter). 1 cycle = 1 microsecond
>   or even a CPU clock cycle. Can *APIC or another HPET do that?

HPETs have a fixed frequency (usually 14.31818 MHz, but that depends
on the manufacturer).

> - 64-bit "match timer" (i.e., a register in the counter which fires IRQ
>   when it matches the counter value)

That's implemented in the HPET hardware.

> - the CPU(s) sorting the timer list and programming "match timer" with
>   software timer next to be executed. Upon firing the timer, a new "next
>   to be executed" timer would be programmed into the counter's "match
>   timer".
> 
> We would have no timer ticks when nobody requested them - the CPUs would
> be allowed to sleep for, say, even 50 ms when no task is RUNNING.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
