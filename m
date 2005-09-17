Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVIQHnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVIQHnI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 03:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVIQHnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 03:43:08 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60889 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750993AbVIQHnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 03:43:06 -0400
Subject: Re: [linux-usb-devel] Re: Lost keyboard on Inspiron 8200 at 2.6.13
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Greg KH <greg@kroah.com>,
       dtor_core@ameritech.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       caphrim007@gmail.com, david-b@pacbell.net,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44L0.0509170005450.689-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0509170005450.689-100000@netrider.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 17 Sep 2005 09:08:23 +0100
Message-Id: <1126944503.26447.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-17 at 00:12 -0400, Alan Stern wrote:
> Where does early handoff install a fake interrupt handler for UHCI?  I 
> don't see any in drivers/pci/quirks.c.

Fedora patches for 2.6.9 rather than the current code.

> > You need them because an IRQ could be pending on the channel at the
> > point you switch over or triggered on the switch and a few people saw
> > this behaviour.
> 
> Yes, that would be needed if you have edge-triggered interrupts.  But 
> isn't PCI supposed to be level-triggered?

Yes and at the time several people saw hangs on the changeover unless we
cleared pending IRQ bits in the IRQ handler. That may have been related
to various ACPI problems from back then. I don't know for sure.

> > I'd like to see it shared but that means handoff belongs in the input
> > layer code and the USB layer needs to call into it if appropriate.
> 
> Why does it mean that?  And why the input layer as opposed to the PCI 
> layer, where it is now?

PCI layer makes even more sense yes

