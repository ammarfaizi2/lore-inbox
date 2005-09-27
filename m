Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVI0OzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVI0OzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVI0OzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:55:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:49329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964959AbVI0OzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:55:14 -0400
Date: Tue, 27 Sep 2005 07:54:42 -0700
From: Greg KH <greg@kroah.com>
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: SPI
Message-ID: <20050927145442.GA27470@kroah.com>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru> <20050927124335.GA10361@kroah.com> <1127831236.7577.33.camel@diimka.dev.rtsoft.ru> <20050927143505.GA24245@kroah.com> <1127832597.7577.37.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127832597.7577.37.camel@diimka.dev.rtsoft.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 06:49:57PM +0400, dmitry pervushin wrote:
> On Tue, 2005-09-27 at 07:35 -0700, Greg KH wrote:
> > Please read up on how the lifetime rules work for devices, and what
> > needs to happen in the release function (hint, take a look at other
> > busses, like USB and PCI for examples of what needs to be done.)
> As far as I can see, pci_release_device deletes the pci_dev using kfree.

Yes.

> But here we have statically allocated spi_device structures --
> spi_device_add does not allocate spi_device, but uses caller-allocated
> one.

Not good, reference counted structures almost always should be
dynamically created.  Please change this to also be true for SPI,
otherwise you will have a lot of nasty issues with devices that can be
removed at any point in time.

thanks,

greg k-h
