Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUIMRug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUIMRug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUIMRug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:50:36 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:47818 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267686AbUIMRu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:50:28 -0400
Message-ID: <9e47339104091310503edce155@mail.gmail.com>
Date: Mon, 13 Sep 2004 13:50:27 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Cc: Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1095087860.14582.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095074778.14374.41.camel@localhost.localdomain>
	 <9e47339104091308063c394704@mail.gmail.com>
	 <1095087860.14582.37.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How's this going to work with hotplug? Hotplug works by associating a
device with a driver by the PCI ID table contained in the driver. Both
the fbdev and DRI drivers currently contain the same PCI IDs for the
cards that the chipsets they support.

So when a card gets hotplugged, which driver do I load? If it's the
VGA driver, then how do I tell the VGA driver that I want to use fbdev
or DRM? What if I want a different one on each head?

There is one VGA driver and multiple fbdev/DRM drivers, one for each chipset.

I guess you need to build something into the VGA driver that gets the
PCI ID tables out of the various fbdev/DRM drivers and combine them
into a single table visible to hotplug.  Then let the VGA driver take
the hotplug event. The VGA driver can then search it's table and
figure out which driver to initialize.

What if I have two identical PCI video cards. Don't we need an
initialization file to say load DRM on the one in slot 1 and fbdev on
the one in slot 2?

-- 
Jon Smirl
jonsmirl@gmail.com
