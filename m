Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTF3Xsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 19:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTF3Xsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 19:48:38 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:41412 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263295AbTF3Xsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 19:48:36 -0400
Date: Tue, 1 Jul 2003 01:02:57 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.73 Scheduling while atomic with taskfile IO and high
 memory
In-Reply-To: <Pine.LNX.4.53.0306301702150.2299@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0307010059170.22576@skynet>
References: <Pine.LNX.4.53.0306302052520.22576@skynet>
 <Pine.LNX.4.53.0306301702150.2299@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, Zwane Mwaikambo wrote:

> Could you try selecting your specific IDE chipset (or all), it doesn't
> look like PIO is getting along famously with various other bits. I also
> noticed TCQ, do you have any TCQ capable IDE devices?
>

Tried many things, in no particular order

o PCI chipsets disabled
o Disabled TCQ (device doesn't support it anyway)
o DMA disabled and ide_setup_dma() stub function added so it'll compile
o PCI Generic chipset support enabled
o Intel PIIX chipset support enabled
o All chipset under the sun supported

All come up with the same errors. The following workarounds let it
boot

o Removing inc_preempt_count() and dec_preempt_count() from kmap_atomic()
  and kunmap_atomic()
o Disabling high memory
o Disabling taskfile IO

A quickie patch to sched.c shows that preempt_count() keeps incrementing
for each time the sleeping while atomic message is printed by the
cpu_idle() thread

-- 
Mel Gorman
