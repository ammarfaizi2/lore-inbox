Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSJQUOk>; Thu, 17 Oct 2002 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262108AbSJQUOk>; Thu, 17 Oct 2002 16:14:40 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:49417 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S262107AbSJQUOi>;
	Thu, 17 Oct 2002 16:14:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Date: Thu, 17 Oct 2002 22:20:21 +0200
User-Agent: KMail/1.4.3
Cc: linux-security-module@wirex.com
References: <20021017195015.A4747@infradead.org> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com>
In-Reply-To: <20021017190723.GB32537@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210172220.21458.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002 21:07, Greg KH wrote:
> On Thu, Oct 17, 2002 at 07:58:38PM +0100, Christoph Hellwig wrote:
> > > Yes, it's a big switch, but what do you propose otherwise?  SELinux
> > > would need a _lot_ of different security calls, which would be fine,
> > > but we don't want to force every security module to try to go through
> > > the process of getting their own syscalls.
> >
> > They should register their syscalls with the kernel properly. Look
> > at what e.g. the streams people did after the sys_call_table
> > removal.  It's enough that IRIX suffers from the syssgi syndrome, no
> > need to copy redo their mistakes in Linux.
>
> Hm, as I'm not a SELinux developer, I can't tell you how many different
> syscalls they need, or what they are for, sorry.

I'm not involved with the kernel coding, but I've been doing quite a bit of 
user-land SE Linux development (and the first cut at strace support).

SE Linux has currently 52 system calls.  One system call was added recently, 
and other system calls may need to be added.  SE Linux is still in a state of 
development.

Now if every SE system call was to be a full Linux system call then LANANA 
would be involved in the discussions every time that a new SE call was added, 
which would not be desired by the SE Linux people or the LANANA people.  So 
this means having a switch statement for the different SE calls.

So if we accept that it's a maximum of one system call per security module, 
then it's only a small step to do the same for LSM.

Do we expect that SE Linux or other security system calls will be such a 
performance bottleneck that an extra switch or two will hurt?

> But this will require every security module project to petition for a
> syscall, which would be a pain, and is the whole point of having this
> sys_security call.

Also it would mean that developmental projects would be more difficult.  If 
you are doing some experimental coding that's not ready for release then 
there might be a number of kernels released during the development cycle 
before you petition for a number.  In this case you may be forced to change 
the syscall number if someone else gets the number you were working with.
Then when we share patches of experimental software there will be issues of 
syscall conflicts.  With the current LSM setup of a 2^32 LSM calls, you can 
choose a number somewhat arbitarily and be fairly sure that it won't conflict 
and that you can later register the same number with the LSM people.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

