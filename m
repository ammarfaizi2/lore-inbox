Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262337AbSI1WZZ>; Sat, 28 Sep 2002 18:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262339AbSI1WZY>; Sat, 28 Sep 2002 18:25:24 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:13199 "EHLO
	completely") by vger.kernel.org with ESMTP id <S262337AbSI1WZY>;
	Sat, 28 Sep 2002 18:25:24 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Sat, 28 Sep 2002 15:30:35 -0700
User-Agent: KMail/1.4.7-cool
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
References: <E17uINs-0003bG-00@think.thunk.org> <200209271820.41906.ryan@completely.kicks-ass.org> <20020928141330.GA653@think.thunk.org>
In-Reply-To: <20020928141330.GA653@think.thunk.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209281530.40944.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 28, 2002 07:13, Theodore Ts'o wrote:
> I've been able to replicate it now fairly reliably, with the attached
> shell script and 2.4.19 with the 2.4.19-2 dxdir patch.
Yes, that was what I'm using

> It appears to
> be somewhat timing dependent, as where the directory corruption occurs
> is not consistent, but I believe it is in the split code.  Since
> e2fsck -fD packs all of the directories completely, it means that any
> attempt to add a file to directory will guarantee at least one split,
> and possibly two levels of tree splits.  Since the -D option to e2fsck
> has only been relatively recently been available, I believe this is
> why it hasn't been noticed up until now in the testing; directories
> which are indexed "naturally" as they grow don't appear to trigger the
> problem, or are very, very unlikely to trigger the problem.  (One
> potential avenue for exploration is that -D option perfectly sorts all
> of the directory entries in hash order, which doesn't normally occur
> for naturally grown directories, and this may be triggering a
> fencepost error in the split code.)
Yes, running fsck -D seemed to make my loopback filesystem more brittle. I 
have triggered corruption without fsck, but it's much more difficult. That 
seems to match your description of the problem.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9li2QLGMzRzbJfbQRAlSfAJ93gPP65tXjzsyGiOjvoDlGwk5WrACeIILY
QKk+DpMb9kpq7rsiaSSuJHs=
=LoWq
-----END PGP SIGNATURE-----
