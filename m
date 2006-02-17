Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWBQMoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWBQMoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 07:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWBQMoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 07:44:11 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:52636 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932248AbWBQMoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 07:44:10 -0500
Date: Fri, 17 Feb 2006 13:43:44 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Paul Mackerras <paulus@samba.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Provide an interface for getting the current tick
 length
In-Reply-To: <1140135082.7028.45.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0602171311430.30994@scrub.home>
References: <17397.2831.48980.367714@cargo.ozlabs.ibm.com>
 <1140135082.7028.45.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Feb 2006, john stultz wrote:

> > +u64 current_tick_length(void)
> > +{
> > +	long delta_nsec;
> > +
> > +	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
> > +	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
> > +}
> 
> You've got time_adj here, but you're not using what's been accumulated
> in time_phase, is that really ok?
> 
> 
> Other then that it looks ok to me. I know Roman is working on related
> code, so I CC'ed him on this.

I was only thinking about the possibility of increasing the precision 
already, but that can still be done later.
Otherwise this function will only become simpler, so there's no real 
problem. Actually it should even make NTP4 conversion easier, if ppc uses 
this value instead of duplicating the calculation.

bye, Roman
