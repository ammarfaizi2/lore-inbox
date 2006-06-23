Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932932AbWFWIZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932AbWFWIZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWFWIZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:25:46 -0400
Received: from mail.timesys.com ([65.117.135.102]:61137 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1751119AbWFWIZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:25:45 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic HZ -V4
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Robert Hancock <hancockr@shaw.ca>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
In-Reply-To: <449B60A9.2000809@shaw.ca>
References: <fa.lKfxxA+pCJb5tSZbL1XnnrPzaeQ@ifi.uio.no>
	 <449B60A9.2000809@shaw.ca>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:27:18 +0200
Message-Id: <1151051238.25491.223.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 21:31 -0600, Robert Hancock wrote:
> Thomas Gleixner wrote:
> > An updated patchset is available from:
> > 
> > http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick4.patch
> 
> On my Compaq Presario X1050 laptop running Fedora Core 5 I get:
> 
> Disabling NO_HZ and high resolution timers due to timer broadcasting
> 
> Not sure exactly what this is indicating or what's triggered this, but 
> I'm assuming the patch isn't doing much on this machine?

The system is configured for SMP, but this is an UP machine and the APIC
is disabled in the BIOS. Linux uses then the PIT and an IPI mechanism to
broadcast timer events. We need to do the event reprogramming per CPU,
so we switch off in that situation.

Solution: Either use an UP kernel, or enable Local APIC in the BIOS (is
not possible in most BIOSes), or add "lapic" to the kernel command line.

Also for an UP kernel adding "lapic" to the commandline is good, as the
APIC is faster accessible than the PIT.

	tglx


