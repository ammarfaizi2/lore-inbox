Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbVHOAkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbVHOAkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 20:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbVHOAkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 20:40:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20375 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932612AbVHOAkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 20:40:17 -0400
Date: Mon, 15 Aug 2005 01:43:03 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       James.Smart@Emulex.Com, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] add transport class symlink to device object
Message-ID: <20050815004303.GB9466@parcelfarce.linux.theplanet.co.uk>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com> <20050813213955.GB19235@kroah.com> <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk> <20050814232525.A27481@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814232525.A27481@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 11:25:25PM +0100, Russell King wrote:
> On Sun, Aug 14, 2005 at 04:02:31PM +0100, Matthew Wilcox wrote:
> > Last time I tried to do something like this, it fell over with
> > multi-function serial ports.  Look at this example:
> > 
> > # ls -l /sys/class/tty/ttyS*/device | cut -c40-
> > /sys/class/tty/ttyS0/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> > /sys/class/tty/ttyS1/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> > /sys/class/tty/ttyS2/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> > 
> > Adding the reverse links gets you three links in the 0000:00:04.0
> > directory all called 'tty' (or 'class:tty', whatever), each pointing to
> > a different place.  This doesn't happen for scsi devices as the class is
> > attached to the scsi_dev, not the pci_dev.  I think the tty subsystem
> > needs to be modified to add tty_devs as subdevices of the pci_dev.
> 
> Eww.  Do you really want one struct device per tty with all the
> memory each one eats?
> 
> If that's really what you want you need to talk to Alan and not me.
> Alan looks after tty level stuff, I look after serial level stuff.
> The above is a tty level issue not a serial level issue.

mmm.  I don't know whether it's really a tty level issue or a serial
issue.  The only tty classes with corresponding devices are the serial
ones, at least on my system.  If this is the case, then the right fix
would seem to be something like creating a new struct device for each
serial port, then making that the uart_port->dev instead of the pci_dev
or whatever.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
