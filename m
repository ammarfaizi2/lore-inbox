Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbTFQRPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTFQRPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 13:15:44 -0400
Received: from ida.rowland.org ([192.131.102.52]:5124 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264861AbTFQRPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 13:15:37 -0400
Date: Tue, 17 Jun 2003 13:29:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030616233651.GB27033@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0306171318090.621-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Greg KH wrote:

> All disk info is in the /sys/block directory, does that work for you?

Not scsi disk info.  (Or maybe it should be there but it isn't.)  And no,
it doesn't work for me because it's owned by the scsi core, not my driver.

> I think the scsi core will create you a directory that you can use that
> will have the proper lifetime that you are looking for.  If not, I can
> look into doing something else for some of the other USB devices that
> are not using the USB major.

I don't think it would be appropriate to use that directory, since my 
driver wouldn't own it.

How about creating a /sys/class/usb/usb-storage/ directory, under which
there could be a directory for each USB mass-storage device?  Or would it 
be better to create a usb-storage.# directory under the interface's 
directory in /sys/devices/ ?

It's worth pointing out that both the OHCI and EHCI drivers also do the
same wrong thing.  They create their attribute files in a directory
owned by the PCI driver.

Alan Stern

