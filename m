Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVBCUJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVBCUJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVBCUFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:05:19 -0500
Received: from fmr24.intel.com ([143.183.121.16]:13451 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S263764AbVBCUCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:02:40 -0500
Date: Thu, 3 Feb 2005 12:02:34 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: john stultz <johnstul@us.ibm.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       keith maanthey <kmannth@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, andrew@walrond.org
Subject: Re: i386 HPET code
Message-ID: <20050203120233.A23267@unix-os.sc.intel.com>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com> <1107459056.2040.243.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1107459056.2040.243.camel@cog.beaverton.ibm.com>; from johnstul@us.ibm.com on Thu, Feb 03, 2005 at 11:30:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 11:30:56AM -0800, john stultz wrote:
> On Thu, 2005-02-03 at 06:28 -0800, Pallipadi, Venkatesh wrote:
> > Can you check whether only the following change makes the problem go
> > away. If yes, then it looks like a hardware issue.
> > 
> > >	hpet_writel(hpet_tick, HPET_T0_CMP);
> > >+	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
> > >
> 
> Yep. Adding only the second write seems to make the box boot.
> 
> Since this isn't just affecting our hardware (see Andrew Walrond's
> comment in the thread), would doing two writes like x86-64 does be
> acceptable? 
> 

Yes. As this is just the initialization code, I think adding second write 
is OK. But, I am not sure why two writes are required and will the two write
be sufficient for all systems. I don't seem to remember anything about this
in HPET specs. I will double check it. 

Basically I am thinking of something like this will be a good generic solution
in place of simple two writes.

for (i = 0 ; i <some number for max retries>; i++) {
	hpet_writel(hpet_tick, HPET_T0_CMP);
	if (hpet_tick == hpet_readl(hpet_tick, HPET_T0_CMP))
		break;
}

I think we can wait for result from Andrew's system and chose either one
of the above approaches.

Thanks,
Venki

