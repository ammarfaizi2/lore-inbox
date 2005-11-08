Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVKHJaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVKHJaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 04:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKHJaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 04:30:24 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:60823
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965114AbVKHJaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 04:30:22 -0500
Subject: Re: CLOCK_REALTIME_RES and nanosecond resolution
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1131418511.4652.88.camel@gaston>
References: <1131418511.4652.88.camel@gaston>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 08 Nov 2005 10:34:18 +0100
Message-Id: <1131442459.18108.75.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 13:55 +1100, Benjamin Herrenschmidt wrote:
> Hi !
> 
> I noticed that we set
> 
> #define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */
> 
> Unconditionally in kernel/posix-timer.c
> 
> Doesn't that mean that we'll advertise to userland (via clock_getres) a
> resolution that is basically HZ ? We do get at lenght to get more
> precise (up to ns) resolution in practice on many architectures but we
> don't expose that to userland at all. Is this normal ?

This is the resolution which you can expect for timers (nanosleep and
interval timers) as the timers depend on the jiffy tick.

The resolution of the readout functions is not affected by this.

http://www.tglx.de/ktimers.html#writeup

should give you more information about that.

	tglx


