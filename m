Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTDTXBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 19:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263739AbTDTXBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 19:01:13 -0400
Received: from [66.212.224.118] ([66.212.224.118]:41990 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S263737AbTDTXBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 19:01:09 -0400
Date: Sun, 20 Apr 2003 19:05:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
In-Reply-To: <b7v8n9$p8o$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.50.0304201858190.17265-100000@montezuma.mastecende.com>
References: <200304201811_MC3-1-3537-1648@compuserve.com>
 <b7v8n9$p8o$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, Linus Torvalds wrote:

> Good call.
> 
> Although I suspect you need about a million interrupt sources to hit
> this, since FIRST_SYSTEM_VECTOR is somethign like 0xef, and thus you can
> hit it only when "offset" has already been incremented seven times
> (which implies that we've walked the whole vector space quite a few
> times by then).
> 
> Did you actually see this on hardware?

Yes, we need to bail out in assign_irq_vector when we wrap around, 
otherwise we cause collisions when programming the IOAPIC. And we also 
need to avoid overruning NR_IRQS structures in setup_IO_APIC_irqs.

	Zwane

