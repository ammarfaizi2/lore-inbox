Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTJFUdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTJFUdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:33:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:42642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261687AbTJFUdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:33:52 -0400
Date: Mon, 6 Oct 2003 13:29:20 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
In-Reply-To: <20031006202656.GB9908@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0310061321440.985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That's what I told you, only reversed - try again. The patch posted in 
> > unacceptable, though I'm willing to look at alternatives. I don't have or 
> 
> Viro's suggestion of pinning the non-leaf dentries only seems like
> a very good first alternative to try out.

Uh, that's about the same thing I suggested, though probably not as 
concisely: 

"As I said before, I don't know the right solution, but the directions to 
look in are related to attribute groups. Attributes definitely consume the 
most amount of memory (as opposed to the kobject hierachy), so delaying 
their creation would help, hopefully without making the interface too 
awkward. 

You can also use the assumption that an attribute group exists for all the 
kobjects in a kset, and that a kobject knows what kset it belongs to. And
that eventually, all attributes should be added as part of an attribute 
group.."

Attributes are the leaf entries, and they don't need to always exist. But, 
you have easy access to them via the attribute groups of the ksets the 
kobjects belong to. 

> > see a problem with the current situation, so your arguments are going to 
> > have to be a bit stronger. 
> 
> By not pinning dentries, you save several hundreds of KBs of lowmem
> in a common case low-end system with six disks, much reduced number of dentries
> in the hash table and huge savings in large systems. I would hope that
> is a good argument. Granted you don't like Maneesh's patch as it is now,
> but those things will change as more feedbacks come in.

A low-end system has six disks? I don't think so. Maybe a low-end server,
but of the dozen or so computers that I own, not one has six disks. Call 
me a techno-wimp, but I think your perspective is still a bit skewed. 

I understand your argument, but I still fail to see evidence that it's
really a problem. Perhaps you could characterize it a bit more and
convince us that sysfs overhead is really taking up a significant
percentage of the total overhead while running a set of common
applications with lots of open files (which should also be putting 
pressure on the same caches..) 

Thanks,


	Pat

