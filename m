Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWF3TNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWF3TNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933059AbWF3TNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:13:38 -0400
Received: from mail.timesys.com ([65.117.135.102]:20618 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S932380AbWF3TNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:13:37 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic HZ -V4
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
In-Reply-To: <20060630180720.GA1689@elf.ucw.cz>
References: <1150747581.29299.75.camel@localhost.localdomain>
	 <20060629174838.GA1695@elf.ucw.cz>
	 <1151607796.25491.677.camel@localhost.localdomain>
	 <20060630180720.GA1689@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 21:15:49 +0200
Message-Id: <1151694950.25491.757.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 20:07 +0200, Pavel Machek wrote:
> Hi!
> 
> > > I briefly tested -dyntick5 on my thinkpad, and it seems to work
> > > okay... but timer still seems to tick at 250Hz.
> > 
> > > ...am I doing something wrong?
> > 
> > can you send me the bootlog and your .config file please ?
> 
> ...attached. (I do not have to enable anything in sysfs/commandline to
> enable noidlehz, right?).

Right. 

You trapped into the no apic on SMP trap. I did not come around to fix
that yet. What happens that you don't have lapic on the commandline and
BIOS has lapic disabled. Therefor Linux switches to IPI broadcasting if
the PIT interrupt, which does not work with idle_hz and highres timer as
those are per cpu. I will fix that for SMP kernels which bring up only
one CPU.

You can work around that for now by either using an UP kernel or
enabling local APIC, which is recommended anyway because the APIC timer
is faster to access and has longer max time than PIT.

> On a related note, swapoff -a, echo disk > /sys/power/state is enough
> to kill the machine in timer_resume code with this patch applied.
> 									Pavel

Will look into that. Thanks,

	tglx


