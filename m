Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUEYUxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUEYUxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUEYUxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:53:55 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:7075 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265224AbUEYUxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:53:53 -0400
Subject: Re: System clock speed too high - 2.6.3 kernel
From: john stultz <johnstul@us.ibm.com>
To: Joris van Rantwijk <joris@eljakim.nl>
Cc: lkml <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <Pine.LNX.4.58.0405251112040.30050@eljakim.netsystem.nl>
References: <1E4zj-77w-69@gated-at.bofh.it>
	 <Pine.LNX.4.58.0405251112040.30050@eljakim.netsystem.nl>
Content-Type: text/plain
Message-Id: <1085518422.8653.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 25 May 2004 13:53:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-25 at 02:22, Joris van Rantwijk wrote:
> On Fri, 26 Mar 2004, Praedor Atrebates wrote:
> > I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad 1412
> > laptop, celeron 366, 512MB RAM.  I am finding that my system clock is ticking
> > away at a rate of about 3:1 vs reality, ie, I count ~3 seconds on the system
> > clock for every 1 real second.  I am running ntpd but this is unable to keep
> > up with the rate of system clock passage.
> 
> I have the same problem with kernel 2.6.6, only in my case the speed is
> exactly doubled (not 3:1). Saying "clock=tsc" at boot time solves this
> perfectly.
> 
> My mainboard is Asus P5A (4 years old) with ALi M1541 chipset.
> Linux detects a PM-Timer at port 0xec08. I measured the counting rate
> of this port (while safely running with clock=tsc) and it comes out at
> about 7159155 ticks per second. The rate expected by
> arch/i386/kernel/timer/timer_pm.c is 3579545 ticks per second, so this
> explains the double speed very nicely.
> 
> Perhaps this should be documented in the kernel config info.
> If there are many systems with this problem, then calibrating the PM timer
> against the PIT timer at boot time (possibly rejecting invalid rates)
> might be an option.

Check out bugme bug #2375. Some systems have ACPI PM timers that run too
fast. Running w/ "clock=tsc" is the proper workaround, but we need to
blacklist such systems from using it. If you could add dmidecode output
to the bug, I'll add your system to the list. 

http://bugme.osdl.org/show_bug.cgi?id=2375

thanks
-john


