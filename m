Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbULMNBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbULMNBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbULMNBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:01:20 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:11492 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262254AbULMM7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:59:03 -0500
Date: Mon, 13 Dec 2004 13:58:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213125844.GY16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213124313.GB29426@atrey.karlin.mff.cuni.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Dec 13, 2004 at 01:43:13PM +0100, Pavel Machek wrote:
> But that does not matter, right? Yes, one-shot timer will not fire
> exactly at right place, but as long as you are reading TSC and basing
> next shot on current time, error should not accumulate.

As said in the rest of the message, the error (or some other error)
accumulates heavily today in the tick-loss compensation/adjustment
algorithm in arch/i386/kernel/timers/timer_tsc.c, so I'm sceptical about
using one-shots that have the very same problem of the tick-loss
adjustment algorithm. Amittedly the apic is faster to reprogram than the
pit to read the delay_at_last_interrupt, but it still doesn't sound too
sure it will work fine. At least first I'd invest in trying to find if
the tick adjustment is totally malfunctioning because of a tangible real
bug, and not simply because it's unfixable (I tried to find the real bug
so far, so I'm start thinking it's unfixable if really it's recalled so
frequently as while using the broken usb irq like with my adsl modem).

> [..] for their patent abuse against Java.

java isn't open source regardless of patents, use python instead ;).
