Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263895AbRFIWv1>; Sat, 9 Jun 2001 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263907AbRFIWvR>; Sat, 9 Jun 2001 18:51:17 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:44306 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263895AbRFIWvO>; Sat, 9 Jun 2001 18:51:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [patch] truncate_inode_pages
Date: Sun, 10 Jun 2001 00:53:36 +0200
X-Mailer: KMail [version 1.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01061000533601.03897@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 June 2001 19:40, Alexander Viro wrote:
> > takes 45 seconds CPU time due to the O(clean * dirty) algorithm in
> > truncate_inode_pages().  The machine is locked up for the duration.
> > The patch reduces this to 20 milliseconds via an O(clean + dirty)
> > algorithm.
>
> Unfortunately, it's _not_ O(clean + dirty).
>
> > +		while (truncate_list_pages(&mapping->clean_pages, start,
> > &partial)) { +			spin_lock(&pagecache_lock);
> > +			complete = 0;
> > +		}
>
> Cool. Now think what happens if pages with large indices are in the
> very end of list. Half of them. You skip clean/2 pages on each of
> clean/2 passes. Hardly a linear behaviour - all you need is a
> different program to trigger it.
>
> Now, having a separate pass that would reorder the pages on list,
> moving the to-kill ones in the beginning might help.

This is easy, just set the list head to the page about to be truncated.

--
Daniel
