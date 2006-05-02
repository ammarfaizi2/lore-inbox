Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWEBTIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWEBTIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWEBTIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:08:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12817 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750721AbWEBTIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:08:20 -0400
Date: Tue, 2 May 2006 20:08:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
Message-ID: <20060502190814.GC4223@flint.arm.linux.org.uk>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk> <200605021901.13882.ak@suse.de> <Pine.LNX.4.64.0605021316380.28543@localhost.localdomain> <20060502185555.GB4223@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605021503230.28543@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605021503230.28543@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 03:05:22PM -0400, Nicolas Pitre wrote:
> On Tue, 2 May 2006, Russell King wrote:
> > On Tue, May 02, 2006 at 01:18:25PM -0400, Nicolas Pitre wrote:
> > > On Tue, 2 May 2006, Andi Kleen wrote:
> > > 
> > > > On Tuesday 02 May 2006 18:50, Russell King wrote:
> > > > 
> > > > > You're right assuming you have a 64-bit TSC, but ARM has at best a
> > > > > 32-bit cycle counter which rolls over about every 179 seconds - with
> > > > > gives a range of values from sched_clock from 0 to 178956970625 or
> > > > > 0x29AAAAAA81.
> > > > > 
> > > > > That's rather more of a problem than having it happen every 208 days.
> > > > 
> > > > Ok but you know it's always 32bit right? You can fix it up then
> > > > with your proposal of a sched_diff()
> > > > 
> > > > The problem would be fixing it up with a unknown number of bits.
> > > 
> > > Just shift it left so you know you always have the most significant bits 
> > > valid.  The sched_diff() would take care of scaling it back to nanosecs.
> > 
> > sched_clock is currently defined to return nanoseconds so this isn't
> > a possibility.
> 
> If we're discussing the addition of a sched_clock_diff(), why whouldn't 
> shed_clock() return anything it wants in that context?  It could be 
> redefined to have a return value meaningful only to shed_clock_diff()?

If we're talking about doing that, we need to replace sched_clock()
to ensure that we all users are aware that it has changed.

I did think about that for my original fix proposal, but stepped back
because that's a bigger change - and is something for post-2.6.17.
The smallest fix (suitable for -rc kernels) is as I detailed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
