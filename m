Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVAZAhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVAZAhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVAZAgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:36:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:15325 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262270AbVAZAfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:35:45 -0500
Date: Tue, 25 Jan 2005 16:34:29 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       lkml <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <1106698655.1589.8.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0501251620100.27922@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com> 
 <1106607153.30884.12.camel@cog.beaverton.ibm.com>  <1106620134.15850.3.camel@gaston>
  <1106694561.30884.52.camel@cog.beaverton.ibm.com>  <1106697227.5235.28.camel@gaston>
 <1106698655.1589.8.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, john stultz wrote:

> Agreed. I'll get something like this done for the next release.
>
> > Well, since it only contains the prescale and postscale offsets and the
> > scaling value, it only needs to be updated when they change, so a hook
> > here would be fine.
>
> Great, thats what I was hoping.

I just hope that the implementation of one arch does not become a standard
without sufficient reflection. Could we first get an explanation of
the rationale of the offsets? From my viewpoint of the ia64 implementation
I have some difficulty understanding why such complicated things as
prescale and postscale are necessary in gettimeday and why the simple
formula that we use in gettimeofday is not sufficient?

Frankly, the direction that the design of the new time subsystem is
taking is bothering me. Work on this on our part would just improve the
situation from drastically worse performance to somewhat worse. So far I
have not seen a benefit of moving away from the existing code base. For
the project to make sense it needs at least to be evident that the design
of the solution would lead to better timer performance in the long run.
Conceptually that seems so far not to be possible.

I'd love simplication of the timer subsystem through the use of
nanosecond offsets. However, the POSIX api always has extra fields
for seconds and nanoseconds and converting back and forth between the
internal representation in 64bit nanoseconds and the POSIX structures may
be another performance penalty since it involves divisions and remainder
processing.

What I think is a priority need is some subsystem that manages
time sources effectively (including the ability of the ntp code to
scale the appropriately) and does that in an arch independent
way so that all the code can be consolidated. Extract the best existing
solutions and work from there.
