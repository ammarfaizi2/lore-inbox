Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTJFUYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTJFUYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:24:41 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:26297 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S261684AbTJFUYi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:24:38 -0400
Date: Tue, 7 Oct 2003 01:56:56 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006202656.GB9908@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031006192713.GE1788@in.ibm.com> <Pine.LNX.4.44.0310061224230.985-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310061224230.985-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 12:33:19PM -0700, Patrick Mochel wrote:
> It's not a realistic requirement for me to solve your customer problems. 
> :) I've been involved in this argument before, and the arguments have been 
> the same, pretty much along party lines of IBM vs. Everyone else. I'm not 
> here to point fingers, but you must heed the fact that we've been here 
> before. 

Well, I didn't mention the c-word, Pat, you did :-) I would much
rather help figure out the best possible way to implement dentry/inode
ageing in sysfs.

> > Besides that think about the added complexity of lookups due to
> > all those pinned dentries forever residing in dentry hash table.
> 
> Well, along with more memory and more devices, I would expect your 
> customers to also be paying for the fastest processors. :) 

Again, more than customers, it is a question of DTRT.

> > sysfs currently uses dentries to represent filesystem hierarchy.
> > We want to create the dentries on the fly and age them out.
> > So, we can no longer use dentries to represent filesystem hierarchy.
> > Now, *something* has to represent the actual filesystem
> > hierarchy, so that dentries/inodes can be created on a lookup
> > miss based on that. So, what do you do here ? kobject and
> > its associates already represent most of the information necessary
> > for a backing store. 
> 
> I understand what you're trying to do, and I say it's the wrong approach. 
> You're overloading kobjects in a manner unintended, and in a way that is 
> not welcome. I do not have an alternative solution, but my last email gave 
> some hints of where to look. Don't get bitter because I disagree. 

The overloading kobject argument is much better. Gregkh has also
indicated that non-sysfs kobjects will increase. That definitely
puts things in a different perspective. Fair enough.

> > > You can also use the assumption that an attribute group exists for all the 
> > > kobjects in a kset, and that a kobject knows what kset it belongs to. And
> > > that eventually, all attributes should be added as part of an attribute 
> > > group..
> > 
> > As I said before, no matter how much you save on kobjects and attrs,
> > I can't see how you can account for ageing of dentries and inodes.
> > Please look at it from the VFS angle and see if there is a better
> > way to represent kobjects/attrs in order to create dentries/inodes
> > on demand and age later.
> 
> That's what I told you, only reversed - try again. The patch posted in 
> unacceptable, though I'm willing to look at alternatives. I don't have or 

Viro's suggestion of pinning the non-leaf dentries only seems like
a very good first alternative to try out.

> see a problem with the current situation, so your arguments are going to 
> have to be a bit stronger. 

By not pinning dentries, you save several hundreds of KBs of lowmem
in a common case low-end system with six disks, much reduced number of dentries
in the hash table and huge savings in large systems. I would hope that
is a good argument. Granted you don't like Maneesh's patch as it is now,
but those things will change as more feedbacks come in.

Thanks
Dipankar
