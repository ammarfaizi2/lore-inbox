Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTJFQJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTJFQJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:09:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10237 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262373AbTJFQJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:09:14 -0400
Date: Mon, 6 Oct 2003 09:08:46 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006160846.GA4125@us.ibm.com>
References: <20031006085915.GE4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006085915.GE4220@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test6-bk5 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 02:29:15PM +0530, Maneesh Soni wrote:
> 
> 				2.6.0-test6		With patches.
> -----------------
> dentry_cache (active)		2520			2544
> inode_cache (active)		1058			1050
> LowFree			875032 KB		874748 KB

So with these patches we actually eat up more LowFree if all sysfs
entries are searched, and make the dentry_cache bigger?  That's not good :(

Remember, every kobject that's created will cause a call to
/sbin/hotplug which will cause udev to walk the sysfs tree to get the
information for that kobject.  So I don't see any savings in these
patches, do you?

thanks,

greg k-h
