Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUFTWXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUFTWXd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUFTWXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:23:33 -0400
Received: from netrider.rowland.org ([192.131.102.5]:25867 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S265966AbUFTWXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:23:19 -0400
Date: Sun, 20 Jun 2004 18:23:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: BUG(?): class_device_driver_link()
In-Reply-To: <1087615720.2134.233.camel@mulgrave>
Message-ID: <Pine.LNX.4.44L0.0406201816380.19414-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2004, James Bottomley wrote:

> Well, the SCSI model for using these things isn't exactly the same as a
> more standard entity like a PCI device.
> 
> For every SCSI device the mid-layer scans, we allocate a generic device.
> 
> We have various drivers in the driver model corresponding to our Upper
> Layer Drivers (disc[sd] tape[st] etc), although there are SCSI devices
> (like processors) that will get no driver at all bound.
> 
> We then use classes to export *device* interfaces, like one class of all
> devices, another for Parallel interface devices, another for Fibre
> Channel devices and so on.
> 
> We expect the class interface to work whether or not a driver is
> present, because the class as we've implemented it is an interface to a
> device property, not a driver property (and we also expect the class
> interface to span multiple drivers...tapes and discs may all be attached
> to a parallel bus, etc).
> 
> It sounds like the mismatch is interface on device rather than interface
> on driver, but I don't see a way we could make the interface on driver
> work for us because we need the interface even if a driver isn't bound.

You could change things so that the "driver" exported to the driver-model
core really lives in the SCSI mid-layer and simply contains stubs that
reflect things like remove(), shutdown(), and so on to the actual
upper-layer driver.  Or am I missing some fundmental reason why this 
wouldn't be a good idea?

Alan Stern

