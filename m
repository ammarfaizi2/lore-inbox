Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVAZQyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVAZQyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVAZQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:53:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34449 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262425AbVAZQwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:52:06 -0500
Date: Wed, 26 Jan 2005 08:51:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
In-Reply-To: <1106710145.5235.47.camel@gaston>
Message-ID: <Pine.LNX.4.58.0501260846500.1852@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com> 
 <1106607153.30884.12.camel@cog.beaverton.ibm.com>  <1106620134.15850.3.camel@gaston>
  <1106694561.30884.52.camel@cog.beaverton.ibm.com>  <1106697227.5235.28.camel@gaston>
  <1106698655.1589.8.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0501251620100.27922@schroedinger.engr.sgi.com>
 <1106710145.5235.47.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Jan 2005, Benjamin Herrenschmidt wrote:

> On Tue, 2005-01-25 at 16:34 -0800, Christoph Lameter wrote:
>
> > I just hope that the implementation of one arch does not become a standard
> > without sufficient reflection. Could we first get an explanation of
> > the rationale of the offsets? From my viewpoint of the ia64 implementation
> > I have some difficulty understanding why such complicated things as
> > prescale and postscale are necessary in gettimeday and why the simple
> > formula that we use in gettimeofday is not sufficient?
>
> What is complicated here ? The formula, at least as we do on ppc64, is
> simply:
>
>  time = (hw_value - prescale offset) / scale + post scale offset

Yes that is basically what we do on ia64 but we use different
terminology.

time = ns_at_last_tick + (hw_value - last_tick_hw_value) * scale >> shift

> > What I think is a priority need is some subsystem that manages
> > time sources effectively (including the ability of the ntp code to
> > scale the appropriately) and does that in an arch independent
> > way so that all the code can be consolidated. Extract the best existing
> > solutions and work from there.
>
> Which is what John is trying to do, so help instead of criticizing :)

I sure hope that we will be doing that. But so far this has been
a new implementation instead otherwise ntp_scale would not be in the
gettimeofday function.
