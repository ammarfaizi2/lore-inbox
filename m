Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132804AbQLRAtV>; Sun, 17 Dec 2000 19:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132829AbQLRAtL>; Sun, 17 Dec 2000 19:49:11 -0500
Received: from ftp.webmaster.com ([209.10.218.74]:59123 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S132804AbQLRAs6>; Sun, 17 Dec 2000 19:48:58 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Karel Kulhavy" <clock@atrey.karlin.mff.cuni.cz>,
        <linux-kernel@vger.kernel.org>
Subject: RE: /dev/random: really secure?
Date: Sun, 17 Dec 2000 16:18:31 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKKEFEMIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20001217225057.A8897@atrey.karlin.mff.cuni.cz>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I noticed peculiarities in the behaviour of the delta-delta-3 system for
> entropy estimation in the random.c code./ When I hold right alt
> or control, I
> get about 8 bits of entropy per repeat fro the /dev/random which is
> overestimated. I think the real entropy is 0 bits because it is absolutely
> deterministic when the interrupt comes. Am I right or is there any hidden
> magic source of entropy in this case?

	There are hidden sources of entropy. One is clock skew between the keyboard
processor's clock, the keyboard controller's clock, and the CPU clock
generator's PLL. Another is data motion between the CPU cache and main
memory as various interupt service routines are executed interspersed with
other system activity.

> Right shift, left alt, ctrl and shift make 4 bits per repeat. Is greater
> randomness being expected from the keys that return 8 bits?

	The code does its best to estimate how much actual entropy it is gathering.

> When I have a server where n blobk read, keyboard and mouse events occur
> (everything is cached within huge amount of semiconductor RAM),
> the /dev/random
> depends solely on the network packets. These can be manipulated and their
> leading edge precisely sniffed. I think here exists a severe risk of
> compromise. Am I right?

	Nope. There is no way to sniff their leading edge accurate to a billionth
of a second. If you have a 1Ghz Pentium 3, that's the accuracy you'd need.
And you'd need to know that relative to the CPU clock, which comes from an
uncompensated quartz crystal oscillator fed into a noisy multiplier. Top
that off with variations in the oscillator frequency due to microscopic zone
temperature variations.

	There is no known method to predict these numbers.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
