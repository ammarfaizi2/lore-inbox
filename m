Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbULNCrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbULNCrC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 21:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbULNCrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 21:47:01 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:9673 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261383AbULNCqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 21:46:51 -0500
Date: Tue, 14 Dec 2004 03:46:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Pavel Machek <pavel@suse.cz>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041214024625.GU16322@dualathlon.random>
References: <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <1102970039.1281.415.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102970039.1281.415.camel@cog.beaverton.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 12:34:00PM -0800, john stultz wrote:
> source (ie: the TSC or ACPIPM or HPET or whatever). Check out my

How long is the TSC calibration going to last before introducing visible
errors? Is there any error introduced while we transfer the accuracy of
the pit to the acuracy of the TSC during calibration? It would be much
simpler to only use the TSC to provide system time, but I assume we
would be already doing it, if it wasn't for the lost accuracy.

Plus are you already handling cpufreq changed every second by
powersaved? Doesn't that introduce further inaccuracy in the system
time?

As for the lost-tick compensation, it's not working at all, my system
goes as fast in the future as it would go in the past by disabling it.
So the only effect I get by the lost tick compensation is that it's
moving in the future instead of in the past, but the magnitude of the
error is the same and in turn it's not working at all. The real bug is
the USB irq handler that takes 3/4msec to execute and I get a constant
load of those irqs from the adsl modem.
