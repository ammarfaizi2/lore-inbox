Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUBTIxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 03:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267742AbUBTIxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 03:53:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:10410 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267739AbUBTIxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 03:53:36 -0500
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: dsaxena@plexity.net, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4035C8C4.8010605@pacbell.net>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	 <1077256996.20789.1091.camel@gaston> <20040220074041.GA6680@plexity.net>
	 <1077263253.20789.1221.camel@gaston> <20040220080801.GA6786@plexity.net>
	 <4035C8C4.8010605@pacbell.net>
Content-Type: text/plain
Message-Id: <1077266892.20779.1290.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 19:48:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, usb_device->bus->controller is the only access that
> should be needed ... much prettier than a tree walk!  It's
> set up as part of device enumeration.
> 
> Some of the usb_buffer_*() mapping calls could probably
> start to get inlined now, using the generic DMA calls.

It all depends what the USB device driver does. If it does
pass the struct device of it's controller, it's fine. If we
want it to be able to pass its own struct device, we need
this walk... it's a matter of how we want this API to behave.

Same goes for firewire, and possibly others

Anyway, a platform hook in device_add() seem like it could be
useful for other things as well...

Ben.


