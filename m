Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVCHHYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVCHHYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVCHHYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:24:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:31657 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261852AbVCHHWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:22:02 -0500
Subject: Re: pci_fixup_video() bogosity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <9e473391050307215776f5c06@mail.gmail.com>
References: <1110256709.13607.248.camel@gaston>
	 <9e473391050307215776f5c06@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 18:17:45 +1100
Message-Id: <1110266266.13607.264.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 00:57 -0500, Jon Smirl wrote:
> On Tue, 08 Mar 2005 15:38:29 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > Hi !
> > 
> > While working on writing a VGA access arbiter for kernel & userland,
> > I wondered how to properly get my "initial" state at boot. For that,
> > I looked at how the new PCI ROM stuff does to find out who owns the
> > memory shadow at c0000, and found it quite bogus.
> > 
> > >From what I see, the code is only based on looking at what bridges
> > have VGA forwarding enabled. It doesn't test the actual IO and Memory
> > enable bits of the VGA cards themselves.
> 
> Let's fix it up and make it more robust. I was playing with checking
> IO/mem enable and forgot to finish it.

Ok, have a look at my prototype VGA arbiter. I need something similar to
spot the "default" VGA device at boot, maybe your stuff could be moved
completely to the arbiter ?
> 
> > What if you have 2 cards under the same bridge ?
> 
> I believe the default on x86 is to pick the one in the lowest slot
> number. What happens on PPC?

What I mean is your code won't work afaik, you should check the one
which has MEM/IO enabled. On PPC, I don't know, depends on the firmware,
pretty much all pmac cards come with the legacy decoding disabled anyway
(they are fully posted in "native" mode by the firmware).

Some PPC's have x86 emulators and/or some VGA capabilities, but then, I
expect only one of them to be left enabled by the firmware.
 
Ben.


