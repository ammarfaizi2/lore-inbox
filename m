Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278577AbRJSS0N>; Fri, 19 Oct 2001 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278580AbRJSS0D>; Fri, 19 Oct 2001 14:26:03 -0400
Received: from air-1.osdl.org ([65.201.151.5]:43532 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S278577AbRJSSZq>;
	Fri, 19 Oct 2001 14:25:46 -0400
Date: Fri, 19 Oct 2001 11:26:19 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <8BBKUgOHw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hmm. So, this would be a device ID, much like the Vendor/Device ID pair in
> > PCI space?
>
> Except for the fact that the Vendor/Device ID pair is a device *class*
> identifier, and the uuid is a device *instance* identifier.

Actually, the Vendor/Device ID pair is a unique identifier for the device
model. There are a Base Class and Subclass IDs, as well as a subsystem
vendor ID.

There are equivalents in USB. But, neither of them are globally unique
identifiers for the device. That doesn't necessarily mean that one
couldn't be ascertained from the device; ethernet cards do have MAC
addresses. But, I don't think that many will have a ID/serial number.

And this leads to inconsistency. You'll have PCI devices that have a
Vendor/Device/Class ID, and some that have a device-specific ID. Then
you'll have USB devices with the same. And what about legacy devices?

Which leads me to the question: what real benefit does this have? Why
would you ever want to do a global search in kernel space for a particular
device? The bus structure can keep (and likely already does keep) this
information. It can export it to userland on its own; the top layer
doesn't need to do that.

Yes, the formats of each file will be different, but they would be anyway.
The names may be different for different buses, but we can encourage the
bus layers to all export a file of the same name ("ID") if we want.

I don't think the UUID belongs in the top level structure. It belongs in
whatever structure dictates it - the bus structure or the class strucutre.

	-pat


