Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUH3UrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUH3UrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUH3UrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:47:19 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:19598 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261169AbUH3UrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:47:17 -0400
Subject: Re: [RFC][PATCH] fix target_cpus() for summit subarch
From: john stultz <johnstul@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>, James <jamesclv@us.ibm.com>,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1093888987.14662.69.camel@cog.beaverton.ibm.com>
References: <1093652688.14662.16.camel@cog.beaverton.ibm.com>
	 <79750000.1093673866@[10.10.2.4]>
	 <1093888987.14662.69.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1093898800.14662.73.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 30 Aug 2004 13:46:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 11:03, john stultz wrote:
> On Fri, 2004-08-27 at 23:17, Martin J. Bligh wrote:
> > --john stultz <johnstul@us.ibm.com> wrote (on Friday, August 27, 2004 17:24:48 -0700):
> > 
> > > I've been hunting down a bug affecting IBM x440/x445 systems where the
> > > floppy driver would get spurious interrupts and would not initialize
> > > properly. 
> > > 
> > > After digging James Cleverdon pointed out that target_cpus() is routing
> > > the interrupts to the clustered apic broadcast mask. This was causing
> > > multiple interrupts to show up, breaking the floppy init code. 
> > > 
> > > This one-liner fix simply routes interrupts to the first cpu to resolve
> > > this issue.
> > 
> > I'd say that means your hardware is horribly broken ... but I guess this
> > might be a suitable workaround given we're going to reprogram them all
> > later.
> 
> Ok, then my patch probably isn't correct. Let me grab James and we'll
> sit down and work this out later today.

So talking with more with James and Martin, the correct fix looks to be
Bill's suggestion of using Lowest Priority instead of Fixed for the
destination mode. 

James still claims CPU_MASK_ALL (0xff) is wrong for target_cpus(), but
I'll let him make his case for that.

After some testing, I'll resend the corrected patch.

thanks
-john


