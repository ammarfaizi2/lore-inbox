Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUBGANa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUBGAN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:13:29 -0500
Received: from mail.shareable.org ([81.29.64.88]:18640 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266508AbUBGANX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:13:23 -0500
Date: Sat, 7 Feb 2004 00:13:17 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: avoiding dirty code pages with fixups
Message-ID: <20040207001317.GE12503@mail.shareable.org>
References: <20040203225453.GB18320@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203225453.GB18320@hexapodia.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> This is sorta like MAP_PRIVATE, but instead of writing the dirty
> page out to the swapfile, I want the page never to leave RAM.  If
> the kernel decides to evict the page, it should just drop it and
> invalidate the virtual address range.  When my program faults it
> back in, provide me with the contents of the page *as they exist in
> the backing file*.

That idea has come up about a thousand million times.  Well, three.
It's a good one :)

It has lots of uses, not just the one you describe.  For example,
cacheing generated image data.

It would also be nice for a memory allocator to be able to convert a
region from MAP_PRIVATE to MAP_SCRATCH and back, so that freed blocks
of memory can be reclaimed by the system but only when there is memory
pressure.

> The downside is the additional computation on page-in.

> It is a function of how many fixups there are per page, and of how
> much work ld.so does to satisfy a fixup.  I don't have a good feel
> for how expensive ld.so's fixup mechanism is... any comments?

The other downside of your idea is that every instance of a program
has more dirty pages.  While it is true that the pages do not require
disk I/O, they still take up RAM that could be used for other page
cache things.

-- Jamie
