Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWF0A5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWF0A5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWF0A5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:57:06 -0400
Received: from mail.gmx.net ([213.165.64.21]:59858 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964811AbWF0A5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:57:04 -0400
X-Authenticated: #5039886
Date: Tue, 27 Jun 2006 02:57:18 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
Message-ID: <20060627005718.GA7127@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200606261856_MC3-1-C384-91D6@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200606261856_MC3-1-C384-91D6@compuserve.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.26 18:54:00 -0400, Chuck Ebbert wrote:
> In-Reply-To: <20060625184244.GA11921@atjola.homenet>
> 
> On Sun, 25 Jun 2006 20:42:44 +0200, Bjorn Steinbrink wrote:
> 
> > Btw, which path do apic irqs go? I stumbled across the nmi stuff, but
> > didn't see anything special for the apic irqs.
> 
> arch/i386/kernel/entry.S has the macro BUILD_INTERRUPT(name, nr).
> 
> The code that uses this macro is in arch/i386/mach-*/entry_arch.h.
> 
> The macro prepends "smp_" to the name passed to the macro and the
> generated asm code calls that function after saving registers, etc.
> 
> arch/i386/kernel/apic.c::apic_intr_init() calls set_intr_gate() to
> point some of the interrupt gates at the correct functions.

Thanks, my view on the code was too cscope-centric and the grep runs
searched for the full function name.
That finally explains why calling update_process_times() in
smp_local_timer_interrupt() makes a difference on UP.

Björn
