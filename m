Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbTJJQEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTJJQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:02:47 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55691 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262817AbTJJQCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:02:01 -0400
Date: Fri, 10 Oct 2003 17:01:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010160144.GI28795@mail.shareable.org>
References: <20031010122755.GC22908@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org> <20031010152710.GA28773@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010152710.GA28773@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> 	Where I work doesn't change the need for O_DIRECT.  If your Big
> App has it's own cache, why copy the cache in the kernel?  That just
> wastes RAM.

Why don't you _share_ the App's cache with the kernel's?  That's what
mmap() and remap_file_pages() are for.

>  If your app is sharing data, whether physical disk, logical
> disk, or via some network filesystem or storage device, you must
> absolutely guarantee that reads and writes hit the storage, not the
> kernel cache which has no idea whether another node wrote an update or
> needs a cache flush.

That's tough to guarantee at the platter level regardless of O_DIRECT,
but otherwise: you have fdatasync() and msync().

> If Linux came up with a better, cleaner method, Oracle might change.

Take a look at remap_file_pages() and write a note here to say if it
fits the bill.  I thought remap_file_pages() was added for Oracle, but
perhaps it was for a more modern database ;)

Thanks,
-- Jamie
