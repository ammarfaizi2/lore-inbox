Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTIVQcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbTIVQcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:32:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:29401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263230AbTIVQcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:32:51 -0400
Date: Mon, 22 Sep 2003 09:29:20 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Jonathan Corbet <corbet@lwn.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev
In-Reply-To: <20030920012844.GD7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0309220926010.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BTW, I suspect that we need a way to say "this kobject and its children
> will *never* have any attributes and will never be seen in sysfs".  There
> are quite a few uses when we keep kobject as a refcounting vehicle, etc.,
> but have nothing meaningful to show in sysfs tree.  Keep in mind that
> sysfs nodes (including attributes) are not free - it's struct inode +
> struct dentry at the very least.  Both pinned down and permanently mapped...

There is already - use kobject_init() to initialize the refcount to 1, and 
kobject_put() to clean it up. (kobject_add() and kobject_del() can be used 
to later add/remove it from the sysfs hierarchy). 

Or, since those objects will probably never get added to sysfs, and since 
few objects are ever promoted, we may just want to create a new, smaller 
object purely for the refcounting vehicle.. 


	Pat

