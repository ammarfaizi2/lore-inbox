Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTFPRou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTFPRot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:44:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264067AbTFPRor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:44:47 -0400
Date: Mon, 16 Jun 2003 11:00:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Alan Stern <stern@rowland.harvard.edu>
cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44L0.0306161349360.1350-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.44.0306161057230.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > In the pcmcia case, we effectively own the object (class device) we're
> > attaching the files to, so we can ensure that the module is not unloaded
> > until the class device files are closed and all references to the object
> > are gone.
> > 
> > IMO, if you don't own the object (and therefore don't know its lifetime),
> > you shouldn't be adding sysfs or device model attributes of any kind to
> > that object.
> 
> That's not practical.  How else can a device driver provide 
> device-specific configuration options or information in sysfs?  In many 
> cases the device is owned by the bus, not the device driver.

Read it again. :) 

The driver is able to create a class-specific object for the device, which 
it owns entirely. Russell is suggesting that if you're going to export 
attributes, you best be doing them as attributes of the object you own. 

Otherwise, if you're a subordinate module, then you should explicitly 
increment the refcount of the module of the object you're exporting 
attributes for, and decrement it when your module is unloaded. Then again, 
this may happen implicitly with modules..


	-pat

