Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSGOUXk>; Mon, 15 Jul 2002 16:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317625AbSGOUXj>; Mon, 15 Jul 2002 16:23:39 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:28932 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317624AbSGOUXi>; Mon, 15 Jul 2002 16:23:38 -0400
Date: Mon, 15 Jul 2002 22:26:27 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5 ext3 + htree (was: IDE/ATAPI in 2.5)
Message-ID: <20020715202627.GA30630@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200207141811.g6EIBXKc019318@burner.fokus.gmd.de> <3D321041.2D25D649@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D321041.2D25D649@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Andrew Morton wrote:

> > It wasted 2900 seconds of CPU time on Linux. Let me guess: this was done
> > inside the function strcmp().
> 
> Nope. ext3 and ext2 directories use the traditional first-fit
> search-from-start for directories.  So adding 200k files to
> a single directory is pathological.
> 
> > There are ~ 5 different filesystems on Linux, but none if the projects seem
> > to care about the code outside the FS low level code. I suspect, that
> > this is not any better if you use reiserfs.
> > 
> > Solaris and FreeBSD put all the effort into one filesystem trying to make
> > it as good as possible. In Linux, it seems that nobody prooved the overall
> > concept of the kernel.
> 
> Apply http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.25/ext3-htree.patch
> to your 2.5.25 tree, mount with `-o index' and enjoy watching ext3 eat
> Solaris and FreeBSD's lunch.

I didn't benchmark, but how much lunch is left? UFS_DIRHASH was
introduced into FreeBSD by Ian Dowse a year ago (released in FreeBSD
4.4), and activated in FreeBSD 4.5's generic table. In case you missed
that, FreeBSD 4.6 is out since about four weeks.

options         UFS_DIRHASH             #Improve performance on big directories

http://www.freebsd.org/releases/4.4R/relnotes-i386.html#AEN197
http://www.freebsd.org/releases/4.5R/relnotes-i386.html#AEN250
http://www.cnri.dit.ie/Downloads/Malone_2001_bsdcon.pdf

The latter document by David Malone (November 2001) claims "MH 33 k
files create: 70s to 2.5s, pack: 240s to 2.5s, rm: 4.7s to 2s."

So might be ext3fs comes just in time for dessert, or is htree so much
faster than UFS_DIRHASH?

-- 
Matthias Andree
