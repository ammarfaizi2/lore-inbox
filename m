Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTJJQdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTJJQdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:33:20 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:8408 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S263055AbTJJQdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:33:17 -0400
Date: Fri, 10 Oct 2003 09:33:00 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010163300.GC28773@ca-server1.us.oracle.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031010122755.GC22908@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org> <20031010152710.GA28773@ca-server1.us.oracle.com> <20031010160144.GI28795@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010160144.GI28795@mail.shareable.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 05:01:44PM +0100, Jamie Lokier wrote:
> Why don't you _share_ the App's cache with the kernel's?  That's what
> mmap() and remap_file_pages() are for.

	Because you can't force flush/read.  You can't say "I need you
to go to disk for this."  If you do, you're doing O_DIRECT through mmap
(yes, I've pondered it) and you end up with perhaps the same races folks
worry about.  Doesn't mean it can't be done.

> That's tough to guarantee at the platter level regardless of O_DIRECT,
> but otherwise: you have fdatasync() and msync().

	Platter level doesn't matter.  Storage access level matters.
Node1 and Node2 have to see the same thing.  As long as I am absolutely
sure that when Node1's write() returns, any subsequent read() on Node2
will see the change (normal barrier stuff, really), it doesn't matter
what happend on the Storage.  The data could be in storage cache, on
platter, passed back to some other entity.

> Take a look at remap_file_pages() and write a note here to say if it
> fits the bill.  I thought remap_file_pages() was added for Oracle, but
> perhaps it was for a more modern database ;)

	remap_file_pages() was indeed somethign Oracle wanted, but as a
way to create 8GB shmfs files and map them into the x86 crappy address
space.  It still does not have the ability to force reads and writes to
the storage, and it even has other issues.

Joel

-- 

Life's Little Instruction Book #511

	"Call your mother."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
