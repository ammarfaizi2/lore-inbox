Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSIIIqa>; Mon, 9 Sep 2002 04:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSIIIqa>; Mon, 9 Sep 2002 04:46:30 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:26588 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316673AbSIIIq3>; Mon, 9 Sep 2002 04:46:29 -0400
Message-Id: <5.1.0.14.2.20020909092430.00b14460@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 09 Sep 2002 09:51:56 +0100
To: Daniel Phillips <phillips@arcor.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK-PATCH 1/3] Introduce fs/inode.c::ilookup().
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
In-Reply-To: <E17oGD2-0006lI-00@starship>
References: <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
 <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:25 08/09/02, Daniel Phillips wrote:
>On Saturday 07 September 2002 16:27, Anton Altaparmakov wrote:
> > Linus,
> >
> > This is the first of three patches implementing ilookup(), a function
> > to search the inode cache for an inode and if not found just return NULL.
> >
> > All response about ilookup() / ilookup5() was positive and several
> > file systems would like to have such a function available.
>
>Well, one person thought it should be called ifind.

Yes, you did. But that is too confusing with find_inode and friends IMHO 
and lookups are often termed _lookup and not _find, e.g. 
radix_tree_lookup(), simple_lookup(), d_lookup(), path_lookup(), 
cached_lookup()...

Whereas there is not a single function in fs/ or mm/ ending in _find... 
They are all called find_blah and find_inode already exists... Having both 
find_inode and inode_find aka ifind seems weird, at least to me...

There was another suggestion on #kernel and that was to do:

s/ilookup/ilookup_fast/
s/ilookup5/ilookup/

But if we do that we might as well carry on and also do:

s/iget_locked/iget_locked_fast/
s/iget5_locked/iget_locked/

And another one was:

s/ilookup5/ilookup_hash/

and by extension / for consistency one could add:

s/iget5_locked/iget_hash_locked/
s/find_inode/find_inode_hash/
s/find_inode_fast/find_inode/
s/get_new_inode_fast/get_new_inode/
s/get_new_inode/get_new_inode_hash/

How about those? I still like ilookup at the beginning, or inode_lookup...

Best regards,

         Anton


-- 
   "I haven't lost my mind... it's backed up on tape." - Peter da Silva
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

