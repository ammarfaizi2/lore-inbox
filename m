Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbSLDT1d>; Wed, 4 Dec 2002 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSLDT1c>; Wed, 4 Dec 2002 14:27:32 -0500
Received: from host194.steeleye.com ([66.206.164.34]:10759 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267034AbSLDT1b>; Wed, 4 Dec 2002 14:27:31 -0500
Message-Id: <200212041935.gB4JZ0p03464@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, mochel@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Wed, 04 Dec 2002 10:13:53 PST." <20021204181353.GA28062@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 13:35:00 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg@kroah.com said:
> Why not have a call in the driver that notifies the bus specific core
> of this?  Or just check the status of the return value of your "probe"
> function that the bus provides.  See usb_device_probe() and
> pci_device_probe() for examples of this. 

Well, I did do it this way for parisc.  However, I assumed from reading the 
driver model docs that we were transitioning to using the generic driver probe 
rather than doing probe interceptions like this.

Doing it like this just seems rather clumsy.  wouldn't it be better to 
deprecate bus specific registrations in favour of the generic one?

There is another advantage to notifiers: they can be chained.  Certain bus 
architectures need to do additional setup for things like pci devices.  They 
would be able to do this by attaching a notifier.

James


