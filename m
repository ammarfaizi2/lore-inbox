Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTJFT64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbTJFT64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:58:56 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:61637 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S261656AbTJFT6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:58:53 -0400
Date: Tue, 7 Oct 2003 01:31:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Patrick Mochel <mochel@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006200110.GA9908@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <Pine.LNX.4.44.0310061123110.985-100000@localhost.localdomain> <20031006192713.GE1788@in.ibm.com> <20031006193050.GT7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006193050.GT7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 08:30:50PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Oct 07, 2003 at 12:57:13AM +0530, Dipankar Sarma wrote:
> > sysfs currently uses dentries to represent filesystem hierarchy.
> > We want to create the dentries on the fly and age them out.
> > So, we can no longer use dentries to represent filesystem hierarchy.
> > Now, *something* has to represent the actual filesystem
> > hierarchy, so that dentries/inodes can be created on a lookup
> > miss based on that. So, what do you do here ? kobject and
> > its associates already represent most of the information necessary
> > for a backing store. Maneesh just added a little more to complete
> > what is equivalent of a on-disk filesystem. This allows vfs to
> > create dentries and inodes on the fly and age later on. Granted
> > that there are probably ugliness in the design to be sorted out
> > and it may have taken kobjects in a slightly different direction
> > than earlier, but it is not that odd when you look at it
> > from the VFS point of view.
> 
> Rot.  First of all, *not* *all* *kobjects* *are* *in* *sysfs*.  And these
> are pure loss in your case.

gregkh pointed out this as well and that is why I said that Maneesh's
patch may have taken kobjects in a different direction than what
it was intended earlier. I don't disagree with this and it may
very well be that dentry ageing will have to be done differently.

> 
> What's more important, for leaves of the sysfs tree your overhead is also
> a loss - we don't need to pin dentry down for them even with current sysfs
> design.   And that can be done with minimal code changes and no data changes
> at all.  Your patch will have to be more attractive than that.  What's the
> expected ratio of directories to non-directories in sysfs?

ISTR, a large number of files in sysfs are attributes which are leaves.
So, keeping a kobject tree partially connected using dentries as backing 
store as opposed to having everything connected might just be enough.
It will be looked into.

Thanks
Dipankar
