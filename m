Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292082AbSBYSaB>; Mon, 25 Feb 2002 13:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292085AbSBYS3m>; Mon, 25 Feb 2002 13:29:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5012 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292082AbSBYS3d>;
	Mon, 25 Feb 2002 13:29:33 -0500
Date: Mon, 25 Feb 2002 13:28:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] Son of Unbork (1 of 3)
In-Reply-To: <E16ehbW-00008F-00@starship.berlin>
Message-ID: <Pine.GSO.4.21.0202251323160.3162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Feb 2002, Daniel Phillips wrote:

> Please tell me who wrote this:
> 
> struct super_operations {
>         struct inode *(*alloc_inode)(struct super_block *sb);
>         void (*destroy_inode)(struct inode *)

I had.  With inodes it _does_ provide things that can't be done
without these methods.  Namely, common allocation of generic and
fs-private part *on* *the* *fast* *path* *for* *class* *with*
*many* *instances*.

The latter parts are missing in case of superblocks.  We don't
allocate hundreds of thousands of superblocks.  Moreover, ones
allocated live much longer than normal struct inode.

IOW, common allocation is worthless in this case and that's the
only rationale for ->alloc_inode()/->destroy_inode().

