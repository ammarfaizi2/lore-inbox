Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVHNWZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVHNWZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 18:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVHNWZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 18:25:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48649 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932336AbVHNWZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 18:25:40 -0400
Date: Sun, 14 Aug 2005 23:25:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, James.Smart@Emulex.Com,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add transport class symlink to device object
Message-ID: <20050814232525.A27481@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
	James.Smart@Emulex.Com, Andrew Morton <akpm@osdl.org>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com> <20050813213955.GB19235@kroah.com> <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Sun, Aug 14, 2005 at 04:02:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 04:02:31PM +0100, Matthew Wilcox wrote:
> On Sat, Aug 13, 2005 at 02:39:56PM -0700, Greg KH wrote:
> > Heh, I already have a patch like this pending for 2.6.14 at:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/driver-link-device-and-class.patch
> 
> Last time I tried to do something like this, it fell over with
> multi-function serial ports.  Look at this example:
> 
> # ls -l /sys/class/tty/ttyS*/device | cut -c40-
> /sys/class/tty/ttyS0/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> /sys/class/tty/ttyS1/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> /sys/class/tty/ttyS2/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> /sys/class/tty/ttyS3/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:05.0
> /sys/class/tty/ttyS4/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:05.0
> 
> Adding the reverse links gets you three links in the 0000:00:04.0
> directory all called 'tty' (or 'class:tty', whatever), each pointing to
> a different place.  This doesn't happen for scsi devices as the class is
> attached to the scsi_dev, not the pci_dev.  I think the tty subsystem
> needs to be modified to add tty_devs as subdevices of the pci_dev.

Eww.  Do you really want one struct device per tty with all the
memory each one eats?

If that's really what you want you need to talk to Alan and not me.
Alan looks after tty level stuff, I look after serial level stuff.
The above is a tty level issue not a serial level issue.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
