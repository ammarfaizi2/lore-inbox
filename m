Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269356AbUI3Q77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269356AbUI3Q77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUI3Q77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:59:59 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:27405 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S269356AbUI3Q75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:59:57 -0400
Date: Thu, 30 Sep 2004 17:59:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andy Currid <ACurrid@nvidia.com>, Ross Dickson <ross@datscreative.com.au>
Cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       Allen Martin <AMartin@nvidia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       white phoenix <white.phoenix@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: nforce2 bugs?
In-Reply-To: <8E5ACAE05E6B9E44A2903C693A5D4E8A01C45A1C@hqemmail02.nvidia.com>
Message-ID: <Pine.LNX.4.58L.0409301705180.25286@blysk.ds.pg.gda.pl>
References: <8E5ACAE05E6B9E44A2903C693A5D4E8A01C45A1C@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2004, Andy Currid wrote:

> I'm taking a look at the patches discussed in other recent emails on the
> list, but I'm curious about the timer issue that Maciej notes here. In
> systems running in IOAPIC mode where this problem has been observed, is
> ACPI enabled?

 One I can test a bit has indeed ACPI enabled.

> I strongly suspect that it is. Some BIOSes on nForce systems contain an
> incorrect INT override for the timer interrupt in their ACPI tables,
> indicating that in IOAPIC mode the timer interrupts on IRQ2 rather than
> IRQ0. The kernel honors the override, then notices the timer interrupt
> isn't working and subsequently rescues the situation by configuring the
> timer in ExtInt mode. That recovers the timer interrupt but I suspect
> that configuration may be responsible for the "noisy" behavior (it's a
> faulty configuration).

 The firmware (BIOS) reports I/O APIC interrupts correctly on this box --
there's no override for IRQ0.  Timer interrupts work correctly in the
ExtInt mode.  They only fail in the I/O APIC mode.

 Older reports from the list show exactly the same problem, e.g.  
"http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.1/0739.html", which is
probably one of the earliest references to the clock skew problem with I/O
APIC routing.  As I believe both the 8254 and 8259A and the I/O APIC are
internal to the chipset, I doubt that can be a problem specific to board
design; it may be a firmware fault, though, such as an initialization bug.  
As Ross used to maintain temporary workarounds for nforce2 problems, he
may be able to comment on what reports he received.  Ross?

  Maciej
