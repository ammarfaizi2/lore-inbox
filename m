Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVFAXqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVFAXqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFAXo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:44:26 -0400
Received: from fsmlabs.com ([168.103.115.128]:11402 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261453AbVFAXoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:44:01 -0400
Date: Wed, 1 Jun 2005 17:44:07 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
cc: Andrea Arcangeli <andrea@suse.de>, Bill Huey <bhuey@lnxw.com>,
       Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RT patch acceptance
In-Reply-To: <Pine.LNX.4.63.0506011823460.17354@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0506011741410.8323@montezuma.fsmlabs.com>
References: <20050601192224.GV5413@g5.random>
 <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk>
 <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com>
 <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com>
 <20050601210716.GB5413@g5.random> <Pine.LNX.4.63.0506011724310.17354@localhost.localdomain>
 <20050601213921.GF5413@g5.random> <Pine.LNX.4.63.0506011823460.17354@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Nicolas Pitre wrote:

> On Wed, 1 Jun 2005, Andrea Arcangeli wrote:
> 
> > On Wed, Jun 01, 2005 at 05:29:48PM -0400, Nicolas Pitre wrote:
> > > Actualy it's RTAI/rtlinux which is broken wrt the above IRQ disable.
> > > See for yourself when they're used and watch RTAI/rtlinux crash.  
> > 
> > Well it's not so clear so please elaborate since I'm curious. Especially
> > it'd be interesting to know if this is that an arm specific kernel
> > crash, or would it happen on x86 too?
> 
> It would happen on any architecture supporting XIP from flash.
> 
> The XIP code therefore polls the IRQ controller (with IRQs masked out) 
> and whenever an IRQ is pending the flash operation is suspended and IRQs 
> unmasked.  In this case the hard IRQ latency is function of the flash 
> suspend delay which is documented in the datasheet.
> 
> > There sure can be arch dependencies where an hard_local_irq_disable can
> > be necessary in some places, but that's quite a separate topic, and on
> > x86 I don't see why it should crash.
> 
> It would crash if the kernel is XIP.  If not XIP then the 
> local_irq_save() is never encountered in that case.

Hmm that's an interesting case, there are a few others, like MMU,TLB 
update paths and IRQ controller register accesses. But overall these are 
few and easy to identify.

Thanks Nicolas,
	Zwane
