Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269768AbUJAMWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269768AbUJAMWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269764AbUJAMWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:22:52 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:36277 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S269768AbUJAMWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:22:50 -0400
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
From: Adrian Cox <adrian@humboldt.co.uk>
To: Greg KH <greg@kroah.com>
Cc: Michael Hunold <hunold-ml@web.de>, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
In-Reply-To: <20041001065209.GA9561@kroah.com>
References: <414F111C.9030809@linuxtv.org>
	 <20040921154111.GA13028@kroah.com> <41545421.5080408@web.de>
	 <20040924200503.652ccf8e.khali@linux-fr.org> <415481B4.10804@web.de>
	 <20041001065209.GA9561@kroah.com>
Content-Type: text/plain
Message-Id: <1096633365.16121.125.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 13:22:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 07:52, Greg KH wrote:
> On Fri, Sep 24, 2004 at 10:21:08PM +0200, Michael Hunold wrote:

> > If we have a PCI card where we exactly know what we are doing, we can 
> > use the NO_PROBE flag to effectively block any probing and can use the 
> > proposed interface to manually connect the clients.
> 
> But why?  The .class feature can accomplish this too.  Just create a new
> class for this type of adapter and device.  Then only that device will
> be able to be connected to that adapter, just like you want to have
> happen, right?

Either the i2c devices need to be able to support a list of permitted
adapters, or the i2c adapters need a list of permitted clients. A single
class isn't adequate. Consider the following scenario:

The FooTV123 has multiplexor MX3R0K3 and frontend XYZZY, the TVMatic3000
has frontend XYZZY and multiplexor MX31337, and the FooTV124 has
multiplexor MX31337 and frontend FR012. All three cards are installed in
the same machine. In the worst case the probe code for MX31337 puts
MX3R0K3 into a state that requires a hard reset.

Manual connection of clients makes it easier to develop a driver outside
the kernel tree, then merge it when ready, without having to allocate a
number from a central authority.

Creating the adapter with a list of permitted clients is also an
adequate solution for a bus like I2C which doesn't properly support
probing. The OCP bus on PowerPC has no explicit probing, and uses a
similar approach of creating the bus with a list of the devices possible
for that PowerPC model.

- Adrian Cox
Humboldt Solutions Ltd.


