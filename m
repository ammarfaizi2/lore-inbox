Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422897AbWBOAaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbWBOAaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbWBOAaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:30:18 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:31362 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1422897AbWBOAaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:30:17 -0500
Date: Wed, 15 Feb 2006 01:30:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
In-Reply-To: <20060214122031.GA30983@elte.hu>
Message-ID: <Pine.LNX.4.61.0602150033150.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
 <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home>
 <20060214074151.GA29426@elte.hu> <Pine.LNX.4.61.0602141113060.30994@scrub.home>
 <20060214122031.GA30983@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Feb 2006, Ingo Molnar wrote:

> CONFIG_TIME_LOW_RES is a temporary way for architectures to signal that 
> they simply return xtime in do_gettimeoffset(). In this corner-case we 
> want to round up by resolution when starting a relative timer, to avoid 
> short timeouts. This will go away with the GTOD framework.

This fixes the worst cases. Even the common case should somehow reflect 
that the relative start time should be rounded up in the same way (even 
if not by that much), e.g. due to rounding the current get_time() (at 
least for the non TIME_INTERPOLATION case) has a 1usec resolution, which 
should be added there. 

bye, Roman
