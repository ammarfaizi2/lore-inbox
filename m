Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbULNCII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbULNCII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 21:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULNCII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 21:08:08 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:23777 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261364AbULNCIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 21:08:04 -0500
Date: Tue, 14 Dec 2004 03:04:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041214020425.GS16322@dualathlon.random>
References: <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <1102970039.1281.415.camel@cog.beaverton.ibm.com> <20041213204933.GA4693@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213204933.GA4693@elf.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 09:49:33PM +0100, Pavel Machek wrote:
> Yes, it was supposed to be simple, so that Andrea understands that
> there's nothing inherently broken with single-shot timers.

Single shot timer is unusable for system time accounting, at least as
long as you want to allow nmi. This is a tangible fact, no matter how
simple the example is.

Even the lost tick compensation is not working at all, and it has the
same issues that the one-shot timer has in keeping the system time
accurate.

Pavel, write a program to do iopl(2) cli() wait 3msec; sti() wait 3msec
cli() wait 3msec in a loop. Then watch your system time go in the future
at a rate of a few minutes per hour, then fix it. After you fixed it
we'll get my attention about one-shot timer again ;). I already tried to
fix it and failed so far since I can't see bugs in the current code.
(actually I fixed it by breaking the code, and dropping some ticks
somewhere)
