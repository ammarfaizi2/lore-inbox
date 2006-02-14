Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWBNKST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWBNKST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030549AbWBNKSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:18:18 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:44266 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030540AbWBNKSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:18:15 -0500
Date: Tue, 14 Feb 2006 11:18:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
In-Reply-To: <20060214074151.GA29426@elte.hu>
Message-ID: <Pine.LNX.4.61.0602141113060.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
 <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home>
 <20060214074151.GA29426@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Feb 2006, Ingo Molnar wrote:

> > Let's assume a get_time() which simply returns xtime and so has a 
> > resolution of around TICK_NSEC. This means the real time when one 
> > calls get_time() is somewhere between xtime and xtime+TICK_NSEC.  
> > Assuming the real time is xtime+TICK_NSEC-1, get_time() will return 
> > xtime and a relative timer with TICK_NSEC-1 will expire immediately.
> 
> i agree that on systems where get_time() has a TICK_NSEC resolution, 
> such short timeouts are bad.
> 
> i dont agree with the fix though: it penalizes platforms where 
> ->get_time() resolution is sane.

How do you want to tell one from the other?
Can we agree, that this is the behaviour 2.6 currently already has anyway?
I fully agree, that this patch is not the best solution, but is it really 
such a problem that we can't postpone the behaviour change for a short 
while until we can fix it properly (i.e. via a proper clock framework)? 

bye, Roman
