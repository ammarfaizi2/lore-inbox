Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVLPRd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVLPRd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVLPRd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:33:56 -0500
Received: from fmr21.intel.com ([143.183.121.13]:29133 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751310AbVLPRdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:33:55 -0500
Date: Fri, 16 Dec 2005 09:33:42 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Robin Holt <holt@sgi.com>
Cc: hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Keith Owens <kaos@sgi.com>, Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] ia64: disable preemption in udelay()
Message-ID: <20051216173342.GA12205@agluck-lia64.sc.intel.com>
References: <20051216024252.27639.63120.sendpatchset@tomahawk.engr.sgi.com> <20051216122854.GA10375@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216122854.GA10375@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 06:28:54AM -0600, Robin Holt wrote:
> > +#define SMALLUSECS 100
> 
> John, I did not see your posts until this had already made it out.
> I would think that the folks running realtime applications would expect
> udelay to hold off for even shorter periods of time.  I would expect
> something along the line of 20 or 25 uSec.

A good question ... I'm going to put John's change in as-is for now so
that 2.6.15 can benefit from the reduced code size of the out-of-line
and avoid the ugly bug when preemption is enabled on a drifty system.

We can make fine tune changes to the udelay() implementation after we
get some data on what is needed.

> How much drift would you expect from this?  I have not tried this, but
> what about something more along the lines of:
> 
> #define MAX_USECS_WHILE_NOT_PREMPTIBLE	20

As we reduce the non-preemtible window drift in my version of udelay()
would get worse ... but I haven't done any measurements on how much worse.

> 		timeout += next * local_cpu_data->cyc_per_usec;
> 		while (ia64_get_itc() < timeout)
> 			cpu_relax();

Bad news if your ar.itc wraps around (less than four centuries of uptime
at 1.6GHz :-)

-Tony
