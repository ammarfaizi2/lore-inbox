Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272576AbTHPD2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 23:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272577AbTHPD2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 23:28:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:28299 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272576AbTHPD2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 23:28:43 -0400
Date: Fri, 15 Aug 2003 20:28:33 -0700
From: Greg KH <greg@kroah.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Driver Core fixes for 2.6.0-test3
Message-ID: <20030816032833.GA6680@kroah.com>
References: <20030815182459.GA3755@kroah.com> <20030815215459.Y639@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815215459.Y639@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 09:54:59PM +0200, Ingo Oeser wrote:
> Hi Greg,

Hi, I've brought this back to lkml as I'm getting tired of private email
threads about this topic.  Hope you don't mind.

> On Fri, Aug 15, 2003 at 11:25:00AM -0700, Greg KH wrote:
> > Here's some driver core changes that do the following things:
> > 	- remove struct device.name field and fix up remaining
> > 	  subsystems
> 
> Could you point me to the rationale about this?
> 
> I for one considered "everything should have a name" policy very
> useful and extendible.

The main problem is that we don't want to be putting name databases in
the kernel, like PCI, PnP, and USB were starting to do.  People were
starting to complain that the PCI and USB names were not the "proper"
name, as we didn't have enough room for the "full" name.

Naming databases belong in userspace.  For PCI, PnP, and USB we can
determine the name ourselves from userspace using lspci, lspnp, and
lsusb.  Getting rid of the name field prevents us from relying on kernel
code when we shouldn't be.

> Not that I would like to change that back, just like to know why
> this is done, why so late and why after introducing it into all
> drivers in core?

We messed up, and we're now fixing that before people start to rely on
it :)

Now some subsystems still want to export a "name" as there is no other
way to determine the type of the device (no vendor or product ids.)  For
them, a name field is just fine to have.  For example, I moved the name
field back into the i2c_client and i2c_adapter structures for this very
reason.

Hey, we're saving kernel memory, and this is a problem?  :)

Hope this helps explain things.

greg k-h
