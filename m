Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbWFARrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbWFARrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWFARrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:47:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44555 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965255AbWFARrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:47:14 -0400
Date: Thu, 1 Jun 2006 13:47:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>, Mark Lord <lkml@rtr.ca>
cc: Andrew Morton <akpm@osdl.org>, David Liontooth <liontooth@cogweb.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
In-Reply-To: <447F2536.9030904@rtr.ca>
Message-ID: <Pine.LNX.4.44L0.0606011340540.7186-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006, linux-os (Dick Johnson) wrote:

> > If they do, they are violating the spec. A device in the unconfigured (state 0)
> > state must not draw more than 100mA.
...
> Hmmm, the USB-IF recommends 100 mA per port, not requires.

See section 7.2.1 of the USB 2.0 specification (p. 177):

	Devices must also ensure that the maximum operating current drawn 
	by a device is one unit load, until configured.

Note that a unit load is defined as to be 100 mA.  This is a requirement, 
not a recommendation.


On Thu, 1 Jun 2006, Mark Lord wrote:

> I think a far more sensible approach would be to just ensure that the
> total current draw for the (unpowered) hub and all connected devices,
> stays below the 500mA allowed.  So a 200mA device could coexist with
> a 100mA device on a hub which itself steals 100mA.

On that same page the specification says:

	Bus-powered hubs: Draw all of their power for any internal
	functions and downstream facing ports from VBUS on the hub s
	upstream facing port.  Bus-powered hubs may only draw up to one
	unit load upon power-up and five unit loads after configuration.
	The configuration power is split between allocations to the hub,
	any non-removable functions and the external ports. External ports
	in a bus-powered hub can supply only one unit load per port
	regardless of the current draw on the other ports of that hub.

This clearly states that a bus-powered hub cannot supply 200 mA on one
port, even if another port is unoccupied.

Alan Stern

