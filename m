Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTITCq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 22:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTITCq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 22:46:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:12741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261309AbTITCq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 22:46:58 -0400
Date: Fri, 19 Sep 2003 19:47:12 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev
Message-ID: <20030920024712.GA9387@kroah.com>
References: <20030919231046.4626.qmail@lwn.net> <20030920012844.GD7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030920012844.GD7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 02:28:44AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> BTW, I suspect that we need a way to say "this kobject and its children
> will *never* have any attributes and will never be seen in sysfs".  There
> are quite a few uses when we keep kobject as a refcounting vehicle, etc.,
> but have nothing meaningful to show in sysfs tree.  Keep in mind that
> sysfs nodes (including attributes) are not free - it's struct inode +
> struct dentry at the very least.  Both pinned down and permanently mapped...

Hm, I've used them this way by just calling kobject_init, kobject_get
and kobject_put.  As long as you never call kobject_register or
kobject_add, the sysfs hookups never happen.

Is that what you are looking for?  

thanks,

greg k-h
