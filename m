Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUAGR2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUAGR2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:28:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:11467 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265622AbUAGR1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:27:54 -0500
Date: Wed, 7 Jan 2004 09:27:50 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Inconsistency in sysfs behavior?
Message-ID: <20040107172750.GC31177@kroah.com>
References: <Pine.LNX.4.44L0.0401071039150.850-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0401071039150.850-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note, Pat's email address has changed, I've changed in the CC:

On Wed, Jan 07, 2004 at 10:48:44AM -0500, Alan Stern wrote:
> The following appears to be an inconsistency in the way sysfs behaves.  
> Tell me what you think...
> 
> When a user process parks its CWD in a kobject's sysfs directory and then
> the kobject is unregistered, of course the directory is forced to remain
> in existence (albeit unlinked) because of the reference held by the
> process.  But it does not in turn hold a reference to the kobject; the
> kobject will be deleted immediately if nothing else refers to it.
> 
> On the other hand, if a user process opens a sysfs attribute file and then
> sysfs_remove_file() is called, again the file is forced to remain in
> existence (albeit unlinked) because of the reference held by the process.  
> But now it _does_ hold a reference to the kobject; if the kobject is
> unregistered it will not be deleted until the user process closes the
> attribute file.
> 
> Why this non-parallel behavior?

Because it is very difficult to determine when a user goes into a
directory because we are using the ramfs/libfs code.  It also does not
cause any errors if the kobject is removed, as the vfs cleans up
properly.

Only when a file is opened does a kobject need to be pinned, due to
possible errors that could happen.

Hope this helps,

greg k-h
