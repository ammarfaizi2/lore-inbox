Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131763AbQKUX4S>; Tue, 21 Nov 2000 18:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbQKUX4M>; Tue, 21 Nov 2000 18:56:12 -0500
Received: from 213-120-136-183.btconnect.com ([213.120.136.183]:52484 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131763AbQKUX4D>;
	Tue, 21 Nov 2000 18:56:03 -0500
Date: Tue, 21 Nov 2000 23:26:23 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
In-Reply-To: <20001122001813.A1356@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0011212323450.950-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, J . A . Magallon wrote:

> 
> On Wed, 22 Nov 2000 00:04:53 Tigran Aivazian wrote:
> > On Tue, 21 Nov 2000, J . A . Magallon wrote:
> > 
> > Quite the contrary. The patch seems correct and useful to me. What do you
> > think is wrong with it? (Linus accepted megabytes worth of the above in
> > the past...)
> > 
> 
> Sorry, i should look at the rest of the code. Seeing only that, is seems like
> that variables have to hold an initial value of zero, and the patch relies
> on the ANSI behaviour of the compiler that auto-initializes them to 0.
> I have seen many compilers break ANSI rules in optimized mode. Typical
> runs-fine-in-debug-mode-but-breaks-on-production-release.
> One other point for info would be gcc specs.

In the case of kernel, we have to do many things manually, can't rely on
some compiler (sometimes :). So, the code I pointed you at
arch/i386/kernel/head.S (look for "Clear BSS") is in fact what clears the
BSS; without it you will end up with uninitialized garbage in what you
think "ANSI C compiler arranged" for you.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
