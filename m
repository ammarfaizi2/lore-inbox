Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUI3OYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUI3OYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269294AbUI3OYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:24:46 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:47121 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S269291AbUI3OYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:24:30 -0400
Date: Thu, 30 Sep 2004 15:24:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       Allen Martin <AMartin@nvidia.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       white phoenix <white.phoenix@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nforce2 bugs?
In-Reply-To: <415BD123.8020608@gmx.de>
Message-ID: <Pine.LNX.4.58L.0409301511450.25286@blysk.ds.pg.gda.pl>
References: <e2ae0e3b04092915427fcff604@mail.gmail.com>
 <1096496263.16768.12.camel@localhost.localdomain> <415BD123.8020608@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2004, Prakash K. Cheemplavam wrote:

> The only problem is the apic timer thing. It just gets activated if the
> correct BIOS Version is found (see the dmi scan thingie). So I just pass
> acpi_skip_timer_override to the kernel to be sure.

 There appears to be another timer problem, too -- at least for some
boards the system timer (the 8254 PIT) has a noisy output.  When routed to
an I/O APIC input it makes the system time go fast enough the NTP daemon
isn't able to compensate (it's a few minutes per day fast).  The problem
goes away when routing it to the 8259A PIC, presumably because the 8259A
inputs are not "sticky" in the edge-triggered mode -- at the worst you
only get spurious interrupts reported in /proc/interrupts in the "ERR"
counter.

 An nVidia feedback would be appreciated.  Allen?

  Maciej
