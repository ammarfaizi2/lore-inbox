Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269312AbUIIDhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269312AbUIIDhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 23:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269315AbUIIDhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 23:37:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45186 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269312AbUIIDhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 23:37:17 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>
	 <41381C2D.7080207@mvista.com>
	 <1094239673.14662.510.camel@cog.beaverton.ibm.com>
	 <4138EBE5.2080205@mvista.com>
	 <1094254342.29408.64.camel@cog.beaverton.ibm.com>
	 <41390622.2010602@mvista.com>
	 <1094666844.29408.67.camel@cog.beaverton.ibm.com>
	 <413F9F17.5010904@mvista.com>
	 <1094691118.29408.102.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1094700768.29408.124.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Sep 2004 20:32:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 20:14, Christoph Lameter wrote:
> On Wed, 8 Sep 2004, john stultz wrote:
> 
> > Why must we use jiffies to tell when a timer expires? Honestly I'd like
> > to see xtime and jiffies both disappear, but I'm not very familiar w/
> > the soft-timer code, so forgive me if I'm misunderstanding.
> >
> > So instead of calculating delta_jiffies, just mark the timer to expire
> > at B. Then each interrupt, you use get_fast_timestamp() to decide if now
> > is greater then B. If so, expire it.
> >
> > Then we can look at being able to program timer interrupts to occur as
> > close as possible to the next soft-timer's expiration time.
> 
> Would it not be best to have some means to determine the time in
> nanoseconds since the epoch and then use that for long waits? 

The proposal has get_lowres_timeofday() which does just that, although
for timer stuff, I would guess monotonic_clock() or
get_lowres_timestamp(), which returns the number of (ntp adjusted)
nanoseconds the system has been running, would be better.  


> One can then calculate the wait time in nanoseconds which may then be
> passed to another timer routine which may take the appropriate action
> depending on the time frame involved. I.e. for a few hundred nsecs do busy
> wait. If longer reschedule and if even longer queue the task on some
> event queue that is handled by the timer tick or something else.

I'm not sure about the busy wait bit, but yes, at some point I'd like to
see the timer subsystem use the timeofday subsystem instead of jiffies
for its timekeeping. 

thanks
-john

