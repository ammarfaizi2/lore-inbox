Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135448AbRDMJGH>; Fri, 13 Apr 2001 05:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135451AbRDMJF6>; Fri, 13 Apr 2001 05:05:58 -0400
Received: from stm.lbl.gov ([131.243.16.51]:58116 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S135450AbRDMJFv>;
	Fri, 13 Apr 2001 05:05:51 -0400
Date: Fri, 13 Apr 2001 02:05:15 -0700
From: David Schleef <ds@schleef.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: george anzinger <george@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
Message-ID: <20010413020514.A17919@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <3AD66B62.23620639@mvista.com> <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Apr 12, 2001 at 09:04:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 09:04:28PM -0700, Andre Hedrick wrote:
> On Thu, 12 Apr 2001, george anzinger wrote:
> 
> > Actually we could do the same thing they did for errno, i.e.
> > 
> > #define jiffies get_jiffies()
> > extern unsigned get_jiffies(void);
> 
> > No, not really.  HZ still defines the units of jiffies and most all the
> > timing is still related to it.  Its just that interrupts are only "set
> > up" when a "real" time event is due.
> 
> Great HZ always defines units of jiffies, but that is worthless if there
> is not a ruleset that tells me a value to divide by to return it to a
> specific quantity of time.

It makes more sense to start migrating drivers to macros such as
msec_to_jiffies(), msec_to_whatever_add_timer_wants(), etc.  (Names
changed to protect the innocent.)  And leave HZ approximately the
way it is, because that's what the code expects.

A good transition is for add_timer() to be defined as

  #define add_timer(a) add_timer_ns(a*1000000000/HZ)

although this causes problems with timers over 4 seconds.  As much
as I like nanoseconds, it's probably overkill here, since one should
be requesting absolute time if it's specified in nanoseconds.




dave...

