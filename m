Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbTCSXKQ>; Wed, 19 Mar 2003 18:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263054AbTCSXKP>; Wed, 19 Mar 2003 18:10:15 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:27269
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261276AbTCSXKO>; Wed, 19 Mar 2003 18:10:14 -0500
Date: Wed, 19 Mar 2003 18:17:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH][2.5] Fail setup_irq for unconfigured IRQs
In-Reply-To: <Pine.LNX.4.50.0303182259280.25200-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303191810571.5809-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303182259280.25200-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Zwane Mwaikambo wrote:

> This patch makes us bail out in case we may have an interrupt which 
> couldn't be associated with an interrupt controller. Without this we allow 
> unconfigured interrupts to be assigned and then later on we get 
> "unexpected IRQ trap at vector xx" during the ack phase.
> 
> scenario:
> This can occur if we fail irq setup during setup_IO_APIC_irqs for some 
> reason or other and then miss getting assigned a vector. Later on we then 
> get assigned no_irq_type as our handler.

Here is a sample /proc/interrupts from an affected system...

 41:       1313        796       1298       1380          IO-APIC-level  qlogicisp
 89:          0          0          0          0          none  qlogicisp

Please apply,
	Zwane

