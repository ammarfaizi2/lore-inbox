Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTJFTh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbTJFTh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:37:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:2270 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261503AbTJFThx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:37:53 -0400
Date: Mon, 6 Oct 2003 12:33:19 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
In-Reply-To: <20031006192713.GE1788@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0310061224230.985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That is not a very realistic argument, ia32 customers will likely
> run systems with large number of disks and will have lowmem problem.

It's not a realistic requirement for me to solve your customer problems. 
:) I've been involved in this argument before, and the arguments have been 
the same, pretty much along party lines of IBM vs. Everyone else. I'm not 
here to point fingers, but you must heed the fact that we've been here 
before. 

> Besides that think about the added complexity of lookups due to
> all those pinned dentries forever residing in dentry hash table.

Well, along with more memory and more devices, I would expect your 
customers to also be paying for the fastest processors. :) 

> I don't see how you can claim that the total overhead of the entire
> system is high. See Christian's numbers. The point here is pretty
> straightforward -

Uh, let's recap: 

" This ended up increasing the size of kobject from 52 bytes to 108 bytes
but saving one dentry and inode per kobject. " 

Under one usage model, you've saved memory, however under the case where 
kobjects are used and not represnted in sysfs, you've more than doubled 
the overhead, and you've increased the total overhead in the worst case - 
when all dentries are looked up and pinned. 

> sysfs currently uses dentries to represent filesystem hierarchy.
> We want to create the dentries on the fly and age them out.
> So, we can no longer use dentries to represent filesystem hierarchy.
> Now, *something* has to represent the actual filesystem
> hierarchy, so that dentries/inodes can be created on a lookup
> miss based on that. So, what do you do here ? kobject and
> its associates already represent most of the information necessary
> for a backing store. 

I understand what you're trying to do, and I say it's the wrong approach. 
You're overloading kobjects in a manner unintended, and in a way that is 
not welcome. I do not have an alternative solution, but my last email gave 
some hints of where to look. Don't get bitter because I disagree. 

> > You can also use the assumption that an attribute group exists for all the 
> > kobjects in a kset, and that a kobject knows what kset it belongs to. And
> > that eventually, all attributes should be added as part of an attribute 
> > group..
> 
> As I said before, no matter how much you save on kobjects and attrs,
> I can't see how you can account for ageing of dentries and inodes.
> Please look at it from the VFS angle and see if there is a better
> way to represent kobjects/attrs in order to create dentries/inodes
> on demand and age later.

That's what I told you, only reversed - try again. The patch posted in 
unacceptable, though I'm willing to look at alternatives. I don't have or 
see a problem with the current situation, so your arguments are going to 
have to be a bit stronger. 

Thanks,


	Pat


