Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269187AbUICGt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269187AbUICGt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 02:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUICGt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 02:49:26 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:36543 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269187AbUICGtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 02:49:21 -0400
X-Comment: AT&T Maillennium special handling code - c
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: Albert Cahalan <albert@users.sf.net>
To: george@mvista.com
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       tim@physik3.uni-rostock.de, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <4137CB3E.4060205@mvista.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1094193731.434.7232.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Sep 2004 02:42:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 21:39, George Anzinger wrote:
> john stultz wrote:

> > +
> > +static nsec_t jiffies_cyc2ns(cycle_t cyc, cycle_t* remainder)
> > +{
> > +
> > +	cyc *= NSEC_PER_SEC/HZ;
> 
> Hm... This assumes that 1/HZ is what is needed here.  Today this value is 
> 999898.  Not exactly reachable by NSEC_PER_SEC/HZ.  Or did I miss something, 
> like the relationship of jiffie to 1/HZ and to real time.

HZ not being HZ is the source of many foul problems.

NTP should be able to correct for the error. For systems
not running NTP, provide a fake NTP to make corrections
based on the expected frequency error.

Based on that, skip or double-up on the ticks to make
them be exactly HZ over long periods of time.

> > +int ntp_leapsecond(struct timespec now)
> > +{
> > +	/*
> > +	 * Leap second processing. If in leap-insert state at
> > +	 * the end of the day, the system clock is set back one
> > +	 * second; if in leap-delete state, the system clock is
> > +	 * set ahead one second. The microtime() routine or
> > +	 * external clock driver will insure that reported time
> > +	 * is always monotonic. The ugly divides should be
> > +	 * replaced.

Don't optimize until the patch is in and stable.
The divides can be removed much later. Wait months,
if not forever, before making the code less readable.

The same goes for arch-specific non-syscall hacks.


