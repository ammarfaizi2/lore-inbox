Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbSI3Clq>; Sun, 29 Sep 2002 22:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261904AbSI3Clq>; Sun, 29 Sep 2002 22:41:46 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:6272 "EHLO
	completely") by vger.kernel.org with ESMTP id <S261903AbSI3Clp>;
	Sun, 29 Sep 2002 22:41:45 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: chrisl@gnuchina.org, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix htree dir corrupt after fsck -fD
Date: Sun, 29 Sep 2002 19:46:57 -0700
User-Agent: KMail/1.4.7-cool
References: <E17uINs-0003bG-00@think.thunk.org> <20020929070315.GA6876@vmware.com> <200209290117.02331.ryan@completely.kicks-ass.org>
In-Reply-To: <200209290117.02331.ryan@completely.kicks-ass.org>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Message-Id: <200209291947.01487.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 29, 2002 01:16, Ryan Cumming wrote:
> Case 1:
> "Problem in HTREE directory inode 2 (/): bad block 3223649"
>
> Case 2:
> "Inode 2, i_blocks is 3718, should be 2280
> Directory inode 2 has an unallocated block #377
> Directory inode 2 has an unallocated block #378
> Directory inode 2 has an unallocated block #379"
> etc

Okay, a few more datapoints:
1) Case #1 happens much more frequently than case #2
2) I can trigger filesystem corruption with nothing but non-concurrent 
readdir()s and unlink()s
3) Although my initial tests were reaching the filesystem's inode limit, I've 
been able to reproduce case #1 with 153,129 free inodes and 217,294 free 
blocks.
4) Case #1 persists with Chris' stack overflow fix, modified to use memmove 
instead of memcpy
5) I have not been able to reproduce either error without the dir_index flag 
set. This may be due to the fact that my test program runs -much- more slowly 
without directory indexing.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9l7slLGMzRzbJfbQRAtbnAKCo5c6NzuGY59Xy4MvCRFqwuw5/+gCgpQkr
FBXfCLl2R2ii/PiJ3+0ZQR8=
=droh
-----END PGP SIGNATURE-----
