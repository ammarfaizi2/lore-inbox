Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265443AbRF0XRo>; Wed, 27 Jun 2001 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265445AbRF0XRe>; Wed, 27 Jun 2001 19:17:34 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:26118 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265444AbRF0XRZ>;
	Wed, 27 Jun 2001 19:17:25 -0400
Date: Thu, 28 Jun 2001 09:12:48 +1000
To: Tom Gall <tom_gall@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
Message-ID: <20010628091248.A23627@krispykreme>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
User-Agent: Mutt/1.3.18i
From: anton@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> The following 3 functions are added. Their purpose is a little
> different than to add support for more than 256 buses but they are
> important. Skip ahead and I'll explain what they are for....
> 
> int (*pci_read_bases)(struct pci_dev *, int cnt,int rom);  /* These optional
> hooks provide */
> int (*pci_read_irq)(struct pci_dev *);                     /* the arch dependant
> code a way*/
> int (*pci_fixup_registers)(struct pci_dev *);              /* to manage the
> registers.     */

I do not think these functions are required at all.

> The 3 additional functions are hooks so that an architecture has a
> chance to make sure things are in order beforehand. pci_read_bases is
> for the management and fixup of the BARs. pci_read_irq is the same but
> for IRQs.  pci_fixup_registers again same idea but for bridge
> resources.
> 
> The essense of the design here is to allow you to get in and make sure
> everything is ok with the card, bridge etc, beforehand so as to avoid
> multiple bus walks. 

Please look at how other architectures solve this problem. For example
on ppc32 we already fix up the BARs if required. There are also hooks
to fix the irq, you seem to be duplicating all of this.

Anton
