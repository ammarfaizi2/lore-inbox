Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVDHJSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVDHJSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVDHJSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:18:40 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:42663 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261432AbVDHJSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:18:36 -0400
X-ORBL: [67.117.73.34]
Date: Fri, 8 Apr 2005 02:17:58 -0700
From: Tony Lindgren <tony@atomide.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
Message-ID: <20050408091757.GD4477@atomide.com>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42564584.4080606@tuxrocks.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Sorenson <frank@tuxrocks.com> [050408 01:49]:
> Tony Lindgren wrote:
> | * Tony Lindgren <tony@atomide.com> [050407 23:28]:
> |
> |>I think I have an idea on what's going on; Your system does not wake to
> |>APIC interrupt, and the system timer updates time only on other
> interrupts.
> |>I'm experiencing the same on a loaner ThinkPad T30.
> |>
> |>I'll try to do another patch today. Meanwhile it now should work
> |>without lapic in cmdline.
> |
> |
> | Following is an updated patch. Anybody having trouble, please try
> | disabling CONFIG_DYN_TICK_USE_APIC Kconfig option.
> |
> | I'm hoping this might work on Pavel's machine too?
> |
> | Tony
> 
> This updated patch seems to work just fine on my machine with lapic on
> the cmdline and CONFIG_DYN_TICK_USE_APIC disabled.
> 
> Also, you were correct that removing lapic from the cmdline allowed the
> previous version to run at full speed.

Cool.

> Now, how can I tell if the patch is doing its thing?  What should I be
> seeing? :)

Download pmstats from http://www.muru.com/linux/dyntick/, you may
need to edit it a bit for correct ACPI battery values. But it should
show you HZ during idle and load. I believe idle still does not go
to ACPI C3 with dyn-tick though...

Then you might as well run timetest from same location too to make
sure your clock keeps correct time.

> Functionally, it looks like it's working.  There were a number of
> compiler warnings you might wish to fix before calling it good.  Such as
> "initialization from incompatible pointer type" several times in
> dyn-tick-timer.c and a "too many arguments for format" in
> dyn_tick_late_init.

Yeah, I'll fix those...

Tony
