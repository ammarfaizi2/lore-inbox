Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLARqP>; Fri, 1 Dec 2000 12:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLARqG>; Fri, 1 Dec 2000 12:46:06 -0500
Received: from [212.140.94.65] ([212.140.94.65]:27144 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129314AbQLARpt>;
	Fri, 1 Dec 2000 12:45:49 -0500
Date: Fri, 1 Dec 2000 17:16:58 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "T. Camp" <campt@openmars.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
In-Reply-To: <Pine.LNX.4.21.0012010904260.4856-100000@magic.skylab.org>
Message-ID: <Pine.LNX.4.21.0012011709301.1488-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000, T. Camp wrote:
> Hmm didn't know that, from the user-land portable C perspective I'm in the
> habit of zero'ing everything. - thanks.

Yes, sorry, I should have explained a bit more, perhaps. The point is that
when you have an unitialized variable like this:

int x;

the C compiler does not reserve any space for it in the final object file
but rather puts special information in a section called BSS which tells
how much stuff is there, so an appropriate memory image is created for
that section during loading. Subsequently, the kernel initialisation code
(see arch/i386/kernel/head.S, grep for BSS) explicitly initializes the
content of that segment to 0 to comply with various ANSI C standards that
demand this (which presumably demand this for the very reason of making
such optimization possible).

So, not initializing things explicitly saves space in the final disk image
and is a common technique used (by far!) by the majority of Linux kernel
code. In the past, I remember, some arguments against it such as 'having
explicit 0 initialization better documents the code' but, of course, they
are not valid because that is what we have /* */ for -- for documentation.
Comments should not waste space or time.

Anyway, I said too much on such trivial and obvious issue :) -- just
making sure it is clear to you, that is all.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
