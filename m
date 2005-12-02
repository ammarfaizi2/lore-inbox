Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbVLBHKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbVLBHKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 02:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbVLBHKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 02:10:21 -0500
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:45770 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S1750893AbVLBHKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 02:10:21 -0500
Date: Thu, 1 Dec 2005 23:09:31 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Nicholas Miell <nmiell@comcast.net>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051202070931.GA3819@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <20051129221915.GA6953@frankl.hpl.hp.com> <20051129225155.GT19515@wotan.suse.de> <20051130160159.GB8511@frankl.hpl.hp.com> <20051130162314.GP19515@wotan.suse.de> <20051201234150.GE3291@frankl.hpl.hp.com> <20051202000737.GG997@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202000737.GG997@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, Dec 02, 2005 at 01:07:37AM +0100, Andi Kleen wrote:
> On Thu, Dec 01, 2005 at 03:41:50PM -0800, Stephane Eranian wrote:
> > On Wed, Nov 30, 2005 at 05:23:15PM +0100, Andi Kleen wrote:
> > > > to count elapsed cycles while executing a ring 0 and ring 3. The watchdog
> > > > works by polling on the counter and after a certain delta is reached it
> > > > triggers an NMI interrupt which, in turn, causes a kernel crash and the
> > > > (bug) report. Is that the correct behavior?
> > > 
> > > The watchdog is driven by the performance counter (this means
> > > it has varying frequency, but that's not a big issue for the watchdog) 
> > > 
> > > It underflows every second in the fastest case or very slowly
> > > (if the machine is idle). Every time it underflows it checks if 
> > > the per CPU timer has been ticking, and if it hasn't for some time
> > > it triggers an oops.
> > 
> > How is the checking for underflows done? Polling?
> 
> There is a bit in the perfctr MSRs to cause an interrupt if it underflows.
> That is programmed to be an NMI.
> 
But the interrupt is programmed for all counters. So by forcing the PMU
interrupt to use the NMI vector then any perfmon interface would have to use
this interrupt as well. That will break the whole thing because in many
places we rely on PMU interrupt being off.

-- 

-Stephane
