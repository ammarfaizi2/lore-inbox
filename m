Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRC3Jo7>; Fri, 30 Mar 2001 04:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbRC3Jou>; Fri, 30 Mar 2001 04:44:50 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:36936 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131246AbRC3Joh>; Fri, 30 Mar 2001 04:44:37 -0500
Date: Fri, 30 Mar 2001 03:43:46 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
   Jamey Hicks <jamey@crl.dec.com>, Stephen L Johnson <sjohnson@monsters.org>
Subject: Re: Memory leak in the ramfs file system
In-Reply-To: <022101bfd4af$dbb068c0$bba6b3d0@Toshiba>
Message-ID: <Pine.LNX.3.96.1010330034105.8826E-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2000, Jaswinder Singh wrote:
> > What does /proc/slabinfo say? The most likely leak is a dentry leak or
> > an inode leak, and both of those should be fairly easy to see in the
> > slab info (dentry_cache and inode_cache respectively).
> >
> 
> I am attaching details before and during  my application .
> 
> Mainly changes are in dentry_cache and inode_cache , but i am attaching
> whole /proc/slabinfo for your reference.

Would it be possible for you to attached a 'before' picture of slabinfo,
as well as 'after'?

> > Obviously, it could be a data page leak too, but such a leak should be
> > easy to see by creating a few big files and deleting them..
> >
> > Linus
> 
> I am also facing one more problem with ramfs.
> 
> du and df shows 0 , so i am also attaching its output.

I don't recall how du works exactly... if it uses stat(2), it should not
be broken AFAIK.

As for 'df', that will definitely show zero, because ramfs does not do
filesystem accounting in its present form.  You might consider trying a
modified version of ramfs, as found in Alan Cox's 'ac' patchkit.  This
patchkit includes a modified ramfs which supports limiting filesystem
size, but more importantly (for you), it should make 'df' work again.

	Jeff




