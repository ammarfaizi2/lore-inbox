Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbULOSWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbULOSWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbULOSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:21:13 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:24773 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262436AbULOSUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:20:46 -0500
Date: Wed, 15 Dec 2004 19:20:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: USB making time drift [was Re: dynamic-hz]
Message-ID: <20041215182012.GH16322@dualathlon.random>
References: <20041213002751.GP16322@dualathlon.random> <200412142159.23488.gene.heskett@verizon.net> <20041215091741.GA16322@dualathlon.random> <200412151144.38785.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412151144.38785.gene.heskett@verizon.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 11:44:38AM -0500, Gene Heskett wrote:
> The HZ=1000 is the culprit?

HZ=1000 isn't the culprit. The culprit is the >1msec latency of the usb
irq, but that wouldn't be visible with HZ 100 (for this specific case
HZ=100 would only be a band-aid). 

> Onboard AC-97 audio of course.  Crappy stuff... [..]

I doubt it's the chip, but only the motherboard to blame. My laptop has
the ac97 but no HZ sound out of it.

> translate to 10 millisecond intervals.  If you had a 4 millisecond 
> latency,
> that would be spread over 4 of the 1000 hz interrupts.  That sounds
> rather confusing to the service routine I imagine.

The ones that get confused are the system time and the jiffies, the rest
of the system can deal with long irq delays. The tick adjustment was
exactly implemented so that the jiffies and system time wouldn't get
confused anymore, but it just confuses it the other way around in my
current experience.

> I'll do that just for grins & report back.

Ok.
