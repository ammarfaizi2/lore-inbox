Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136746AbREAWrS>; Tue, 1 May 2001 18:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136744AbREAWrI>; Tue, 1 May 2001 18:47:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:1032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136749AbREAWqz>; Tue, 1 May 2001 18:46:55 -0400
Date: Tue, 1 May 2001 15:46:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
In-Reply-To: <20010501223154.G3541@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.31.0105011542410.2667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 May 2001, Russell King wrote:
>
> In which case, can we change the following in IO-mapping.txt please?

Oh, sorry. I misread your question. The _return_ value is a cookie.

The first argument should basically be the start of a "struct pci_dev"
resource entry, but obviously architecture-specific code can (and does)
know what the thing means. And the ISA space (ie 0xA0000-0x100000) has
been considered an acceptable special case.

So the only usage that is "portable" is to do something like

	cookie = ioremap(pdev->resource[0].start, pdev->resource[0].len);

and I guess we should actually create some helper functions for that too.

You can use ioremap in other ways, but there's nothing to say that they
will work reliably across multiple PCI buses etc.

		Linus

