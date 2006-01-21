Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWAUK14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWAUK14 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWAUK14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:27:56 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51095 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932101AbWAUK1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:27:55 -0500
Date: Sat, 21 Jan 2006 11:28:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] don't let printk unconditionally turn on interrupts
Message-ID: <20060121102808.GB991@elte.hu>
References: <1137811001.6762.179.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137811001.6762.179.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> My first try at booting -rt8 on my machine crashed immediately.  No 
> nmi, no nothing. Just a lockup at the registration of the ACPI_PM 
> timer. This would happen every time, and after struggling for a while, 
> I finally found out why!
> 
> The printk in timeofday_periodic_hook that is called holding the 
> write_lock of system_time_lock (a raw_seq_lock) was causing lots of 
> havoc.  The printk would turn on interrupts, and then I would get a 
> deadlock when the interrupt would do a read on system_time_lock.

argh. This piece of code has caused so many problems already. Some 
people want console drivers to be preemptible, but i guess being able to 
boot trumps things ;)

could you check out the variant in 2.6.15-rt11 - i tweaked it slightly 
over yours, hopefully making the behavior more consistent.

	Ingo
