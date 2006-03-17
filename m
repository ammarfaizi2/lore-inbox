Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWCQWIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWCQWIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWCQWIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:08:07 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:54468 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750996AbWCQWIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:08:05 -0500
Date: Fri, 17 Mar 2006 23:07:50 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 5/8] hrtimer remove state field
In-Reply-To: <1142499713.29968.11.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603172242370.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain> 
 <20060312080332.274315000@localhost.localdomain>  <Pine.LNX.4.64.0603121302590.16802@scrub.home>
  <1142169010.19916.397.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0603121422180.16802@scrub.home>  <1142170505.19916.402.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121444530.16802@scrub.home>  <1142172917.19916.421.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121523320.16802@scrub.home>  <1142175286.19916.459.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121608440.17704@scrub.home>  <1142178108.19916.475.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121650230.16802@scrub.home>  <1142180796.19916.497.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603152055380.16802@scrub.home> <1142499713.29968.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Mar 2006, Thomas Gleixner wrote:

> > For example no current user restarts an active timer, which could be used
> > to simplify the locking.
> 
> How does this simplify the locking ? It just removes the
> hrtimer_cancel() call in hrtimer_start() and makes the
> switch_hrtimer_base() code a bit simpler.
> 
> The general locking rules would be still the same and I dont see
> increased flexibility at all.

Current users already do the serialize the calls into hrtimer themselves 
(stopping and restarting), which can make the locking even simpler.

> > If we tightened a bit what a user is allowed to 
> > do, we could gain flexibility on the other side, e.g. allow drivers to 
> > create timer sources or how to integrate cpu timer.
> 
> -ENOPARSE. Can you please explain what "allow drivers to create timer
> sources" means and why the above locking is in the way ?

For example dynamically attaching a timer_base to a clock source (e.g. to 
create a monotonic timer independent of NTP adjustments). Right now as 
soon as any timer_base is active it cannot be deconfigured again due to 
pointers to it from timers, so this would require different locking.

bye, Roman
