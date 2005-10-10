Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVJJSDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVJJSDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVJJSDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:03:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:49835 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751129AbVJJSDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:03:34 -0400
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have
	synced TSCs
From: john stultz <johnstul@us.ibm.com>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, discuss@x86-64.org
In-Reply-To: <20051008101153.GA1541@tentacle.sectorb.msk.ru>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
	 <20051007122624.GA23606@tentacle.sectorb.msk.ru>
	 <200510071431.47245.ak@suse.de>
	 <20051008101153.GA1541@tentacle.sectorb.msk.ru>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 11:03:24 -0700
Message-Id: <1128967404.8195.419.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-08 at 14:11 +0400, Vladimir B. Savkin wrote:
> On Fri, Oct 07, 2005 at 02:31:46PM +0200, Andi Kleen wrote:
> > On Friday 07 October 2005 14:26, Vladimir B. Savkin wrote:
> > > On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
> > > > Andrew,
> > > > 	This patch should resolve the issue seen in bugme bug #5105, where it
> > > > is assumed that dualcore x86_64 systems have synced TSCs. This is not
> > > > the case, and alternate timesources should be used instead.
> > > >
> > > > For more details, see:
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=5105
> > >
> > > I too have a box that shows the symptoms from bugzilla entry above.
> > > The system is Asus A8V Deluxe MB with
> > > "AMD Athlon(tm) 64 X2 Dual Core Processor 3800+".
> > >
> > > The patch below did not fix the problem, while "idle=poll" did.
> > > Hope this helps, dmesg attached.
> > 
> > Are you running the latest BIOS?
> 
> Just upgraded to the lastest BIOS (revision 1014), nothing changed.
> Only with "idle=poll" timers run normally.

>From your dmesg, it appears that there are no other timesources other
then the TSC available on your hardware. So I'm guessing idle=poll is
keeping the CPUs from halting the TSC and keeping them synched. 


I would think that the ACPI PM timer would be supported, but I don't see
anything about it in your dmesg. Could you make sure it is properly
configured in?

thanks
-john


