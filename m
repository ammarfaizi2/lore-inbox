Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWHBBNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWHBBNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 21:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWHBBNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 21:13:09 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:37813 "EHLO
	asav14.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750930AbWHBBNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 21:13:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KADqZz0SBUg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: get_device in device_create_file
Date: Tue, 1 Aug 2006 21:13:05 -0400
User-Agent: KMail/1.9.3
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
References: <20060801132509.27269013.zaitcev@redhat.com>
In-Reply-To: <20060801132509.27269013.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012113.06191.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 16:25, Pete Zaitcev wrote:
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

*nod*

> Buf it not, and the caller has a reference, then the call to
> get_device is redundant.
>

Yes it is. There are few of redundant gets and puts sprinkled around
in the driver core, but the last time I mentioned that Greg was not
quite ready to get rid of them ;)
 

-- 
Dmitry
