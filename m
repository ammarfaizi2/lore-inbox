Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269027AbRHBRzL>; Thu, 2 Aug 2001 13:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269029AbRHBRzB>; Thu, 2 Aug 2001 13:55:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:20389 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269027AbRHBRyu>;
	Thu, 2 Aug 2001 13:54:50 -0400
Date: Thu, 2 Aug 2001 13:54:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <01080219261601.00440@starship>
Message-ID: <Pine.GSO.4.21.0108021347300.29563-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, Daniel Phillips wrote:

> I don't know why it is hard or inefficient to implement this at the VFS 
> level, though I'm sure there is a reason or this thread wouldn't 
> exist.  Stephen, perhaps you could explain for the record why sys_fsync 
> can't just walk the chain of dentry parent links doing fdatasync?  Does 
> this create VFS or Ext3 locking problems?  Or maybe it repeats work 
> that Ext3 is already supposed to have done?
 
Parent directory can be renamed. Which grandparent should we sync?
New one? Old one? Both? BTW, how about file itself getting renamed during
fsync()?

See the problem? And no, blocking all renames while fsync() happens is
not an answer - it's a DoS.
 
> [1] In Ext2, all filename dirents are "hard links", i.e., there is no 
> way to tell which of the two names is the original after creating a new 
> hard link.

s/Ext2/UNIX/.

