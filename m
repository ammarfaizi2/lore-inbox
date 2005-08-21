Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVHUJCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVHUJCi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVHUJCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:02:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750876AbVHUJCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:02:37 -0400
Date: Sun, 21 Aug 2005 02:01:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: zero-copy read() interface
Message-Id: <20050821020103.28a6b887.akpm@osdl.org>
In-Reply-To: <20050818104131.GH12313@vanheusden.com>
References: <20050818100151.GF12313@vanheusden.com>
	<20050818100536.GB16751@wohnheim.fh-wedel.de>
	<20050818104131.GH12313@vanheusden.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden <folkert@vanheusden.com> wrote:
>
> > > What about a zero-copy read-interface?
> > > An ioctl (or something) which enables the kernel to do dma directly to
> > > the userspace. Of course this should be limited to the root-user or a
> > > user with special capabilities (rights) since if a drive screws up, data
> > > from a different sector (or so) might end up in the proces' memory. Of
> > > course copying a sector from kernel- to userspace can be done pretty
> > > fast but i.m.h.o. all possible speedimprovements should be made unless
> > > unclean.
> > Just use mmap().  Unlike your proposal, it cooperates with the page
> > cache.
> 
> Doesn't that one also use copying? I've also heard that using mmap is
> expensive due to pagefaulting. I've found, for example, that copying a
> 1.3GB file using read/write instead of mmap & memcpy is seconds faster.
> 

You can use remap_file_pages() to read all the pages into pagecache and
then instantiate all their pte's in a single syscall.
