Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUJAXr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUJAXr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUJAXr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:47:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:5091 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266833AbUJAXrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:47:11 -0400
Date: Fri, 1 Oct 2004 16:41:15 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Michael Hunold <hunold-ml@web.de>, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Message-ID: <20041001234115.GA9505@kroah.com>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com> <41545421.5080408@web.de> <20040924200503.652ccf8e.khali@linux-fr.org> <415481B4.10804@web.de> <20041001065209.GA9561@kroah.com> <1096633365.16121.125.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096633365.16121.125.camel@newt>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 01:22:45PM +0100, Adrian Cox wrote:
> On Fri, 2004-10-01 at 07:52, Greg KH wrote:
> > On Fri, Sep 24, 2004 at 10:21:08PM +0200, Michael Hunold wrote:
> 
> > > If we have a PCI card where we exactly know what we are doing, we can 
> > > use the NO_PROBE flag to effectively block any probing and can use the 
> > > proposed interface to manually connect the clients.
> > 
> > But why?  The .class feature can accomplish this too.  Just create a new
> > class for this type of adapter and device.  Then only that device will
> > be able to be connected to that adapter, just like you want to have
> > happen, right?
> 
> Either the i2c devices need to be able to support a list of permitted
> adapters, or the i2c adapters need a list of permitted clients. A single
> class isn't adequate. Consider the following scenario:
> 
> The FooTV123 has multiplexor MX3R0K3 and frontend XYZZY, the TVMatic3000
> has frontend XYZZY and multiplexor MX31337, and the FooTV124 has
> multiplexor MX31337 and frontend FR012. All three cards are installed in
> the same machine. In the worst case the probe code for MX31337 puts
> MX3R0K3 into a state that requires a hard reset.
> 
> Manual connection of clients makes it easier to develop a driver outside
> the kernel tree, then merge it when ready, without having to allocate a
> number from a central authority.

Ok, I now understand better, thanks for putting up with me :)

So, got a patch to do this?

thanks,

greg k-h
