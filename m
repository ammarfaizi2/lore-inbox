Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272859AbTHIROY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275065AbTHIRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:11:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:62096 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275018AbTHIRLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:11:39 -0400
Date: Sat, 9 Aug 2003 10:07:14 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More PCI fixes for 2.6.0-test2
Message-ID: <20030809170714.GA7831@kroah.com>
References: <20030809003036.GA3163@kroah.com> <20030809091524.A13885@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809091524.A13885@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 09:15:24AM +0100, Russell King wrote:
> On Fri, Aug 08, 2003 at 05:30:36PM -0700, Greg KH wrote:
> > Here are a few more fixes for the PCI core code for 2.6.0-test2-bk.
> > I've removed all of the struct device.name usages as that field is about
> > to go away, and there is a fix from Ivan in here too.
> 
> When was that decided?  I don't remember seeing any discussion, and since
> it affects more than PCI... Seems like a backwards step to me.

We discussed this at OLS/Kernel Summit.  I sure thought you were there
for that conversation.  The PnP, USB, I2C, and PCI core is already
cleaned up, with patches in 2.6.0-test3, and I have a patch around here
that fixes up the rest of the kernel (SCSI, PCMCIA, and then the driver
core.)  I'll send them out next week.

Basically, we don't want to be carrying around info if we don't really
need it (like the PCI names database.)  All of this info can already be
found from userspace programs, with a few exceptions.  I2C is one such
exception, so I've added the name back into the local structure (and
will export it to sysfs once the driver core 'name' file removal patch
is in.)   

This is a nice memory savings for the majority of the users of the
struct device structure.

thanks,

greg k-h
