Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbULCS5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbULCS5C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 13:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbULCS5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 13:57:01 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:20110 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262464AbULCS4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 13:56:45 -0500
Date: Fri, 3 Dec 2004 10:56:31 -0800
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: chrisw@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 2.6.10-rc2-bk15] sysfs_dir_close memory leak
Message-ID: <20041203185631.GA2913@kroah.com>
References: <20041202211932.I2357@build.pdx.osdl.net> <200412031105.iB3B5Kd05959@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412031105.iB3B5Kd05959@adam.yggdrasil.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 03:05:20AM -0800, Adam J. Richter wrote:
> Chris Wright wrote:
> >* Adam J. Richter (adam@yggdrasil.com) wrote:
> >> 	sysfs_dir_close did not free the "cursor" sysfs_dirent
> >> used for keeping track of position in the list of sysfs_dirent nodes.
> >> Consequently, doing a "find /sys" would leak a sysfs_dirent for
> >> each of the 1140 directories in my /sys tree, or about 36kB
> >> each time.
> 
> >Yeah, I noticed this as well.  Why the BUGON()?
> 
> 	My thinking was that the preconditions in my tree for
> calling release_sysfs_dirent are dirent->s_dentry == NULL and
> list_empty(&dirent->s_sibling).  The latter should be apparent
> from two lines above, but the former is less obvious, although
> it is also theoretically always true.
> 
> 	I'm OK with deleting the BUG_ON().  It was not verifying
> anything passed in by an outside caller.

Thanks, I've deleted the BUG_ON() and will be sending the patch on to
Linus in a bit.

(oh, care to add a "Signed-off-by:" line to your patches?)

thanks,

greg k-h
