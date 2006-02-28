Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWB1Jva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWB1Jva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 04:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWB1Jva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 04:51:30 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:53160 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP
	id S1751013AbWB1Jv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 04:51:29 -0500
X-ORBL: [67.117.73.34]
Date: Tue, 28 Feb 2006 01:51:00 -0800
From: Tony Lindgren <tony@atomide.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, johnstul@us.ibm.com,
       rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: + fix-next_timer_interrupt-for-hrtimer.patch added to -mm tree
Message-ID: <20060228095100.GA31105@atomide.com>
References: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net> <1140884243.5237.104.camel@localhost.localdomain> <20060225185731.GA4294@atomide.com> <20060228032900.GE4486@atomide.com> <1141117500.5237.112.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141117500.5237.112.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [060228 01:03]:
> On Mon, 2006-02-27 at 19:29 -0800, Tony Lindgren wrote:
> > I've changed ARM xtime_lock to read lock, but now there's a slight
> > chance that an interrupt adds a timer after next_timer_interrupt() is
> > called and before timer is reprogrammed. I believe s390 also has this
> > problem.
> 
> This needs a more generalized solution later, but I picked up your ARM
> change and simplified the hrtimer related bits.

Cool, after a quick test seems to work OK here. Any ideas how to fix the
locking problem above?

Maybe one option would be to just reprogram the hardware timer when a
new hrtimer is added. That would then allow subjiffie timers too.

Regards,

Tony
