Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVBYHaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVBYHaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 02:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVBYHaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 02:30:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:33424 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262639AbVBYHaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 02:30:02 -0500
Subject: Re: 2.6.11-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050225070813.GA13735@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston>
	 <20050225070813.GA13735@suse.de>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 18:29:11 +1100
Message-Id: <1109316551.14993.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 08:08 +0100, Olaf Hering wrote:
>  On Fri, Feb 25, Benjamin Herrenschmidt wrote:
> 
> > On Thu, 2005-02-24 at 15:50 +0100, Olaf Hering wrote:
> > >  On Wed, Feb 23, Linus Torvalds wrote:
> > > 
> > > > This time it's really supposed to be a quickie, so people who can, please 
> > > > check it out, and we'll make the real 2.6.11 asap.
> > > 
> > > radeonfb oopses on intel.
> > > Havent checked yet when it started with it.
> > > 
> > > ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
> > > eth0: VIA Rhine II at 0x1c400, 00:11:5b:83:1e:76, IRQ 11.
> > > eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
> > > usb 5-1: new low speed USB device using uhci_hcd and address 2
> > > ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> > > radeonfb: Found Intel x86 BIOS ROM Image
> > > radeonfb: Retreived PLL infos from BIOS
> > > radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=133.00 Mhz, System=133.00 MHz
> > > radeonfb: PLL min 12000 max 35000
> > > NET: Registered protocol family 23
> > > radeonfb: Monitor 1 type DFP found
> > > radeonfb: EDID probed
> > > radeonfb: Monitor 2 type no found
> > > radeonfb: Assuming panel size 8x1
> > 
> > Hrm... that's totally bogus. What machine is this ?
> 
> Some i386 box with radeon 7000.

It seem to detect the flat panel incorrectly, or the EDID data is bogus,
maybe that's wrecking something in the new modelist management in
fbdev ? It might be causing us to use a bogus mode that itself casues
atyfb to crash. Tried forcing a mode ?

> > > radeonfb: Can't find mode for panel size, going back to CRT
> > > Unable to handle kernel paging request at virtual address f3fb4000
> > 
> > I'm having a hard time parsing this oops. Looks like fbcon is screwing
> > up, I'm not sure what radeonfb has to do with the problem there...
> 
> I will try with atyfb on another intel box.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

