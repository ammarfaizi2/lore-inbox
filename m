Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTJFSbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTJFS31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:29:27 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:14753 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S262336AbTJFS3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:29:17 -0400
Date: Tue, 7 Oct 2003 00:01:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006183132.GD1788@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006160846.GA4125@us.ibm.com> <20031006173111.GA1788@in.ibm.com> <20031006173858.GA4403@kroah.com> <20031006180119.GC1788@in.ibm.com> <20031006180907.GA4611@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006180907.GA4611@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 11:09:07AM -0700, Greg KH wrote:
> On Mon, Oct 06, 2003 at 11:31:19PM +0530, Dipankar Sarma wrote:
> No.  My main point is that for every hotplug event (which is caused by a
> kobject being created or destroyed), udev will run and look at the sysfs
> entry for the kobject (by using libsysfs which reads in all of the
> kobject information, including attributes).  This is a normal event, so
> we have to care about what happens after running 'find' on the sysfs
> tree as that is basically what will always happen.
> 
> Does that make more sense?  We can't just look at what happens with this
> patch without actually accessing all of the sysfs tree, as that will be
> the "normal" case.

That sounds odd. So, udev essentially results in a frequent and continuous
"find /sys" ? That doesn't sound good. You are unnecessarily adding
pressure on vfs (dcache specially). We will discuss this offline then
and see what needs to be done.

> > > Can you show this happening?
> > 
> > It should be easy to demonstrate. That is how dentries/inodes
> > work for on-disk filesystems. If Maneesh's patch didn't work that
> > way, then the whole point is lost. I hope that is not the case.
> 
> Me too.  It's just that the free memory numbers didn't show much gain
> with this patch on his system.  That worries me.

Well, Maneesh didn't post numbers after letting the system age out
sysfs dentries/inodes. Maneesh can you post some such numbers ?


> > > But again, I don't think the added overhead you have added to a kobject
> > > is acceptable for not much gain for the normal case (systems without a
> > > zillion devices.)
> > 
> > IIRC, Maneesh test machine is a 2-way P4 xeon with six scsi disks and savings
> > are of about 800KB. That is as normal a case as it gets, I think.
> > It only gets better as you have more devices in your system.
> 
> 800Kb after running find?  I don't see that :)

No, those numbers were for just mounting sysfs. More numbers tomorrow.

Thanks
Dipankar
