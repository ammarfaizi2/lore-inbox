Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbULPLOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbULPLOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 06:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbULPLOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 06:14:14 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:52409 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262615AbULPLOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 06:14:11 -0500
Date: Thu, 16 Dec 2004 12:13:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Time goes crazy in 2.6.9 after long cli [was Re: USB making time drift]
Message-ID: <20041216111343.GI28286@dualathlon.random>
References: <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <20041214023651.GT16322@dualathlon.random> <20041214095939.GC1063@elf.ucw.cz> <20041214152558.GB16322@dualathlon.random> <20041214220239.GA19221@elf.ucw.cz> <20041216011549.GD6285@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216011549.GD6285@elf.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 02:15:49AM +0100, Pavel Machek wrote:
> Okay, I have good news and bad news. Bad news is that it is broken on
> my machine, too. Good news is that breakage is not at all subtle.

Well, I was pretty sure it was reproducible since the PIT and TSC are
standard hw in all machines, it's just the excessive usb irq latency
that triggers only in a few machines like my firewall (only with
HZ=1000).

My suggestion is that first we fix the accuracy of this, and *then* we
consider switching to a one-short timer.

Fixing this is possible as well by using only the TSC accuracy to
account for system time, and not to use anymore the PIT accuracy as
source of accuracy for system time. But then any error calibration while
we transfer the accuracy of the PIT to the TSC, will propagate in a
cumulative way over time. So it's not clear to me we can do that safely.
The PIT is designed everywhere to be accurate for system time.
