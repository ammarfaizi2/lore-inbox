Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272119AbSISRx7>; Thu, 19 Sep 2002 13:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272126AbSISRx7>; Thu, 19 Sep 2002 13:53:59 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:15352
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S272119AbSISRx6>; Thu, 19 Sep 2002 13:53:58 -0400
Subject: Re: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Anton Altaparmakov <aia21@cantab.net>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209191041090.968-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0209191041090.968-100000@cherise.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 19:02:30 +0100
Message-Id: <1032458550.27865.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 18:48, Patrick Mochel wrote:
> Yes, and that's the way it's set up: we check if the device has a driver 
> before we bind to it. However, dev->driver doesn't get set before the 
> device is registered with the core for PCI devices. That's fixed easily 
> enough. 
> 
> But, I'm a bit confused on where this is happening. The PCI layer will 
> probe for devices before any drivers are registered. The drivers are 
> registered, then they're attached to devices that were already discovered. 
> So, how are they getting init'ed twice? 

The IDE layer has to preserve ordering. It does that by doing pci device
ordered scans at boot then handing the driver registrations over to the
pci hotplug layer for new inserts.

