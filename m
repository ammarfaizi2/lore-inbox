Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266025AbUFDWsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUFDWsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUFDWr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:47:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:8136 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266028AbUFDWq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:46:58 -0400
Date: Fri, 4 Jun 2004 14:52:23 -0700
From: Greg KH <greg@kroah.com>
To: "Frank A. Uepping" <Frank.A.Uepping@t-online.de>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: struct device::release issue
Message-ID: <20040604215223.GC13825@kroah.com>
References: <200403061247.24251.Frank.A.Uepping@t-online.de> <20040327011436.GB14076@kroah.com> <200403271526.25505.Frank.A.Uepping@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403271526.25505.Frank.A.Uepping@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 03:26:25PM +0100, Frank A. Uepping wrote:
> On Saturday 27 March 2004 02:14, Greg KH wrote:
> > On Sat, Mar 06, 2004 at 12:47:24PM +0100, Frank A. Uepping wrote:
> > > Hi,
> > > if device_add fails (e.g. bus_add_device returns an error) then the release 
> > > method will be called for the device. Is this a bug or a feature?
> > 
> > Are you sure this will happen?  device_initialize() gets a reference
> > that is still present after device_add() fails, right?  So release()
> > will not get called.
> At the label PMError, kobject_unregister is called, which decrements the
> recount by 2, which will result in calling release at label Done (put_device).
> 
> kobject_unregister should be superseded by kobject_del.
> Here is a patch:

Sorry for the long delay.  You are correct, I've applied this patch.  It
will show up in the next -mm release and will go to Linus after 2.6.7 is
out.

thanks,

greg k-h
