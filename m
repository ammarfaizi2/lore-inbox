Return-Path: <linux-kernel-owner+w=401wt.eu-S1750705AbWLKXGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWLKXGV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWLKXGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:06:21 -0500
Received: from ns1.suse.de ([195.135.220.2]:32801 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbWLKXGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:06:20 -0500
Date: Mon, 11 Dec 2006 15:05:56 -0800
From: Greg KH <gregkh@suse.de>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       linux-usb-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: race in sysfs between sysfs_remove_file() and read()/write() #2
Message-ID: <20061211230556.GB4709@suse.de>
References: <20061204130406.GA2314@in.ibm.com> <Pine.LNX.4.44L0.0612041101410.3606-100000@iolanthe.rowland.org> <20061211104306.GA22628@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211104306.GA22628@in.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 04:13:06PM +0530, Maneesh Soni wrote:
> On Mon, Dec 04, 2006 at 11:06:41AM -0500, Alan Stern wrote:
> > On Mon, 4 Dec 2006, Maneesh Soni wrote:
> > 
> > > hmm, I guess Greg has to say the final word. The question is either to fail
> > > the IO (-ENODEV) or fail the file removal (-EBUSY). If we are not going to
> > > fail the removal then your patch is the way to go.
> > >
> > > Greg?
> > 
> > Oliver is right that we cannot allow device_remove_file() to fail.  In
> > fact we can't even allow it to block until all the existing open file
> > references are closed.
> > 
> > Our major questions have to do with the details of the patch itself.  In
> > particular, we are worried about possible races with the VFS and the
> > handling of the inode's usage count.  Can you examine the patch carefully
> > to see if it is okay?
> > 
> 
> Sorry for late reply.. I reviewed the patch and it looks ok me.

Thanks for the review.  Oliver, care to resend it to me so I can give it
some testing in the -mm tree?

thanks,

greg k-h
