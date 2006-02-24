Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWBXRxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWBXRxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWBXRxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:53:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:65208 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750912AbWBXRxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:53:03 -0500
Date: Fri, 24 Feb 2006 12:53:01 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Matthew Wilcox <matthew@wil.cx>
cc: Greg KH <greg@kroah.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Missing piece from as659
In-Reply-To: <20060224164901.GQ28587@parisc-linux.org>
Message-ID: <Pine.LNX.4.44L0.0602241246150.5177-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Matthew Wilcox wrote:

> Alan, you didn't cc the pci mailing list on the original patch.
> http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/2673.html

This seems to be a blind spot of mine.  Yours is the second complaint in 
two days about patches I failed to CC to the appropriate 
maintainer/mailing-list...

> You only fix pci_get_subsys; pci_get_class has the same bug.

Please submit a similar bugfix for pci_get_class, then.  I just noticed 
the log messages from pci_get_subsys because that's the routine that 
happened to run on the machine I was testing.

> If it is a bug, of course.  It's not clear to me whether it's permissible
> to call pci_dev_put under a spinlock or not.  That boils down to whether
> kobject ->release methods can sleep or not.  That isn't documented in
> Documentation/kobject.txt and I rather think it should be.

It is a bug, but it has been ignored up until recently.  Within the last 
month or two, Greg added a might_sleep() call to put_device().  It 
wouldn't hurt to do the same thing to kobject_put(), or maybe just 
kobject_release().

Alan Stern

