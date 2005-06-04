Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFDTcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFDTcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFDTcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 15:32:16 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:42880 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261231AbVFDTcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 15:32:10 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.6.12-rc5 : repeatable modprobe usb-storage hang
Date: Sat, 4 Jun 2005 15:32:17 -0400
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200506031341.17749.kernel-stuff@comcast.net> <200506041212.04476.david-b@pacbell.net>
In-Reply-To: <200506041212.04476.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506041532.17710.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 June 2005 15:12, David Brownell wrote:
> On Friday 03 June 2005 10:41 am, Parag Warudkar wrote:
> > Also interesting is this line -
> > [   40.586298] ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Controller is
> > probably using the wrong IRQ.
>
> So did you investigate these IRQ setup problem, or just ignore
> that pointed diagnostic?
>
Adding to the weirdness is that it happens infrequently - most of the times it 
works fine and I see no such error messages. I have ignored it till now. I 
will see if acpi=noirq helps.

> Controllers are not expected to behave if their drivers aren't given
> the correct IRQ.  In particular, when software needs to wait until
> the hardware reports it's finished with something, and the hardware
> never reports that (== never issues the IRQ) then things may hang.
>
The ohci-hcd hang problem might  be related to this. (Load of ohci-hcd with a 
storage device attached to the controller always hangs machine for 2 minutes 
- hang occurs in pci_enable_device()) 

> Also this earlier line already identified a potential root cause:
> > [   38.927690] ACPI: PCI Interrupt 0000:00:02.0[P]: no GSI - using IRQ 11
>
> This could be a problem in either the tables BIOS provided, or in the
> way ACPI is interpreting them, or something else ... I'm not an ACPI guru.
>

Most likely this is  a ACPI oddity - If BIOS was wrong it would have happened 
all the times. The above "no GSI" thing happens only some times and looks 
like that's when things won't work.

> You should be experimenting with ways to get the right IRQ assigned to this
> controller; such problems are common enough that there are probably half a
> dozen boot options affecting what happens.  Or maybe look at BIOS options
> that affect that controller; you might need to update your board's BIOS
> firmware.
>
> - Dave
Thanks for all the pointers. I will start with acpi=noirq and see.  My BIOS 
firmware is up2date.

Parag

-- 
Mac Beer: At first, came only a 16-oz. can, but now comes in a 32-oz. 
can. Considered by many to be a "light" beer. All the cans look 
identical. When you take one from the fridge, it opens itself. The 
ingredients list is not on the can. If you call to ask about the 
ingredients, you are told that "you don't need to know." A notice on the 
side reminds you to drag your empties to the trashcan.
