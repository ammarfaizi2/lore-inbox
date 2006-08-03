Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWHCH5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWHCH5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWHCH5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:57:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:40167 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932388AbWHCH5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:57:03 -0400
Date: Thu, 3 Aug 2006 00:52:36 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: get_device in device_create_file
Message-ID: <20060803075236.GC28301@kroah.com>
References: <20060801132509.27269013.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801132509.27269013.zaitcev@redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 01:25:09PM -0700, Pete Zaitcev wrote:
> Hi, Greg:
> 
> This code makes no sense to me:
> 
> > int device_create_file(struct device * dev, struct device_attribute * attr)
> > {
> > 	int error = 0;
> > 	if (get_device(dev)) {
> > 		error = sysfs_create_file(&dev->kobj, &attr->attr);
> > 		put_device(dev);
> > 	}
> > 	return error;
> > }
> 
> If the struct device *dev, and its presumably enclosing structure,
> can be freed by a different CPU (or pre-empt), then get_device
> does not protect it. It can be freed before get_device is reached.
> Buf it not, and the caller has a reference, then the call to
> get_device is redundant.

Yes, it is redundant, sorry.  I know there are a few places that we
gratuitously grab references in the core that we don't really need to do
so.

It's interesting that someone would cut-and-paste from a driver core
file into something new.  What kind of code did they do that for?

Anyway, patches to clean this kind of stuff up is gladly accepted.

thanks,

greg k-h
