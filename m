Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315986AbSEGVwK>; Tue, 7 May 2002 17:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315987AbSEGVwJ>; Tue, 7 May 2002 17:52:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1551 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315986AbSEGVwI>; Tue, 7 May 2002 17:52:08 -0400
Date: Tue, 7 May 2002 14:50:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] PCI reorg changes for 2.5.14
In-Reply-To: <Pine.LNX.4.33.0205071420140.6307-100000@segfault.osdl.org>
Message-ID: <Pine.LNX.4.33.0205071433570.9905-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 May 2002, Patrick Mochel wrote:
> 
> Actually, there was an ordering problem, which was causing an oops on 
> boot. But, that doesn't help with IRQ routing.
> 
> The problem is that ACPI IRQ routing doesn't work at all in 2.5.14 if you 
> have support for APICs enabled in any way. 

Hmm.. That may be true, but at least 2.5.14 gets the interrupt routing 
right.

Which may be because it knows to fall back on the MP table parsing if it 
can't work out the ACPI stuff, and you probably broke that part.

The whole notion of having just _one_ PCI interrupt routing function is 
definitely _broken_. The rule in 2.5.14 is "try ACPI if it's enabled, and 
if that works, we're fine. If it doesn't work, let's try the legacy 
stuff".

In contrast, your PCI irq changes seem to say "if we found ACPI tables, we 
use ACPI routing", which is just stupid.

Please fix it to work at _least_ as well as 2.5.14 does (and yes, my home 
machine works fine with APIC and ACPI enabled on 2.5.14, and since it's a 
dual P4 HT machine it _cannot_ work any other way - and the PCI BK changes 
break it to the point of not booting).

		Linus

