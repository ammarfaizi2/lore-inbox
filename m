Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVAYATT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVAYATT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVAYAG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:06:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:35731 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261752AbVAYADn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:03:43 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
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
In-Reply-To: <Pine.LNX.4.58.0501241513470.17986@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0501241513470.17986@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 16:03:36 -0800
Message-Id: <1106611416.30884.22.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 15:24 -0800, Christoph Lameter wrote:
> On Mon, 24 Jan 2005, john stultz wrote:
> > +	/* convert to nanoseconds */
> > +	ns_offset = cyc2ns(timesource, delta, NULL);
> > +
> > +	/* apply the NTP scaling */
> > +	ns_offset = ntp_scale(ns_offset);
> 
> The monotonic clock is the time base for the gettime and gettimeofday
> functions. This means ntp_scale() is called every time that the kernel or
> an application access time.
> 
> As pointed out before this will dramatically worsen the performance
> compared to the current code base.
> 
> ntp_scale() also will make it difficult to implement optimized arch
> specific version of function for timer access.
> 
> The fastcalls would have to be disabled on ia64 to make this work. Its
> likely extremely difficult to implement a fastcall if it involves
> ntp_scale().


Yep, performance is a big concern. Re-working ntp_scale() is still on my
TODO list. I just didn't get to it in this release. 

Patches are always welcome.  :)

thanks for the feedback!
-john

