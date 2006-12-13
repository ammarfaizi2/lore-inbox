Return-Path: <linux-kernel-owner+w=401wt.eu-S1750769AbWLMUoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWLMUoP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWLMUoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:44:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:40646 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbWLMUoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:44:14 -0500
Date: Wed, 13 Dec 2006 21:40:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HZ free ntp
In-Reply-To: <1166037549.6425.21.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612132125450.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org> 
 <Pine.LNX.4.64.0612060348150.1868@scrub.home>  <20061205203013.7073cb38.akpm@osdl.org>
  <1165393929.24604.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0612061334230.1867@scrub.home>  <20061206131155.GA8558@elte.hu>
  <Pine.LNX.4.64.0612061422190.1867@scrub.home>  <1165956021.20229.10.camel@localhost>
  <Pine.LNX.4.64.0612131338420.1867@scrub.home> <1166037549.6425.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, john stultz wrote:

> > The largest possible interval is freq cycles (or 1 second without
> > adjustments). That is the base interval and without redesigning NTP we
> > can't change that. This base interval can be subdivided into smaller
> > intervals for incremental updates.
> 
> Indeed, larger then 1 second intervals would require the second_overflow
> code to be reworked too.

There isn't much to rework without a complete redesign.

> > You cannot choose arbitrary intervals otherwise you get other problems,
> > e.g. with your patch time_offset handling is broken.
> 
> I'm not seeing this yet. Any more details? 

time_offset is scaled to HZ in do_adjtimex, which needs to be changed as 
well.

> > You don't have to introduce anything new, it's tick_length that changes
> > and HZ that becomes a variable in this function.
> 
> So, forgive me for rehashing this, but it seems we're cross talking
> again. The context here is the dynticks code. Where HZ doesn't change,
> but we get interrupts at much reduced rates.

I know and all you have to change in the ntp and some related code is to 
replace HZ there with a variable, thus make it changable, so you can 
increase the update interval (i.e. it becomes 1s/hz instead of 1s/HZ).

> However, in doing so we have to
> work w/ the ntp.c code which (as Ingo earlier mentioned) has a number of
> HZ based assumptions.

Repeating Ingo's nonsense doesn't make it any more true. :-(

bye, Roman
