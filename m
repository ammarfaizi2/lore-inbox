Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSGGUgR>; Sun, 7 Jul 2002 16:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316571AbSGGUgQ>; Sun, 7 Jul 2002 16:36:16 -0400
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:18752 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316569AbSGGUgP>; Sun, 7 Jul 2002 16:36:15 -0400
Posted-Date: Sun, 7 Jul 2002 20:38:23 GMT
Date: Sun, 7 Jul 2002 21:38:23 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <Pine.LNX.4.44.0206041428080.983-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0207072125260.9595-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

> You can do it with direct disk access and knowledge of the FS
> internals, but it should not be all that hard to add some simple
> interface to get a "block usage byte array" kind of thing (more
> efficient than doing bmap on all files, _and_ can tell about blocks
> reserved for inodes, superblocks and other special uses), which
> together with a user-level interface to "preallocate" and your
> "relocate page" should actually make it possible to make a fairly
> FS-independent defragmenter.

Would I be right in thinking that this would be an array with three
possible values for each element...

	FIXED		Block not movable.
	MOVABLE		Block in use and movable.
	UNUSED		Block not in use.

...with the defragmenter basically exchanging MOVABLE and UNUSED blocks
to get the files in an unfragmented state. The FIXED value would handle
things like the superblock, inode blocks and other special uses, and all
other blocks would be either MOVABLE or UNUSED as appropriate.

Another option might be to split MOVABLE into DIRECTORY and FILE values
instead, but whether that would be useful is questionable at best.

> Add a nice graphical front-end, and you can make it a useful
> screen-saver.

As long as it runs on systems without X-windows available rather than
being limited to only run under X... My preference would be for a tool
similar to `make menuconfig` for this sort of utility.

Best wishes from Riley.

