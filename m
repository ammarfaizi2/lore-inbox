Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSIIEYs>; Mon, 9 Sep 2002 00:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSIIEYr>; Mon, 9 Sep 2002 00:24:47 -0400
Received: from dsl-213-023-043-054.arcor-ip.net ([213.23.43.54]:11452 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316088AbSIIEYq>;
	Mon, 9 Sep 2002 00:24:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Anton Altaparmakov <aia21@cantab.net>,
       torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [BK-PATCH 1/3] Introduce fs/inode.c::ilookup().
Date: Sun, 8 Sep 2002 19:04:21 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
References: <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
In-Reply-To: <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oGD2-0006lL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 September 2002 16:27, Anton Altaparmakov wrote:
> The second and third patch have the small disadvantage to the previous
> code in that in the case that ilookup() fails in iget_locked() and
> get_new_inode_fast() is called the inode hash is calculated twice.
> But that is the slow path so I don't think it is a problem.

It doesn't make sense to introduce even this small inefficiency when
all you need to do is wrap an __ilookup inline that takes the hash
list, and is called both from ilookup and iget.  The inline costs
nothing, the hidden inefficiency costs cycles, however few.

Thanks for actually documenting what the functions do in the inline
documentation, it's nice to see such a break from tradition.  One
nano point: it would read better with the functional description
before the ancilliary notes, i.e.:

+ * The inode specified by @ino is looked up in the inode cache and if present
+ * it is returned with an increased reference count.
+ *
+ * This is a fast version of iget5_locked() for file systems where the inode
+ * number is sufficient for unique identification of an inode.

While I'm picking nits, it's more accurate to say that iget5_locked is
a generalized version of iget_locked than that the latter is a fast
version of the former.

And I still like ifind* more than ilookup*.  It's shorter and is a
better match with the existing page cache terminology.  Why add
entropy when you don't have to?

-- 
Daniel
