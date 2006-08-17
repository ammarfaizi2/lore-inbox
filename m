Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWHQG5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWHQG5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWHQG5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:57:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:60860 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932080AbWHQG5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:57:36 -0400
Subject: Re: PATCH: Multiprobe sanitizer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155774994.15195.12.camel@localhost.localdomain>
References: <1155746538.24077.371.camel@localhost.localdomain>
	 <20060816222633.GA6829@kroah.com>
	 <1155774994.15195.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 08:57:13 +0200
Message-Id: <1155797833.11312.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 01:36 +0100, Alan Cox wrote:
> Ar Mer, 2006-08-16 am 15:26 -0700, ysgrifennodd Greg KH:
> > What would this help out with?  Would the PCI layer (for example) handle
> > this "notify the core that it can continue" type logic?  Or would the
> > individual drivers need to be able to control it?
> > 
> > I'm guessing that you are thinking of this in relation to the disk
> > drivers, have you found cases where something like this is necessary due
> > to hardware constraints?
> 
> Actually it occurs everywhere because what happens is
> 
> 	PCI enumerates in bus order
> 	Threads *usually* run in bus order
> 
> so every n'th boot your devices re-order themselves out of bus order,
> and eth1 becomes eth0 for the day.

Devices reorder themselves anyways .... look at my XPC shuttle, it has
some usb all-sort-of-card reader built-in and every other day, I get
that to be sda instead of the internal SATA... solution: use mounting by
label. With USB network type of things etc... same problem. I really
don't like the idea of having to add special things in PCI drivers to
"work around" the problem (which will only work in some cases and will
slightly lower how much parallelism we can do).

In fact, I'm all about making the problem worse by agressively
paralellilizing everything to get distros config mecanisms to catch up
and stop using the interface name (or use ifrename).

Ben.


