Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSIIP5q>; Mon, 9 Sep 2002 11:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSIIP5q>; Mon, 9 Sep 2002 11:57:46 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:48829 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317402AbSIIP5p>;
	Mon, 9 Sep 2002 11:57:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK-PATCH 1/3] Introduce fs/inode.c::ilookup().
Date: Mon, 9 Sep 2002 18:04:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
References: <E17ngYk-00025C-00@storm.christs.cam.ac.uk> <5.1.0.14.2.20020909092430.00b14460@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020909092430.00b14460@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oR1i-0006pD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 10:51, Anton Altaparmakov wrote:
> At 17:25 08/09/02, Daniel Phillips wrote:
> >On Saturday 07 September 2002 16:27, Anton Altaparmakov wrote:
> > > Linus,
> > >
> > > This is the first of three patches implementing ilookup(), a function
> > > to search the inode cache for an inode and if not found just return NULL.
> > >
> > > All response about ilookup() / ilookup5() was positive and several
> > > file systems would like to have such a function available.
> >
> >Well, one person thought it should be called ifind.
> 
> Yes, you did. But that is too confusing with find_inode and friends IMHO 
> and lookups are often termed _lookup and not _find, e.g. 
> radix_tree_lookup(), simple_lookup(), d_lookup(), path_lookup(), 
> cached_lookup()...
> 
> Whereas there is not a single function in fs/ or mm/ ending in _find... 
> They are all called find_blah and find_inode already exists... Having both 
> find_inode and inode_find aka ifind seems weird, at least to me...

Why is ifind->find_inode weirder than  iget->__iget?

> There was another suggestion on #kernel and that was to do:
> 
> s/ilookup/ilookup_fast/
> s/ilookup5/ilookup/
> 
> But if we do that we might as well carry on and also do:
> 
> s/iget_locked/iget_locked_fast/
> s/iget5_locked/iget_locked/
> 
> And another one was:
> 
> s/ilookup5/ilookup_hash/
> 
> and by extension / for consistency one could add:
> 
> s/iget5_locked/iget_hash_locked/
> s/find_inode/find_inode_hash/
> s/find_inode_fast/find_inode/
> s/get_new_inode_fast/get_new_inode/
> s/get_new_inode/get_new_inode_hash/
> 
> How about those?

Unless we're planning to break with tradition completely it should be
isomething, where something E {find, lookup, search}.

On another front, hash desperately wants to be ihash.

-- 
Daniel
