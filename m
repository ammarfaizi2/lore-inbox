Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVAYAJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVAYAJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVAYAHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:07:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:56007 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261750AbVAYAE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:04:58 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific timesources (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <Pine.LNX.4.58.0501241525020.17986@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <1106607153.30884.12.camel@cog.beaverton.ibm.com>
	 <1106607215.30884.14.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0501241525020.17986@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 16:04:48 -0800
Message-Id: <1106611488.30884.25.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 15:29 -0800, Christoph Lameter wrote:
> On Mon, 24 Jan 2005, john stultz wrote:
> 
> > +/* helper macro to atomically read both cyclone counter registers */
> > +#define read_cyclone_counter(low,high) \
> > +	do{ \
> > +		high = cyclone_timer[1]; low = cyclone_timer[0]; \
> > +	} while (high != cyclone_timer[1]);
> 
> This is only necessary on 32 bit platforms. On ia64 an atomic read would
> do the job. Maybe that logic needs to go into the custom defined readq for
> 32 bit? Then you could avoid repeating the code for drivers that read 64
> bit clocks on 32bit processors.

Yea, I still need to convert the cyclone timesource to an
TIMESOURCE_MMIO_64. Hopefully I'll get to that in the next release.

thanks again for the review and feedback!
-john


