Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVDBU0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVDBU0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDBU0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:26:03 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:37773 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261255AbVDBUZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:25:52 -0500
Date: Sat, 2 Apr 2005 15:20:00 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Marty Leisner <leisner@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bridge devices questions
Message-ID: <20050402202000.GA27522@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Marty Leisner <leisner@rochester.rr.com>,
	linux-kernel@vger.kernel.org
References: <200504021804.j32I4XGd002721@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504021804.j32I4XGd002721@dell.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 01:04:33PM -0500, Marty Leisner wrote:
> I have to write some code to insert a non-standard bridge
> (it identifies itself as bridge-other, but it functions
> as a pci-pci bridge).
> 
> I'm going to be using 2.4.2x and eventually 2.6.x for intel
> and ppc...

I'm currently working on a new pci bridge class framework for 2.6.  The most
significant change is that you will be able to bind to the bridge using a
"struct pci_driver".

> 
> In the pci_dev structure (for 2.4.29)
> there's
> (in include/linux/pci.h)
> 
> 00355 #define DEVICE_COUNT_RESOURCE   12
> 00410         struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
> 
> We also have:
> 00431 /*
> 00432  *  For PCI devices, the region numbers are assigned this way:
> 00433  *
> 00434  *      0-5     standard PCI regions
> 00435  *      6       expansion ROM
> 00436  *      7-10    bridges: address space assigned to buses behind the bridge
> 00437  */
> 00438 
> 00439 #define PCI_ROM_RESOURCE 6
> 00440 #define PCI_BRIDGE_RESOURCES 7
> 00441 #define PCI_NUM_RESOURCES 11
> 
> Now where my confusion sets in:
> 	1) PCI_NUM_RESOURCES + 1 == DEVICE_COUNT_RESOURCE 
> Why?

At a glance it looks like it's because the array starts at 0.

> 	2) I understand the first 6 regions (standard) and the expansion rom) --
> 	   why 5 more?  

I'm currently redesigning this to use a resource array in "struct device".

> 	3) I've only seen instances of 3 bus regions used -- IO, MEM prefetch,
> 		MEM nonprefetch -- are they order dependent?

There are 4 on cardbus bridges.  In my implementation, they will probably not
be very order dependent.

> 
> Thanks...
> 
> Marty Leisner
> leisner@rochester.rr.com

Could you provide any additional details about this bridge?

Thanks,
Adam
