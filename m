Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWKGL7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWKGL7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbWKGL7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:59:13 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:40402 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754202AbWKGL7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:59:11 -0500
Date: Tue, 7 Nov 2006 14:58:57 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [take21 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061107115857.GB13028@2ka.mipt.ru>
References: <11619654014077@2ka.mipt.ru> <45506D51.30604@garzik.org> <45507232.7010104@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45507232.7010104@garzik.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 07 Nov 2006 14:59:00 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 06:46:58AM -0500, Jeff Garzik (jeff@garzik.org) wrote:
> At an aside...  This may be useful.  Or not.
> 
> Al Viro had an interesting idea about kernel<->userspace data passing 
> interfaces.  He had suggested creating a task-specific filesystem 
> derived from ramfs.  Through the normal VFS/VM codepaths, the user can 
> easily create [subject to resource/priv checks] a buffer that is locked 
> into the pagecache.  Using mmap, read, write, whatever they prefer. 
> Derive from tmpfs, and the buffers are swappable.

It looks like Al likes filesystems more than any other part of kernel
tree...
Existing ring buffer is created in process' memory, so it is swappable
too (which is probably the most significant part of this ring buffer 
version), but in theory kevent file descriptor can be obtained not from
the char device, but from special filesystem (well, it was done in that
way in first releases but then I was asked to remove such
functionality).

> Then it would be a simple matter to associate a file stored in 
> "keventfs" with a ring buffer guaranteed to be pagecache-friendly.
> 
> Heck, that might make zero-copy easier in some cases, too.  And using a 
> filesystem would mean that you could do all this without adding 
> syscalls, by using special (poll-able!) files in the filesystem for 
> control and notification purposes.

There are too many ideas about networking zero-copy both sending and
receiving, and some of them are even implemented on different layers
(starting from special allocator down to splice() with additional
single allocation/copy).

> 	Jeff

-- 
	Evgeniy Polyakov
