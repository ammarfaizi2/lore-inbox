Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbULIIaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbULIIaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 03:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbULIIaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 03:30:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:56221 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261426AbULII37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 03:29:59 -0500
Subject: Re: [RFC] New timeofday proposal (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <amax@us.ibm.com>, mahuja@us.ibm.com
In-Reply-To: <41B81364.5446.EEE6E75@rkdvmks1.ngate.uni-regensburg.de>
References: <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
	 <41B81364.5446.EEE6E75@rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 00:29:52 -0800
Message-Id: <1102580992.7511.10.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 08:57 +0100, Ulrich Windl wrote:
> On 8 Dec 2004 at 15:36, john stultz wrote:
> 
> [...]
> > Take a look at the adjtimex man page as well as the ntp.c file from the
> > timeofday core patch. There are number of different types of adjustments
> > that are made, possibly at the same time. Briefly, they are (to my
> > understanding - I'm going off my notes from awhile ago): 
> > o tick adjustments
> > 	how much time should pass in a _user_ tick
> 
> tick adjustments are considered obsolete, because if a lcok implementation (or 
> hardware) is severly broken, users should reject using that stuff. Meaning: tick 
> adjustments are ment to be set once in the life of a computer system. No 
> continuous tuning.
> 
> > o frequency adjustments
> > 	long term adjustment to correct for constant drift), 
> 
> Actually, you are compensating for a "tick problem" on a smaller scale (constant 
> part), and variations caused by temperature, voltage, and others (variable part).
> 
> > o offset adjustments
> > 	additional ppm adjustment to correct for current offset from the ntp
> > server
> > o single shot offset adjustments 
> > 	old style adjtime functionality
> > 
> > Tick, frequency and offset adjustments can be precalculated and summed
> > to a single ppm adjustment. This is similar to the style of adjustment
> > you propose directly onto the time source frequency values. 
> > 
> > However, there is also this short term single shot adjustments. These
> > adjustments are made by applying the MAX_SINGLESHOT_ADJ (500ppm) scaling
> > for an amount of time (offset_len) which would compensate for the
> > offset. This style is difficult because we cannot precompute it and
> > apply it to an entire tick. Instead it needs to be applied for just a
> > specific amount of time which may be only a fraction of a tick. When we
> 
> Yes, that's the "precise" variant of implementing it. Poor implementations are 
> just accurate to one tick.

Thanks for your knowledgeable clarifications. Its good to know someone
out there deeply understands this stuff more then at a "this is what the
code is doing, and I have my own interpretation as to why" level. :)

thanks again,
-john


