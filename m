Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTJFSln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTJFSln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:41:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:43741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264012AbTJFSlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:41:35 -0400
Date: Mon, 6 Oct 2003 11:34:05 -0700
From: Greg KH <greg@kroah.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006183403.GA6274@kroah.com>
References: <20031006085915.GE4220@in.ibm.com> <20031006160846.GA4125@us.ibm.com> <20031006173111.GA1788@in.ibm.com> <20031006173858.GA4403@kroah.com> <20031006180119.GC1788@in.ibm.com> <20031006180907.GA4611@kroah.com> <20031006183132.GD1788@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006183132.GD1788@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 12:01:32AM +0530, Dipankar Sarma wrote:
> On Mon, Oct 06, 2003 at 11:09:07AM -0700, Greg KH wrote:
> > On Mon, Oct 06, 2003 at 11:31:19PM +0530, Dipankar Sarma wrote:
> > No.  My main point is that for every hotplug event (which is caused by a
> > kobject being created or destroyed), udev will run and look at the sysfs
> > entry for the kobject (by using libsysfs which reads in all of the
> > kobject information, including attributes).  This is a normal event, so
> > we have to care about what happens after running 'find' on the sysfs
> > tree as that is basically what will always happen.
> > 
> > Does that make more sense?  We can't just look at what happens with this
> > patch without actually accessing all of the sysfs tree, as that will be
> > the "normal" case.
> 
> That sounds odd. So, udev essentially results in a frequent and continuous
> "find /sys" ? That doesn't sound good. You are unnecessarily adding
> pressure on vfs (dcache specially). We will discuss this offline then
> and see what needs to be done.

No, not a 'find', we look up the kobject that was added, and its
attributes.  Doing a 'find' will emulate this for your tests, that's
all.

thanks,

greg k-h
