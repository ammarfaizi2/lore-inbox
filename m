Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276204AbRJYUJi>; Thu, 25 Oct 2001 16:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274055AbRJYUJd>; Thu, 25 Oct 2001 16:09:33 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14092 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S276204AbRJYUJM>; Thu, 25 Oct 2001 16:09:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: corbet@lwn.net (Jonathan Corbet),
        Patrick Ouellet <patrick.ouellet@microtecsecurite.com>
Subject: Re: In great need
Date: Thu, 25 Oct 2001 22:10:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011025163450.706.qmail@eklektix.com>
In-Reply-To: <20011025163450.706.qmail@eklektix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011025200943Z16552-698+435@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 25, 2001 06:34 pm, Jonathan Corbet wrote:
> > Were should I start.
> 
> KernelNewbies.org is intended to be a starting place for kernel hackers.
> 
> May I also humbly suggest _Linux_Device_Drivers_?  It's online at 
> 
> 	http://www.xml.com/ldd/chapter/book/index.html
> 
> But, of course, you'll want to buy a copy at the bookstore of your choice
> as well :)

Yes, that's where I started.  Being somewhat impatient, I just flipped to 
chapter two, which has a 4 line example of a kernel module which I'll 
paraphrase here:

	#define MODULE
	#include <linux/module.h>

	int init_module(void) { printk("Hello kernel!\n"); return 0; }
	void cleanup_module(void) { printk("Goodbye kernel!\n"); }

Then I did (more or less):

	cc -c hello.c -I/usr/src/2.4.12/include	
	su
	insmod hello.o
	dmesg
	lsmod
	rmmod hello
	dmesg
	lsmod

So my first kernel hack took about 5 minutes, with the help of this book.  
Note: some of that 5 minutes was spent figuring out that kernel messages 
don't get printed to the console if you're running X, hence the dmesg's.

You'll have to update the example in the book - simply doing "cc -c hello.c" 
works only when the /usr/include/version.h happens to match your running 
kernel, which isn't very likely.[1]

The big advantage of starting with module programming is, you don't 
necessarily have to understand the entire kernel to get started - the 
interfaces available to modules tend to be easier to understand and work with 
than the other, often subtle and sparsely documented interfaces used 
internally by the kernel itself.

And yes, I do have to go out and get the 2nd edition of LDD, co-starring you 
:-)

[1] Because /usr/include/linux is no longer allowed to symlink to 
/usr/src/linux/include/linux.

--
Daniel
