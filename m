Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286262AbSAGUVv>; Mon, 7 Jan 2002 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286381AbSAGUVm>; Mon, 7 Jan 2002 15:21:42 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:21520 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286262AbSAGUV2>; Mon, 7 Jan 2002 15:21:28 -0500
Message-ID: <3C3A020D.49865BB8@zip.com.au>
Date: Mon, 07 Jan 2002 12:16:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <200201071904.g07J4Wf02751@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.33.0201071119520.28000-100000@segfault.osdlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> 
> ...
> "What do you mean, 'don't use proc'?" (Since I already had done it).
> 
> He pointed out that it was old and crufty, and already over-abused. He
> suggested that I write my own fs to do it.
> 
> So I did. It was easy. I blatantly ripped off ramfs, and it worked.
> 

One little problem I have with driverfs (and with the whole "everything
is a filesystem" idea) is that the infrastructure just isn't ready for
it yet.

For example, driverfs_create_dir().  That has no driverfs-specific
content at all.  It's 100% mucking with VFS internals.

The more cut-n-paste-filesystems we create, the harder it all gets
to maintain.  We need a library layer which simplifies and abstracts
these operations.  (Says me, looking at you-know-who :)

-
