Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbULIH5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbULIH5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 02:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbULIH5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 02:57:52 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:30695 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261485AbULIH5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 02:57:48 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Thu, 09 Dec 2004 08:57:07 +0100
MIME-Version: 1.0
Subject: Re: [RFC] New timeofday proposal (v.A1)
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Message-ID: <41B81364.5446.EEE6E75@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1102549009.1281.267.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.88.0+V=3.88+U=2.07.079+R=06 December 2004+T=97715@20041209.074751Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Dec 2004 at 15:36, john stultz wrote:

[...]
> Take a look at the adjtimex man page as well as the ntp.c file from the
> timeofday core patch. There are number of different types of adjustments
> that are made, possibly at the same time. Briefly, they are (to my
> understanding - I'm going off my notes from awhile ago): 
> o tick adjustments
> 	how much time should pass in a _user_ tick

tick adjustments are considered obsolete, because if a lcok implementation (or 
hardware) is severly broken, users should reject using that stuff. Meaning: tick 
adjustments are ment to be set once in the life of a computer system. No 
continuous tuning.

> o frequency adjustments
> 	long term adjustment to correct for constant drift), 

Actually, you are compensating for a "tick problem" on a smaller scale (constant 
part), and variations caused by temperature, voltage, and others (variable part).

> o offset adjustments
> 	additional ppm adjustment to correct for current offset from the ntp
> server
> o single shot offset adjustments 
> 	old style adjtime functionality
> 
> Tick, frequency and offset adjustments can be precalculated and summed
> to a single ppm adjustment. This is similar to the style of adjustment
> you propose directly onto the time source frequency values. 
> 
> However, there is also this short term single shot adjustments. These
> adjustments are made by applying the MAX_SINGLESHOT_ADJ (500ppm) scaling
> for an amount of time (offset_len) which would compensate for the
> offset. This style is difficult because we cannot precompute it and
> apply it to an entire tick. Instead it needs to be applied for just a
> specific amount of time which may be only a fraction of a tick. When we

Yes, that's the "precise" variant of implementing it. Poor implementations are 
just accurate to one tick.

> start talking about systems with irregular tick frequency (via
> virtualization, or tickless systems) it becomes even more problematic. 
> 
> If this can be fudged then it becomes less of an issue. Or at worse, we
> have to do two mult/shift operations on two "parts" of the time interval
> using different adjustments.
> 
> Its starting to look doable, but its not necessarily the simplest thing
> (for me at least). I'll put it on my list, but patches would be more
> then welcome. 
> 
> thanks
> -john
> 
> 
> 


