Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267715AbUBTIIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 03:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUBTIIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 03:08:06 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:39396 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S267715AbUBTIID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 03:08:03 -0500
Date: Fri, 20 Feb 2004 01:08:01 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
Message-ID: <20040220080801.GA6786@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston> <20040220074041.GA6680@plexity.net> <1077263253.20789.1221.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077263253.20789.1221.camel@gaston>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 20 2004, at 18:47, Benjamin Herrenschmidt was caught saying:
> 
> > If you mean the USB target device itself, can't you walk the
> > tree until you find a device that is no longer on bus_type
> > usb to determine your root?
> 
> I don't feel like walking the tree on each pci_dma access

I never said it would be pretty. :)

> 
> > You could stuff that into platform_data on PCI devices on your platforms.
> 
> I want automatic inheritance to child devices, shouldb't be _that_
> difficult to do ;)

Hmm, I wonder if the easiet way to do this at the moment would be
to add a platform specific hook that gets called during device_add().
On arches that don't need to do this, it would just be a nop, but on 
PPC64 and others it could do whatever is required.  By the time that 
device_add() is called, it is already attached to a bus, so this 
function could walk the tree to inherit parameters at discovery time 
instead of the above suggestion. 

Seems doable without impacting other arches.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
