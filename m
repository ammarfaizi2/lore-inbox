Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbVLBAHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVLBAHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVLBAHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:07:42 -0500
Received: from mx1.suse.de ([195.135.220.2]:46018 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932572AbVLBAHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:07:41 -0500
Date: Fri, 2 Dec 2005 01:07:37 +0100
From: Andi Kleen <ak@suse.de>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Andi Kleen <ak@suse.de>, Nicholas Miell <nmiell@comcast.net>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051202000737.GG997@wotan.suse.de>
References: <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <20051129221915.GA6953@frankl.hpl.hp.com> <20051129225155.GT19515@wotan.suse.de> <20051130160159.GB8511@frankl.hpl.hp.com> <20051130162314.GP19515@wotan.suse.de> <20051201234150.GE3291@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201234150.GE3291@frankl.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 03:41:50PM -0800, Stephane Eranian wrote:
> On Wed, Nov 30, 2005 at 05:23:15PM +0100, Andi Kleen wrote:
> > > to count elapsed cycles while executing a ring 0 and ring 3. The watchdog
> > > works by polling on the counter and after a certain delta is reached it
> > > triggers an NMI interrupt which, in turn, causes a kernel crash and the
> > > (bug) report. Is that the correct behavior?
> > 
> > The watchdog is driven by the performance counter (this means
> > it has varying frequency, but that's not a big issue for the watchdog) 
> > 
> > It underflows every second in the fastest case or very slowly
> > (if the machine is idle). Every time it underflows it checks if 
> > the per CPU timer has been ticking, and if it hasn't for some time
> > it triggers an oops.
> 
> How is the checking for underflows done? Polling?

There is a bit in the perfctr MSRs to cause an interrupt if it underflows.
That is programmed to be an NMI.

-Andi
