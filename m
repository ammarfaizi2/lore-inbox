Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbTJYRx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbTJYRx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 13:53:26 -0400
Received: from smtp.compuserve.de ([62.52.27.101]:41675 "HELO
	desws061.mediaways.net") by vger.kernel.org with SMTP
	id S262753AbTJYRxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 13:53:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16282.45806.428547.279213@zeus.local>
Date: Sat, 25 Oct 2003 19:29:18 +0200
From: Egbert Eich <eich@xfree86.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       <kronos@kronoz.cjb.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
In-Reply-To: torvalds@osdl.org wrote on Thursday, 23 October 2003 at 16:23:44 -0700 
References: <20031023213144.66685.qmail@web14916.mail.yahoo.com>
	<Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > > could lead to problems with hotplug.  XFree is also mapping PCI ROMs in without
 > > informing the kernel and that can definitely cause problems.
 > 
 > Absolutely. Changing PCI configurations without telling the kernel _will_ 
 > cause problems. Especially for hotplug systems, but it's also very iffy to 
 > do if the card is behind a PCI bridge, since you have to take bridge 
 > resources into account (and know which bridges are transparent, which are 
 > not, etc etc). 

Speaking of XFree86: when I developed the PCI resource stuff in 
XFree86 I was trying to get support from kernel folks to get the 
appropriate user space interfaces into the kernel. When I got 
nowhere I decided to do everything myself. 
XFree86 does PCI bridge tracking and one reason it does this is PCI
ROM mapping. 
 > 
 > The kernel spends a lot of effort on getting this right, and even so it 
 > fails every once in a while (devices that use IO or memory regions without 
 > announcing them in the standard BAR's are quite common, and the kernel has 
 > to have special quirk entries for things like that).

Right. One reason why the PCI code in XFree86 looks so difficult is
that old ATi Mach?? cards had their 8514 registers (and their mirror
images) scattered all over the PIO space.

 > 
 > Few enough drivers actually want to enable the roms, but the code should 
 > look something like
 > 
 > 	/* Assign space for ROM resource if not already assigned. Ugly. */
 > 	if (!pci_resource_start(dev, PCI_ROM_RESOURCE))
 > 		if (pci_assign_resource(dev, PCI_ROM_RESOURCE) < 0)
 > 			return -ENOMEM;

[Stuff deleted] .....

Is there any API that allows one to do this from user space?
There are plenty of XFree86 drivers around that don't have a
DRM kernel module and it should  be possible to run those which
do without DRI support, therefore it would be a good if the
XFree86 driver could do this registration itself.

Cheers,
	Egbert.
