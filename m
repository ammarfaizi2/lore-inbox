Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282276AbRKWW5D>; Fri, 23 Nov 2001 17:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282278AbRKWW4w>; Fri, 23 Nov 2001 17:56:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62392 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282276AbRKWW4o>;
	Fri, 23 Nov 2001 17:56:44 -0500
Date: Fri, 23 Nov 2001 17:56:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: war <war@starband.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15 + fs corruption.
In-Reply-To: <3BFED1A2.A0E41B04@starband.net>
Message-ID: <Pine.GSO.4.21.0111231750590.2422-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Nov 2001, war wrote:

> Is 2.4.15 ok to use?
> Many people are experiencing filesystem corruption?
> 
> As long as you patch the kernel with Al Viro's patch it should be ok,
> right?

In theory.  Again, as a workaround - sync before umount (and don't boot
unpatched 2.4.15/2.4.15-pre9 again, obviously).

Breakage happens when you umount filesystem (_any_ local filesystem, be
it ext2, reiserfs, whatever) that still has dirty inodes.

IOW, if you are running 2.4.15 - build a patched kernel, install it and
do the following:
	* switch to single-user
	* sync
	* umount everything non-buys
	* remount the rest read-only
	* turn the thing off
	* boot with patched kernel or with anything before 2.4.15-pre9

