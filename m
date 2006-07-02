Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWGBNGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWGBNGs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 09:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGBNGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 09:06:48 -0400
Received: from www.osadl.org ([213.239.205.134]:63153 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750753AbWGBNGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 09:06:47 -0400
Subject: Re: [RFC][patch 01/44] Consolidate flags for request_irq
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, benh@kernel.crashing.org,
       davem@davemloft.net
In-Reply-To: <20060701174939.8b10f129.akpm@osdl.org>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
	 <20060701145223.318475000@cruncher.tec.linutronix.de>
	 <20060701174939.8b10f129.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 15:09:07 +0200
Message-Id: <1151845747.25491.879.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 17:49 -0700, Andrew Morton wrote:
> On Sat, 01 Jul 2006 14:54:19 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Move the interrupt related SA_ flags out of linux/signal.h and rename
> > them to IRQF_ . This moves the interrupt related flags out of the signal
> > namespace and allows to remove the architecture dependencies.
> > 
> > SA_INTERRUPT is not needed by userspace and glibc so it can be removed
> > safely. The existing SA_ constants are kept for easy transition and will
> > be removed after a 6 month grace period.
> 
> You seem to have removed SA_PERCPU_IRQ without replacing it.
> 
> drivers/char/mmtimer.c: In function `mmtimer_init':
> drivers/char/mmtimer.c:690: error: `IRQF_PERCPU' undeclared (first use in this function)
> drivers/char/mmtimer.c:690: error: (Each undeclared identifier is reported only once
> drivers/char/mmtimer.c:690: error: for each function it appears in.)

should go after

#define IRQF_TIMER             0x00000200
+defibe IRQF_PERCPU		0x00000400

	tglx



