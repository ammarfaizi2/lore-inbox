Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265438AbRGBWJU>; Mon, 2 Jul 2001 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbRGBWJB>; Mon, 2 Jul 2001 18:09:01 -0400
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:26356 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265435AbRGBWIx>; Mon, 2 Jul 2001 18:08:53 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] I/O Access Abstractions
Date: Tue, 3 Jul 2001 00:08:48 +0200
Message-Id: <20010702220848.12689@smtp.wanadoo.fr>
In-Reply-To: <E15HA1D-0006W0-00@the-village.bc.nu>
In-Reply-To: <E15HA1D-0006W0-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Last time I checked, ioremap didn't work for inb() and outb().
>> 
>> It should :)
>
>it doesnt need to.
>
>pci_find_device returns the io address and can return a cookie, ditto 
>isapnp etc

Yes, but doing that require 2 annoying things:

 - Parsing of this cookie on each inx/outx access, which can
take a bit of time (typically looking up the host bridge)

 - On machines with PIO mapped in CPU mem space and several
(or large) IO regions, they must all be mapped all the time,
which is a waste of kernel virtual space.

Why not, at least for 2.5, define a kind of pioremap that
would be the equivalent of ioremap for PIO ?

In fact, I'd rather have all this abstracted in a

ioremap_resource(struct resource *, int flags)
iounmap_resource(struct resource *)

("flags" is just an idea that could be used to pass things
like specific caching attributes, or whatever makes sense to
a given arch).

The distinction between inx/oux & readx/writex would still
make sense at least for x86.

Ben.


