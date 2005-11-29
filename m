Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVK2WUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVK2WUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 17:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVK2WUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 17:20:32 -0500
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:37512 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S964786AbVK2WUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 17:20:31 -0500
Date: Tue, 29 Nov 2005 14:19:15 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Nicholas Miell <nmiell@comcast.net>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129221915.GA6953@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129215207.GR19515@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Tue, Nov 29, 2005 at 10:52:07PM +0100, Andi Kleen wrote:
> On Tue, Nov 29, 2005 at 01:43:11PM -0800, Nicholas Miell wrote:
> > On Tue, 2005-11-29 at 19:13 +0100, Andi Kleen wrote:
> > > > Where did you see that PMC0 (PERSEL0/PERFCTR0) can only be programmed
> > > > to count cpu cycles (i.e. cpu_clk_unhalted)? As far as I can tell from
> > > > the documentation, the 4 counters are symetrical and can measure
> > > > any event that the processor offers.
> > > 
> > > Linux NMI watchdog does that.
> > > 
> > > All other perfctr users are supposed to keep their fingers away 
> > > from the watchdog (it looks like oprofile doesn't but not for much
> > > longer ...) 
> > 
> > Why? Hardcoding PMC 0 to be a cycle counter seems to be a waste of a
> > perfectly usable performance counter. What if I want to profile four
> > things, none of them requiring a cycle count?
> 

On AMD you only have 4 counters. That's not a lot for some measurements.
The other thing is that PERCTR0 is not like the TSC. It can count cycles
but it does only implement 47bits. At a high clock rate, this can wrap
around fairly rapidly. It all depends on what is the intended usage model.

Suppose you would have a "stable" performance monitoring interface.
One could just use that interface to measure time only when needed.

-- 
-Stephane
