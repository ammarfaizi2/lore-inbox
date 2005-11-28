Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVK1Sny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVK1Sny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVK1Sny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:43:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:48031 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932167AbVK1Snx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:43:53 -0500
Date: Mon, 28 Nov 2005 12:40:25 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <afleming@gate.crashing.org>
Subject: Re: [DRIVER MODEL] Allow overlapping resources for platform devices
In-Reply-To: <20051128180555.GB14557@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0511281236250.27530-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2005, Russell King wrote:

> On Mon, Nov 28, 2005 at 10:15:39AM -0600, Kumar Gala wrote:
> > There are cases in which a device's memory mapped registers overlap
> > with another device's memory mapped registers.  On several PowerPC
> > devices this occurs for the MDIO bus, whose registers tended to overlap
> > with one of the ethernet controllers.
> 
> Hrm, shouldn't the MDIO device be registered by the ethernet driver then?
> The MDIO device is a child of the ethernet device - and this also brings
> up the question about PM ordering - should the MDIO device be suspended
> before or after the ethernet device.

Well the MDIO device actually is conceptually separate from the ethernet 
controller that shares register space with it.  For example, we may have a 
processor with 4 ethernet controllers on it.  We use the register set in 
controller 1 to get to the MDIO "device" for all four controllers.

Hopefully, Andy can provide further details about order issues and how the 
current PHY layer interacts with the ethernet controller.

However, the issue still exists that the MDIO devices registers live 
inside another devices register space.

- kumar

