Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVHACIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVHACIC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 22:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVHACIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 22:08:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261964AbVHACH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 22:07:59 -0400
Date: Sun, 31 Jul 2005 19:06:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com, torvalds@osdl.org,
       pavel@ucw.cz, hugh@veritas.com, linux@dominikbrodowski.net,
       daniel.ritz@gmx.ch, len.brown@intel.com
Subject: Re: revert yenta free_irq on suspend
Message-Id: <20050731190645.748f57e9.akpm@osdl.org>
In-Reply-To: <1122861542.2953.8.camel@linux-hp.sh.intel.com>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
	<1122861542.2953.8.camel@linux-hp.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> Hi,
> > In general, I think that calling free_irq is the right behavior.
> > Although irqs changing after suspend is rare, there are also some
> > more serious issues.  This has been discussed in the past, and a
> > summary is as follows:
>
> irqs actually isn't changed after suspend currently, it's a considering
> for future usage like hotplug.
> Calling free_irq actually isn't a complete ACPI issue, but ACPI requires
> it to solve nasty 'sleep in atomic' warning.

Is that the only problem?  If so, then surely we can make free_irq() run
happily with interrupts disabled: unlink the IRQ handler synchronously,
defer the /proc teardown or something like that.

> You will find such break
> with swsusp without ACPI. Could we revert the ACPI change in Linus's
> tree but keep it in -mm tree? So we get a chance to fix drivers.

That depends on the amount of brokenness involved: if it's significant then
I'll get a ton of bug reports concerning something which we already know is
broken and we'll drive away our long-suffering testers.

