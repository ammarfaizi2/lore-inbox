Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUAWAYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 19:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUAWAYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 19:24:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31956 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266490AbUAWAYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 19:24:15 -0500
Date: Fri, 23 Jan 2004 00:24:14 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm1
Message-ID: <20040123002414.GA21151@parcelfarce.linux.theplanet.co.uk>
References: <20040122013501.2251e65e.akpm@osdl.org> <20040122110342.A9271@infradead.org> <20040122151943.GW21151@parcelfarce.linux.theplanet.co.uk> <20040122233854.GA16052@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122233854.GA16052@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 03:38:54PM -0800, Greg KH wrote:
> On Thu, Jan 22, 2004 at 03:19:43PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > Greg, please, RTFS to see at which point do we decide which driver will
> > be used by raw device.  It's _not_ RAW_SETBIND, it's open().  So where
> > your symlink should point is undecided until the same point.
> 
> I don't care about which driver is used by the raw device, I care about
> which block device the raw device is "bound" to.  That happens at
> RAW_SETBIND time, right?  We do this in the line:
> 	rawdev->binding = bdget(dev);

No.  We have no fscking idea what device it is.  All we know is a device
number.  No driver-related activity (including insmod, etc.) happens
until open().

Among other things, RAW_SETBIND on inexistent device is a legitimate use.
Which kills your "create a symlink at RAW_SETBIND" immediately - there
might very well be nothing for it to point to.

You can bind /dev/raw0 to 8:0, then attach USB disk and then open
/dev/raw0.  That ends up with /dev/raw0 becoming a raw alias for
that disk.
