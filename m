Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUINLex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUINLex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269293AbUINLdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:33:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:55484 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269296AbUINLbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:31:24 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <9e47339104091310503edce155@mail.gmail.com>
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
	 <9e47339104091310503edce155@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095157635.16588.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 11:27:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-13 at 18:50, Jon Smirl wrote:
> How's this going to work with hotplug? Hotplug works by associating a
> device with a driver by the PCI ID table contained in the driver. Both
> the fbdev and DRI drivers currently contain the same PCI IDs for the
> cards that the chipsets they support.

Insert card
	pc layer calls hotplug
	hotplug loads vga driver
	pci layer calls vga driver
	vga driver generates hotplug event
	hotplug loads stuff (user policy)
	vga driver calls hotplugged drivers

> I guess you need to build something into the VGA driver that gets the
> PCI ID tables out of the various fbdev/DRM drivers and combine them
> into a single table visible to hotplug.  Then let the VGA driver take
> the hotplug event. The VGA driver can then search it's table and
> figure out which driver to initialize.

Thats what it does. The vga_device_register functions take a vga_driver
object which is a PCI driver lookalike with an extra field of "type" so
you can load DRM's, FB's etc

> What if I have two identical PCI video cards. Don't we need an
> initialization file to say load DRM on the one in slot 1 and fbdev on
> the one in slot 2?

Possibly, thats for hotplug user space policy. 

Alan

