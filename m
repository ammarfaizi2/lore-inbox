Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTJFTa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbTJFTa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:30:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36754 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261427AbTJFTa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:30:56 -0400
Date: Mon, 6 Oct 2003 20:30:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006193050.GT7665@parcelfarce.linux.theplanet.co.uk>
References: <20031006085915.GE4220@in.ibm.com> <Pine.LNX.4.44.0310061123110.985-100000@localhost.localdomain> <20031006192713.GE1788@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006192713.GE1788@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 12:57:13AM +0530, Dipankar Sarma wrote:
 
> Let's look at it this way - unless you find a way to save sizeof(struct dentry)
> + sizeof(struct inode) in every kobject/attr etc., there is no
> way you can beat ageing of dentries/inodes.
 
> sysfs currently uses dentries to represent filesystem hierarchy.
> We want to create the dentries on the fly and age them out.
> So, we can no longer use dentries to represent filesystem hierarchy.
> Now, *something* has to represent the actual filesystem
> hierarchy, so that dentries/inodes can be created on a lookup
> miss based on that. So, what do you do here ? kobject and
> its associates already represent most of the information necessary
> for a backing store. Maneesh just added a little more to complete
> what is equivalent of a on-disk filesystem. This allows vfs to
> create dentries and inodes on the fly and age later on. Granted
> that there are probably ugliness in the design to be sorted out
> and it may have taken kobjects in a slightly different direction
> than earlier, but it is not that odd when you look at it
> from the VFS point of view.

Rot.  First of all, *not* *all* *kobjects* *are* *in* *sysfs*.  And these
are pure loss in your case.

What's more important, for leaves of the sysfs tree your overhead is also
a loss - we don't need to pin dentry down for them even with current sysfs
design.   And that can be done with minimal code changes and no data changes
at all.  Your patch will have to be more attractive than that.  What's the
expected ratio of directories to non-directories in sysfs?
