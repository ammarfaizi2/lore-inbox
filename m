Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbUCLX2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUCLX2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:28:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:28395 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263036AbUCLX0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:26:01 -0500
Date: Fri, 12 Mar 2004 15:25:44 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] cdev 2/2: hide cdev->kobj
Message-ID: <20040312232544.GB16623@kroah.com>
References: <20040312183329.1438.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312183329.1438.qmail@lwn.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 11:33:29AM -0700, Jonathan Corbet wrote:
> The existing cdev interface requires users to deal with the embedded
> kobject in two places:
> 
> - The kobject name field must be set before adding the cdev, and
> - Should cdev_add() fail, a call to kobject_put() is required.
> 
> IMO, this exposure of the embedded kobject makes the interface more brittle
> and harder to understand.  It's also unnecessary.  With the removal of
> /sys/cdev, a call to cdev_del() will nicely replace kobject_put(), and the
> name setting is easily wrapped.
> 
> This is against 2.6.4, but depends on the /sys/cdev removal patch.

I've also applied this and it works for me.

But do we really even need this anymore?  The only reason the name was
even semi-important was that we were actually putting the kobject into
sysfs.  Now that we are not doing that, it isn't needed.  In fact I am
now running with a simple:
	#define cdev_set_name(cdev, args...)
in cdev.h to verify this.

Anyone object to me just deleting cdev_set_name() and everywhere it is
now used entirely?

thanks,

greg k-h
