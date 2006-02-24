Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWBXSFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWBXSFO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWBXSFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:05:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:13456
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932408AbWBXSFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:05:12 -0500
Date: Fri, 24 Feb 2006 10:04:52 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Missing piece from as659
Message-ID: <20060224180452.GA26821@kroah.com>
References: <20060224164901.GQ28587@parisc-linux.org> <Pine.LNX.4.44L0.0602241246150.5177-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602241246150.5177-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 12:53:01PM -0500, Alan Stern wrote:
> On Fri, 24 Feb 2006, Matthew Wilcox wrote:
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/2673.html
> > If it is a bug, of course.  It's not clear to me whether it's permissible
> > to call pci_dev_put under a spinlock or not.  That boils down to whether
> > kobject ->release methods can sleep or not.  That isn't documented in
> > Documentation/kobject.txt and I rather think it should be.
> 
> It is a bug, but it has been ignored up until recently.  Within the last 
> month or two, Greg added a might_sleep() call to put_device().  It 
> wouldn't hurt to do the same thing to kobject_put(), or maybe just 
> kobject_release().

kobject_put() will not necessarily sleep, it's only the device_put that
will, due to the locking in the driver core.

thanks,

greg k-h
