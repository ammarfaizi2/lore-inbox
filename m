Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUHVO4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUHVO4K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 10:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUHVO4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 10:56:10 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:39930 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267325AbUHVO4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 10:56:06 -0400
Date: Sun, 22 Aug 2004 11:00:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [PATCH][2.6] Hotplug cpu: Fix APIC queued timer vector race
In-Reply-To: <Pine.LNX.4.58.0408221044180.27390@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0408221100000.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408210923570.27390@montezuma.fsmlabs.com>
 <1093145533.4888.106.camel@bach> <Pine.LNX.4.58.0408221044180.27390@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Zwane Mwaikambo wrote:

> On Sun, 22 Aug 2004, Rusty Russell wrote:
>
> > On Sun, 2004-08-22 at 00:10, Zwane Mwaikambo wrote:
> > > Some timer interrupt vectors were queued on the Local APIC and were being
> > > serviced when we enabled interrupts again in fixup_irqs(), so we need to
> > > mask the APIC timer, enable interrupts so that any queued interrupts get
> > > processed whilst the processor is still on the online map and then clear
> > > ourselves from the online map. 1ms is a nice safe number even under heavy
> > > interrupt load with higher priority vectors queued. Andrew this is
> > > the patch i promised, Rusty, i'm not sure if you find
> > > __attribute__((weak)) offensive...
> >
> > It's horrible.  Please move the unsetting of the cpu_online bit into the
> > arch-specific __cpu_disable() code for each arch, which is consistent
> > and also simplifies things.
>
> Alright this should do it then;

I'll sync against -mm shortly

