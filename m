Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315978AbSEGVd0>; Tue, 7 May 2002 17:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315979AbSEGVdZ>; Tue, 7 May 2002 17:33:25 -0400
Received: from air-2.osdl.org ([65.201.151.6]:10899 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S315978AbSEGVdY>;
	Tue, 7 May 2002 17:33:24 -0400
Date: Tue, 7 May 2002 14:29:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] PCI reorg changes for 2.5.14
In-Reply-To: <20020507202317.GA2180@kroah.com>
Message-ID: <Pine.LNX.4.33.0205071420140.6307-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 May 2002, Greg KH wrote:

> > Greg, Pat - this changeset seems to completely break ACPI interrupt
> > routing.
> > 
> > I suspect it's an ordering issue, with the new "pci_lookup_irq" getting
> > assigned the wrong value (or the ACPI irq init not being done or
> > whatever).
> > 
> > Please give this a good look.
> 
> Pat found the problem, it was due to the startup ordering issue (he
> could give a better explanation than I could), and the update is checked
> in.

Actually, there was an ordering problem, which was causing an oops on 
boot. But, that doesn't help with IRQ routing.

The problem is that ACPI IRQ routing doesn't work at all in 2.5.14 if you 
have support for APICs enabled in any way. 

I've tried .14-virgin, .14-dj1 and .14-pci, each with and without ACPI 
enabled, and with and without APIC support enabled on UP, and with and 
without SMP enabled. The results are consistent:

	acpi	apic	irq?
	--------------------
	 yes	 yes	  no
	 yes	  no	 yes
	  no	 yes	 yes

The ACPI people are working on this problem. Their latest patch 
(20020503) plus Dominik Brodowski's latest patch applied to .14-virgin 
allow me to get IRQs assigned. However, the relevant ACPI changes are are 
wrapped up in many other changes to the subsystem...

	-pat

