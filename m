Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTFKPrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTFKPrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:47:31 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:49115 "EHLO gaston")
	by vger.kernel.org with ESMTP id S262494AbTFKPrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:47:31 -0400
Subject: Re: pci_domain_nr vs. /sys/devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Matthew Wilcox <willy@debian.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20030611164040.E16643@flint.arm.linux.org.uk>
References: <1055341842.754.3.camel@gaston>
	 <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>
	 <20030611164040.E16643@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055347252.612.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 18:00:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 17:40, Russell King wrote:

> See pci_alloc_primary_bus_parented() in drivers/pci/probe.c.  The '0'
> is the bus number passed in.  So, the names include the pci bus numbers
> of the root buses.

This is the right solution imho, yes. Adding more indirection with
pci-domain isn't useful.

Now, we should also fix pci_setup_device to make this naming
generic to the entire kernel don't you think ? This won't
affect /proc/bus/pci as it doesn't use the slot_name field
in pci_dev, but at least it will make naming consistent.

(That also mean increasing slot_name size in pci.h)

Ben.

