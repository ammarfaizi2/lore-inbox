Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUHGX5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUHGX5I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUHGX5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:57:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:16837 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264795AbUHGXzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:55:04 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200408071514.49498.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200407310723.12137.david-b@pacbell.net>
	 <20040806200442.GC30518@elf.ucw.cz>
	 <200408071514.49498.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091922821.14105.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 08 Aug 2004 09:53:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 08:14, David Brownell wrote:
> On Friday 06 August 2004 13:04, Pavel Machek wrote:
> 
> > > These look to me like "wrong device-level suspend state" cases.
> > 
> > Actually, suspend-to-disk has to suspend all devices *twices*. Once it
> > wants them in "D0 but DMA/interrupts stopped", and once in "D3cold but
> > I do not really care power is going to be cut anyway". I do not think
> > this can be expressed with PCI states.
> 
> How are those different from "PCI_D1" then later "PCI_D3hot"?

D1 is a real HW state, we don't really need to enter it at all. On some
chip, suspending to D1 require some mess that we don't need here. We
just need to block the driver.

> I'd understood that loss of VAUX was always possible, so robust
> drivers always had to handle resume  from PCI_D3cold.

When they can ....

Ben.


