Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268543AbTBWUS6>; Sun, 23 Feb 2003 15:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268545AbTBWUS6>; Sun, 23 Feb 2003 15:18:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14720
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268543AbTBWUS5>; Sun, 23 Feb 2003 15:18:57 -0500
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
In-Reply-To: <20030223193229.F20405@flint.arm.linux.org.uk>
References: <20030223173441.D20405@flint.arm.linux.org.uk>
	 <Pine.LNX.4.44.0302231054420.11584-100000@home.transmeta.com>
	 <20030223193229.F20405@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046035789.1669.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 23 Feb 2003 21:29:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-23 at 19:32, Russell King wrote:
> 1. discovering all devices
> 2. apply any fixups needed
> 3. initialise any resources that need initialising
> 4. once all devices have been initialised, registering each
>    device with sysfs and thereby letting the drivers know.

There is an additional catch with the resources to be careful of.
Some environments require we register/unregister additional
IRQ routing tables. Thats a minor problem but does affect things
like IBM thinkpad 600 docking station. Thats a transparent
bridge with devices that appear and vanish stuck behind it.
Similar problems - it needs

	pci_attach_behind_bridge()
	pci_destroy_behind_bridge()

functionality just like the cardbus toys

