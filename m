Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWBEQcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWBEQcb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 11:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWBEQcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 11:32:31 -0500
Received: from mx1.suse.de ([195.135.220.2]:38374 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751147AbWBEQcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 11:32:31 -0500
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: athlon 64 dual core tsc out of sync
References: <43E40D14.7070606@comcast.net>
From: Andi Kleen <ak@suse.de>
Date: 05 Feb 2006 17:32:16 +0100
In-Reply-To: <43E40D14.7070606@comcast.net>
Message-ID: <p73u0bdlqb3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <safemode@comcast.net> writes:

> why doesn't the startup of the kernel choose
> the pmtimer based on if it detects the system is a dual core proc with
> smp enabled?  

The 64bit kernel does this. I believe John Stultz also implemented
it for 32bit, but it might not have hit mainline yet. 

Sometimes people sabotate it though by not compiling in crucial
parts like ACPI - (no ACPI - no pmtimer)

> And if the pmtimer doesn't fix this sync issue, is
> there a fix out there?   Currently with 2.6.16-rc1-mm5 the
> non-customized boot args to the kernel results in these messages.

pmtimer fixes the issue by not using  the TSC at all. So if you
still have timer troubles when using the pmtimer then it's not the TSC to blame.

> Losing some ticks... checking if CPU frequency changed.
> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging interupts
> rip default_idle+0x2d/0x60

There are unfortunately many different chipset that could cause it.

There was an issue CPU found that could cause this, but it should only happen
on mobile athlon 64.

Sometimes there are timer routing problems on some Nvidia and ATI chipsets.
Assuming you're using 64bit then you can try apicmaintimer or apicpmtimer.
On 32bit you can try pci=noacpi noapic

-Andi

P.S.: I would recommend to approach the issue like visiting a doctor. If you
don't see the full picture don't blame a single piece like the TSC.
