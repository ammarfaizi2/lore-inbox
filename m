Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRAIMJB>; Tue, 9 Jan 2001 07:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAIMIv>; Tue, 9 Jan 2001 07:08:51 -0500
Received: from linuxcare.com.au ([203.29.91.49]:48397 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129632AbRAIMIr>; Tue, 9 Jan 2001 07:08:47 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Tue, 9 Jan 2001 22:08:10 +1100
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarking 2.2 and 2.4 using hdparm and dbench 1.1
Message-ID: <20010109220810.K662@linuxcare.com>
In-Reply-To: <20010105004644.K13759@linuxcare.com> <Pine.LNX.4.21.0101041940490.5827-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0101041940490.5827-100000@svea.tellus>; from tori@tellus.mine.nu on Thu, Jan 04, 2001 at 07:55:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Where is the size defined, and is it easy to modify?

Look in fs/buffer.c:buffer_init()

> I noticed that /proc/sys/vm/freepages is not writable any more.  Is there
> any reason for this?

I am not sure why.

> Hmm...  I'm still using samba 2.0.7.  I'll try 2.2 to see if it
> helps.  What are tdb spinlocks?

samba 2.2 uses tdb which is an SMP safe gdbm like database. By default it
uses byte range fcntl locks to provide locking, but has the option of
using spinlocks (./configure --with-spinlocks). I doubt it would make
a difference on your setup.

> Have you actually compared the same setup with 2.2 and 2.4 kernels and a
> single client transferring a large file, preferably from a slow server
> with little memory?  Most samba servers that people benchmark are fast
> computers with lots of memory.  So far, every major kernel upgrade has
> given me a performance boost, even for slow computers, and I would hate to
> see that trend break for 2.4...

I havent done any testing on slow hardware and the high end stuff is
definitely performing better in 2.4, but I agree we shouldn't forget
about the slower stuff.

Narrowing down where the problem is would help. My guess is it is a TCP
problem, can you check if it is performing worse in your case? (eg ftp
something against 2.2 and 2.4)

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
