Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUHVDcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUHVDcf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 23:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUHVDce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 23:32:34 -0400
Received: from ozlabs.org ([203.10.76.45]:55470 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265900AbUHVDcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 23:32:33 -0400
Subject: Re: [PATCH][2.6] Hotplug cpu: Fix APIC queued timer vector race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0408210923570.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408210923570.27390@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1093145533.4888.106.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 Aug 2004 13:32:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 00:10, Zwane Mwaikambo wrote:
> Some timer interrupt vectors were queued on the Local APIC and were being
> serviced when we enabled interrupts again in fixup_irqs(), so we need to
> mask the APIC timer, enable interrupts so that any queued interrupts get
> processed whilst the processor is still on the online map and then clear
> ourselves from the online map. 1ms is a nice safe number even under heavy
> interrupt load with higher priority vectors queued. Andrew this is
> the patch i promised, Rusty, i'm not sure if you find
> __attribute__((weak)) offensive...

It's horrible.  Please move the unsetting of the cpu_online bit into the
arch-specific __cpu_disable() code for each arch, which is consistent
and also simplifies things.

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

