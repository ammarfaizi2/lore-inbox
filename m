Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUKTBWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUKTBWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbUKTBV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:21:58 -0500
Received: from bgm-24-95-139-53.stny.rr.com ([24.95.139.53]:60392 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263032AbUKTBRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:17:51 -0500
Subject: Re: smp_apic_timer_interrupt entry point
From: Steven Rostedt <rostedt@goodmis.org>
To: Darren Hart <darren@dvhart.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1100911984.22670.4.camel@localhost.localdomain>
References: <1100911984.22670.4.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Fri, 19 Nov 2004 20:17:45 -0500
Message-Id: <1100913465.4051.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 16:53 -0800, Darren Hart wrote:
> I am trying to hunt down the entry point to smp_apic_timer_interrupt()
> for i386.  grep found:
> 
> arch/x86_64/kernel/entry.S:     apicinterrupt LOCAL_TIMER_VECTOR,smp_apic_timer_interrupt
> 
> but nothing for i386.  I noticed that entry.o on i386 does contain the
> string "smp_apic_timer_interrupt", is there some kind of linker magic
> going on?

Not linker magic, but macro magic.  Look again at entry.S at
BUILD_INTERRUPT.  It adds the smp_ onto apic_timer_interrupt.
Then look where apic_timer_interrupt is used.

-- 
Steven Rostedt
Senior Engineer
Kihon Technologies
