Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTKLRAR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTKLRAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:00:17 -0500
Received: from willden.org ([63.226.98.113]:16559 "EHLO zedd.willden.org")
	by vger.kernel.org with ESMTP id S263886AbTKLRAL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:00:11 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: linux-kernel@vger.kernel.org
Subject: What's the best way to instrument a driver?
Date: Wed, 12 Nov 2003 10:00:09 -0700
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200311121000.09229.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please excuse the newbie questions here, and feel free to slap me around if 
this is all in some googlable documentation that I haven't been able to 
find:

I need to instrument a driver (currently, a usb device, but I'll probably 
want to do others later, so my question is a bit more general than the 
current need) so that I can see everything that is being sent through.  I 
can think of several ways to go about this, but I thought it might be a 
good idea to ask what would be the simplest/most flexible.

>From what I can see there are two basic approaches:  kernel space and 
userspace.

Since what I want to watch right now is just the data flowing to/from a 
particular USB device, it seems like I could probably just wrap something 
around the appropriate /proc/bus/usb/... file.  Could I create a named 
pipe or something and use that?  Would I be able to see and pass ioctls if 
I did it that way?  Another problem is figuring out a way to convince the 
closed source app I'm trying to watch to use my wrapper file, rather than 
the real one.  Any ideas?

If userspace can't work, then I see a couple of kernel space options:

The first is to create a new "passthrough" device that can wrap another 
device and direct a copy of whatever passes through out to user space.  
The other, less pleasant, alternative is to simply hack driver (usb.c in 
this case, I think) and fill it full of printks.  I don't like that as 
well because it will require me to understand a significant part of the 
driver implementation, which will take time.  Also, all of the data for 
all usb devices passes through that driver, so I'd have to figure out how 
to separate out the data that I care about.

Finally, assuming I end up with a kernel space implementation, what is the 
best way to move the data to userspace?  printk is certainly easy, but I 
understand it has a small buffer.  I suppose it's probably easy to find 
the buffer and increase it.  Is there a better way?

Thanks for any suggestions,

Shawn.
