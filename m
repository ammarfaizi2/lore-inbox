Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWGBAt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWGBAt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWGBAt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:49:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964894AbWGBAt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:49:56 -0400
Date: Sat, 1 Jul 2006 17:49:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, benh@kernel.crashing.org,
       davem@davemloft.net
Subject: Re: [RFC][patch 01/44] Consolidate flags for request_irq
Message-Id: <20060701174939.8b10f129.akpm@osdl.org>
In-Reply-To: <20060701145223.318475000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
	<20060701145223.318475000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 14:54:19 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> Move the interrupt related SA_ flags out of linux/signal.h and rename
> them to IRQF_ . This moves the interrupt related flags out of the signal
> namespace and allows to remove the architecture dependencies.
> 
> SA_INTERRUPT is not needed by userspace and glibc so it can be removed
> safely. The existing SA_ constants are kept for easy transition and will
> be removed after a 6 month grace period.

You seem to have removed SA_PERCPU_IRQ without replacing it.

drivers/char/mmtimer.c: In function `mmtimer_init':
drivers/char/mmtimer.c:690: error: `IRQF_PERCPU' undeclared (first use in this function)
drivers/char/mmtimer.c:690: error: (Each undeclared identifier is reported only once
drivers/char/mmtimer.c:690: error: for each function it appears in.)

