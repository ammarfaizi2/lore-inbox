Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUAVXjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUAVXjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:39:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:7642 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265071AbUAVXjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:39:01 -0500
Date: Thu, 22 Jan 2004 15:38:54 -0800
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm1
Message-ID: <20040122233854.GA16052@kroah.com>
References: <20040122013501.2251e65e.akpm@osdl.org> <20040122110342.A9271@infradead.org> <20040122151943.GW21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122151943.GW21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 03:19:43PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jan 22, 2004 at 11:03:42AM +0000, Christoph Hellwig wrote:
> > > sysfs-class-06-raw.patch
> > >   From: Greg KH <greg@kroah.com>
> > >   Subject: [PATCH] add sysfs class support for raw devices [06/10]
> > 
> > This one exports get_gendisk, which is a no-go.
> 
> Moreover, it obviously leaks references to struct gendisk _and_ changes
> semantics of RAW_SETBIND in incompatible way.
> 
> Consider that vetoed.  And yes, get_gendisk() issue alone would be enough.

Yes, I realize this patch isn't quite sane yet, that's why it's still in
the -mm tree :)

> Greg, please, RTFS to see at which point do we decide which driver will
> be used by raw device.  It's _not_ RAW_SETBIND, it's open().  So where
> your symlink should point is undecided until the same point.

I don't care about which driver is used by the raw device, I care about
which block device the raw device is "bound" to.  That happens at
RAW_SETBIND time, right?  We do this in the line:
	rawdev->binding = bdget(dev);

Hm, wait, are you saying that at open() time we actually bind the char
device to the block device, and that struct block_device can change
between RAW_SETBIND and open() time due to hotpluggable devices?

Or am I missing something else here?

thanks,

greg k-h
