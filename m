Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVDEGmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVDEGmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVDEGmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:42:15 -0400
Received: from waste.org ([216.27.176.166]:26041 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261578AbVDEGmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:42:06 -0400
Date: Mon, 4 Apr 2005 23:41:53 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH] configfs, a filesystem for userspace-driven kernel object configuration
Message-ID: <20050405064153.GI25554@waste.org>
References: <20050403195728.GH31163@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403195728.GH31163@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 12:57:28PM -0700, Joel Becker wrote:
> Folks,
> 	I humbly submit configfs.  With configfs, a configfs
> config_item is created via an explicit userspace operation: mkdir(2).
> It is destroyed via rmdir(2).  The attributes appear at mkdir(2) time,
> and can be read or modified via read(2) and write(2).  readdir(3)
> queries the list of items and/or attributes.
> 	The lifetime of the filesystem representation is completely
> driven by userspace.  The lifetime of the objects themselves are managed
> by a kref, but at rmdir(2) time they disappear from the filesystem.
> 	configfs is not intended to replace sysfs or procfs, merely to
> coexist with them.
> 	An interface in /proc where the API is: 
> 
> 	# echo "create foo 1 3 0x00013" > /proc/mythingy
> 
> or an ioctl(2) interface where the API is:
> 
> 	struct mythingy_create {
> 		char *name;
> 		int index;
> 		int count;
> 		unsigned long address;
> 	}
> 
> 	do_create {
> 		mythingy_create = {"foo", 1, 3, 0x0013};
> 		return ioctl(fd, MYTHINGY_CREATE, &mythingy_create);
> 	}
> 
> becomes this in configfs:
> 
> 	# cd /config/mythingy
> 	# mkdir foo
> 	# echo 1 > foo/index
> 	# echo 3 > foo/count
> 	# echo 0x00013 > foo/address
> 
> 	Instead of a binary blob that's passed around or a cryptic
> string that has to be formatted just so, configfs provides an interface
> that's completely scriptable and navigable.

How does the kernel know when to actually create the object?

-- 
Mathematics is the supreme nostalgia of our time.
