Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318963AbSICWov>; Tue, 3 Sep 2002 18:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSICWov>; Tue, 3 Sep 2002 18:44:51 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:56317 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318963AbSICWou>; Tue, 3 Sep 2002 18:44:50 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 3 Sep 2002 16:46:43 -0600
To: Anton Altaparmakov <aia21@cantab.net>
Cc: ptb@it.uc3m.es, Lars Marowsky-Bree <lmb@suse.de>, root@chaos.analogic.com,
       Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
Message-ID: <20020903224643.GU32468@clusterfs.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cantab.net>, ptb@it.uc3m.es,
	Lars Marowsky-Bree <lmb@suse.de>, root@chaos.analogic.com,
	Rik van Riel <riel@conectiva.com.br>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <20020903185344.GA7836@marowsky-bree.de> <5.1.0.14.2.20020903221201.00ac5770@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020903221201.00ac5770@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 03, 2002  22:54 +0100, Anton Altaparmakov wrote:
> In my understanding a DFS offers exactly what you need: each node has disks 
> and all disks on all nodes are part of the very same file system. Of course 
> each node maintains the local disks, i.e. the local part of the file system 
> and certain operations require that the nodes communicates with the "DFS 
> master node(s)" in order for example to reserve blocks of disks or to 
> create/rename files (need to make sure no duplicate filenames are 
> instantiated for example). -- Sound familiar so far? You wanted to do 
> exactly the same things but at the block layer and the VFS layer levels 
> instead of the FS layer...
> 
> The difference between a DFS and your proposal is that a DFS maintains all 
> the caching benefits of a normal FS at the local node level, while your 
> proposal completely and entirely disables caching, which is debatably 
> impossible (due to need to load things into ram to read them and to modify 
> them and then write them back) and certainly no FS author will accept their 
> FS driver to be crippled in such a way. The performance loss incurred by 
> removing caching completely is going to make sure you will only be dreaming 
> of those 50GiB/sec. More likely you will be getting a few bytes/sec... (OK, 
> I exaggerate a bit.) The seek times on the disks together with the 
> read/write timings are going to completely annihilate performance. A DFS 
> maintains caching at local node level, so you can still keep open inodes in 
> memory for example (just don't allow any other node to open the same file 
> at the same time or you need to do some juggling via the "Master DFS node").
> 
> Your time would be much better spent in creating the _one_ true DFS, or 
> helping improve one of the existing ones instead of trying to hack up the 
> VFS/block layers to pieces. It almost certainly will be a hell of a lot 
> less work to implement a decent DFS in comparison to changing the block 
> layer, the VFS, _and_ every single FS driver out there to comply with the 
> block layer and VFS changes. And at the same time you get exactly the same 
> features you wanted to have but with hugely boosted performance.

This is exactly what Lustre is supposed to be.  Many nodes, each with
local storage, and clients are able to do I/O directly to the storage
nodes (for non-local storage, or if they have no local storage at all).

There is (currently) a single metadata server (MDS) which controls the
directory tree locking, and the storage nodes control the locking of
inodes (objects) local to their storage.

It's not quite in a robust state yet, but we're working on it.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

