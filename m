Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVFVS1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVFVS1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVFVS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:27:48 -0400
Received: from sd291.sivit.org ([194.146.225.122]:60938 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262233AbVFVS1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:27:38 -0400
Subject: Re: [linux-usb-devel] Re: usb sysfs intf files no longer created
	when probe fails
From: Stelian Pop <stelian@popies.net>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050622162221.GB2274@kroah.com>
References: <Pine.LNX.4.44L0.0506221133230.6938-100000@iolanthe.rowland.org>
	 <1119455608.4651.5.camel@localhost.localdomain>
	 <20050622162221.GB2274@kroah.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 22 Jun 2005 20:27:36 +0200
Message-Id: <1119464856.5080.4.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 juin 2005 à 09:22 -0700, Greg KH a écrit :
> On Wed, Jun 22, 2005 at 05:53:28PM +0200, Stelian Pop wrote:
> > Le mercredi 22 juin 2005 ?? 11:41 -0400, Alan Stern a ??crit :
> > 
> > > This is a curious aspect of the driver model core.  Should failure of a 
> > > driver to bind be considered serious enough to cause device_add to fail?
> > > The current answer is Yes unless the driver's probe routine returns 
> > > -ENODEV or -ENXIO, in which case the failure is not considered serious.
> > 
> > Indeed. I've also tracked my problem down to the hid core which returns
> > -EIO when it fails to drive an unknown HID device, instead of a more
> > logical -ENODEV (this is not a failure to init a known device, but
> > rather the impossibility to init an unknown device).
> > 
> > The patch below solves the problem for me:
> 
> Damm, beat me by a few minutes :)

:)

> Yes, this is the proper fix for this.
> 
> But to answer Alan's main question, I think you are correct, we should
> not fail device_add if binding a device fails.  I can see this causing a
> lot of very difficult problems in the future (including the fact that
> I've been hitting this bug with a new driver I'm writing and didn't even
> realize it...)
> 
> So, I'll apply this one, and revert the main part of Hannes's patch too.

Thanks.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

