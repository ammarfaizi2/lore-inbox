Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbTBIJ7a>; Sun, 9 Feb 2003 04:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbTBIJ7a>; Sun, 9 Feb 2003 04:59:30 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:22426 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267184AbTBIJ72>;
	Sun, 9 Feb 2003 04:59:28 -0500
Date: Sun, 9 Feb 2003 11:08:44 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       peter@chubb.wattle.id.au, tbm@a2000.nu
Subject: Re: fsck out of memory
In-Reply-To: <20030207102858.P18636@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
 <Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu> <20030207102858.P18636@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, Andreas Dilger wrote:

> Hmm, I don't think that will be easy...  By default e2fsck will load all
> of the inode blocks into memory (pretty sure at least), and if you have
> 76922880 inodes that is 9.6GB of memory, which you can't allocate from a
> single process on i386 no matter how much swap you have.  2.5GB sounds
> about right for the maximum amount of memory one can allocate.

hmms the data is not critical yet (i was just testing this server)
i really wonder why the crash was there in the first place

thing i found in /var/log/messages :

Feb  7 04:18:15 storage kernel: EXT3-fs error (device md(9,0)):
ext3_new_block:
Allocating block in system zone - block = 536875638
Feb  7 04:18:15 storage kernel: EXT3-fs error (device md(9,0)):
ext3_new_block:
Allocating block in system zone - block = 536875639

doesn't look ok to me (and explains the crash?)

makes me wonder if this can have todo with the lbd (to allow 2TB+ devices)
patch ? or is this something else?
(if it can be related to the lbd patch, i will remove 2 hd's from the
array (but i don't prefer this option))

also for not getting this thing again (that i can't fsck my filesystem)
what are the setting i can use for creating a large filesystem on /dev/md0
? (what is the maximum workable inodes?)

i did this :

mke2fs -j -m 0  -b 4096 -i 4096 -R stride=16

