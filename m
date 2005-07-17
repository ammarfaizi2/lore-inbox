Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVGQAx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVGQAx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 20:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVGQAx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 20:53:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:24999 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261786AbVGQAxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 20:53:30 -0400
Date: Sat, 16 Jul 2005 17:53:23 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] new human-time soft-timer subsystem
Message-ID: <20050717005323.GC5865@us.ibm.com>
References: <20050714202629.GD28100@us.ibm.com> <Pine.LNX.4.61.0507150014200.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507150014200.3743@scrub.home>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2005 [00:28:44 +0200], Roman Zippel wrote:
> Hi,
> 
> On Thu, 14 Jul 2005, Nishanth Aravamudan wrote:
> 
> > We no longer use jiffies (the variable) as the basis for determining
> > what "time" a timer should expire or when it should be added. Instead,
> > we use a new function, do_monotonic_clock(), which is simply a wrapper
> > for getnstimeofday().
> 
> And suddenly a simple 32bit integer becomes a complex 64bit integer, which 
> requires hardware access to read a timer and additional conversion into ns.
> Why is suddenly everyone so obsessed with molesting something simple and 
> cute as jiffies?

Thanks for the feedback, Roman. I know the 64-bit operations are
critical from a performance perspective and may be excessive from a
pragmatic perspective. Maybe an alternative would be to only provide
*microsecond* resolution in the software, which I currently assume is
storable in an unsigned long (a little over an hour?). We could then
provide a supplemental interface for those sleeps which would exceed
this time, either via looping or a 64-bit parameter for this special
interface.

Would that perhaps be a better alternative from the 64-bit perspective?

We could do this one better, perhaps, by basically doing exactly what
jiffies does now, but storing a time value (in microseconds) instead of
a count of the number of ticks (jiffies' current interpretation). This
would perhaps be a 64-bit op, but that is the case current with
jiffies_64++ (or jiffies_64 += jiffies_increment). I will work on some
patches to do something to this effect and will bring it up during the
time/timer talk (Saturday at 13h30).

Thanks again,
Nish
