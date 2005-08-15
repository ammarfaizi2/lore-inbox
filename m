Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVHOWlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVHOWlj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVHOWlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:41:39 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:51664 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965019AbVHOWli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:41:38 -0400
Subject: Re: [PATCH] add transport class symlink to device object
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, James.Smart@Emulex.Com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com>
	 <20050813213955.GB19235@kroah.com>
	 <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 17:41:17 -0500
Message-Id: <1124145677.5089.68.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-14 at 16:02 +0100, Matthew Wilcox wrote:
> /sys/class/tty/ttyS0/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> /sys/class/tty/ttyS1/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> /sys/class/tty/ttyS2/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> /sys/class/tty/ttyS3/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:05.0
> /sys/class/tty/ttyS4/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:05.0

Actually, isn't the fix to all of this to combine Greg and James'
patches?

The Greg one fails in SCSI because we don't have unique class device
names (by convention we use the same name as the device bus_id) and
James' one fails for ttys because the class name isn't unique.  However,
if the link were derived from something like

<class name>:<class device name>

Then is would be unique in both cases.

Unless anyone can think of any more failing cases?

James


