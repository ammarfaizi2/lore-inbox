Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934182AbWKWW0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934182AbWKWW0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 17:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934194AbWKWW0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 17:26:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:7583 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S934182AbWKWW0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 17:26:12 -0500
Date: Thu, 23 Nov 2006 23:26:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 01/19] hrtimers: state tracking
In-Reply-To: <20061109233034.182462000@cruncher.tec.linutronix.de>
Message-ID: <Pine.LNX.4.64.0611210143590.6242@scrub.home>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
 <20061109233034.182462000@cruncher.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Nov 2006, Thomas Gleixner wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Reintroduce ktimers feature "optimized away" by the ktimers review process:
> multiple hrtimer states to enable the running of hrtimers without holding the
> cpu-base-lock.

They were "optimized away" for a reason...

> (The "optimized" rbtree hack carried only 2 states worth of information and we
> need 4 for high resolution timers and dynamic ticks.)

If you need further flags for dynticks, then to do it conditionally, but 
keep this as is (at least for now), keep it small for the simple stuff.
As others have noted your usage is confusing, something like this hard to 
maintain - every time a flag is added/changed, almost every user has to 
checked to insure the state machine stays correct. Keep the basic states 
separate and if it the flag field should be needed for other reason, it 
should be easy enough to convert. This is not needed for an initial merge.
(Same goes for the next patch.)

bye, Roman
