Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945901AbWBOJVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945901AbWBOJVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945902AbWBOJVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:21:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53710 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1945901AbWBOJVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:21:54 -0500
Date: Wed, 15 Feb 2006 10:19:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
Message-ID: <20060215091959.GB1376@elte.hu>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home> <20060214074151.GA29426@elte.hu> <Pine.LNX.4.61.0602141113060.30994@scrub.home> <20060214122031.GA30983@elte.hu> <Pine.LNX.4.61.0602150033150.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602150033150.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> On Tue, 14 Feb 2006, Ingo Molnar wrote:
> 
> > CONFIG_TIME_LOW_RES is a temporary way for architectures to signal that 
> > they simply return xtime in do_gettimeoffset(). In this corner-case we 
> > want to round up by resolution when starting a relative timer, to avoid 
> > short timeouts. This will go away with the GTOD framework.
> 
> This fixes the worst cases. Even the common case should somehow 
> reflect that the relative start time should be rounded up in the same 
> way (even if not by that much), e.g. due to rounding the current 
> get_time() (at least for the non TIME_INTERPOLATION case) has a 1usec 
> resolution, which should be added there.

yeah, agreed. That will be accurately fixed via GTOD's per-hwclock 
resolution values. It will have another advantage as well: e.g. the 
whole of m68k wont be penalized via CONFIG_TIME_LOW_RES for having a 
handful of sub-arches (Apollo, Sun3x, Q40) that dont have a higher 
resolution timer - every clock can define its own resolution. You could 
help that effort by porting m68k to use GTOD ;-)

	Ingo
