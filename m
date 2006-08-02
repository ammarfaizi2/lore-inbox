Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWHBVta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWHBVta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWHBVta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:49:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932243AbWHBVt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:49:29 -0400
Date: Wed, 2 Aug 2006 14:49:08 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: get_device in device_create_file
Message-Id: <20060802144908.3645e08a.zaitcev@redhat.com>
In-Reply-To: <200608012113.06191.dtor@insightbb.com>
References: <20060801132509.27269013.zaitcev@redhat.com>
	<200608012113.06191.dtor@insightbb.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 21:13:05 -0400, Dmitry Torokhov <dtor@insightbb.com> wrote:

> > > 	if (get_device(dev)) {
> > > 		error = sysfs_create_file(&dev->kobj, &attr->attr);
> > > 		put_device(dev);
> > > 	}

> > Buf it not, and the caller has a reference, then the call to
> > get_device is redundant.

> Yes it is. There are few of redundant gets and puts sprinkled around
> in the driver core, but the last time I mentioned that Greg was not
> quite ready to get rid of them ;)

I see a small, but nonzero harm from keeping them, for two reasons.
One, I reviewed a patch for RHEL-4 today, where the submitter copied
this code without thinking. So, if we don't flush these, they will
proliferate. Hackers assume that if Greg wrote that, it must be the
right way. Two, these calls shrink the race window and may be
masking something.

-- Pete
