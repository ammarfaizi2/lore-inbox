Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTKLQ3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTKLQ3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:29:24 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27024 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262674AbTKLQ3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:29:23 -0500
Date: Wed, 12 Nov 2003 21:57:40 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/5] Backing Store for sysfs (Overhauled)
Message-ID: <20031112162740.GA1776@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031112122344.GD14580@in.ibm.com> <20031112160015.GA28684@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112160015.GA28684@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 08:00:15AM -0800, Greg KH wrote:
> On Wed, Nov 12, 2003 at 05:53:44PM +0530, Maneesh Soni wrote:
> > 
> > The concept is still the same that in this prototype also we create dentry and 
> > inode on the fly when they are first looked up. This is done for both leaf or 
> > non-leaf dentries. The generic nature of sysfs_dirent makes it easy to do for 
> > both leaf or non-leaf dentries. 
> 
> What happens once a dentry and inode is created?  Is there any way for
> them to be forced out, or do they stay around in memory forever?

The idea atleast, is that if no one is using a dentry, it will
be put in the dentry lru list and eventually returned to the slab.
inodes too are returned alongwith. Just like how on-disk filesystems work.

Typically, an open() of a sysfs file would result in creation of the
corresponding dentry/inode and holding of the reference. close() releases
the reference. The last one to release puts the dentry in the lru list
for later pruning. The result is that we have less memory use and
smaller number of dcache hash table elements under normal circumstances.

THanks
Dipankar
