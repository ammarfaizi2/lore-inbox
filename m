Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311229AbSCLPLq>; Tue, 12 Mar 2002 10:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311230AbSCLPLg>; Tue, 12 Mar 2002 10:11:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25916 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311229AbSCLPL0>; Tue, 12 Mar 2002 10:11:26 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        "S. Chandra Sekharan" <sekharan@us.ibm.com>
Subject: Re: [PATCH] Support for assymmetric SMP
In-Reply-To: <20020311043421.D2346@nbkurt.etpnet.phys.tue.nl>
	<20020311052954.R8949@dualathlon.random>
	<20020311122549.I2346@nbkurt.etpnet.phys.tue.nl>
	<20020311132053.G10413@dualathlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Mar 2002 08:05:51 -0700
In-Reply-To: <20020311132053.G10413@dualathlon.random>
Message-ID: <m13cz5zv00.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Mon, Mar 11, 2002 at 12:25:49PM +0100, Kurt Garloff wrote:
> > Hi Andrea,
> > 
> > On Mon, Mar 11, 2002 at 05:29:54AM +0100, Andrea Arcangeli wrote:
> > > the only problem is if you happen to get the timer irq always in the
> > > same cpu for a few seconds, then the last_tsc_low will wrap around and
> > > gettimeofday will be wrong. And even if you snapshot the full 64bit of the
> > > tsc you'll run into some trouble if the timer irq will be delivered only
> > > to the same cpu for a long time (for example if you use irq bindings).
> > > you'd lose precision and you'll run into the measuration errors of
> > > fast_gettimeoffset_quotient. The right support for asynchronous TSC
> > > handling is a bit more complicated unfortunately.
> > 
> > If your APIC works, your CPUs should get the timer IRQs in alternating order.
> 
> Maybe I remeber wrong, but AFIK the io-apic isn't required to scale the
> irq load in alternating order, it is perfectly allowed to deliver the
> irq always to the same cpu for several seconds. I know the probability
> for that to happen is low but it can happen.

Actually I know of at least one dual P4 Xeon board where I haven't seen anything
except IPI go to the second cpu.

Eric
