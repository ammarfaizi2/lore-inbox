Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136092AbRD0PrM>; Fri, 27 Apr 2001 11:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136091AbRD0PrC>; Fri, 27 Apr 2001 11:47:02 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:30982 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S136097AbRD0Pqv>; Fri, 27 Apr 2001 11:46:51 -0400
Date: Fri, 27 Apr 2001 16:31:05 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Padraig Brady <padraig@antefacto.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <3AE99CE8.BD325F52@antefacto.com>
Message-ID: <Pine.LNX.3.96.1010427162631.4416A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Padraig Brady wrote:
> for a partition. If I understand correctly ramfs just points
> to the file data which are pages in the cache marked not to be

It does not even do that - as of 2.4, the VFS in the kernel also knows how
to cache a filestructure itself. It's in the dentry-cache. So ramfs just
provides the thin mapping between VFS operations and the VFS caches
(dentries, inodes, pages) like any other 2.4 filesystem - with the
difference that ramfs does not need to know anything about actually
transferring the cache entries to a backing store (a physical filesystem).

Take a look at fs/ramfs/inode.c, it's just some hundred odd lines of
code and worth reading to find out more about how 2.4's VFS works.

> uncached. Doh! is ramfs supported in 2.2?

Don't think so, for the above reason.

-BW

