Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTFPRwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTFPRwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:52:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13978 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264066AbTFPRty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:49:54 -0400
Date: Mon, 16 Jun 2003 19:03:44 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030616180344.GP6754@parcelfarce.linux.theplanet.co.uk>
References: <20030616182003.D13312@flint.arm.linux.org.uk> <Pine.LNX.4.44L0.0306161349360.1350-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306161349360.1350-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 01:54:34PM -0400, Alan Stern wrote:

> > IMO, if you don't own the object (and therefore don't know its lifetime),
> > you shouldn't be adding sysfs or device model attributes of any kind to
> > that object.
> 
> That's not practical.  How else can a device driver provide 
> device-specific configuration options or information in sysfs?  In many 
> cases the device is owned by the bus, not the device driver.

Practical or not, when you put sysfs object into a structure, you take
full responsibility for the lifetime of that structure.  Period.

Note that problems exist even when kernel is non-modular.  Even if code
stays in place, the data getting freed under you is just as bad.  And
that can trivially happen without any modules.
