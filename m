Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135504AbRDSBXL>; Wed, 18 Apr 2001 21:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135505AbRDSBXB>; Wed, 18 Apr 2001 21:23:01 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:19974 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135504AbRDSBWw>; Wed, 18 Apr 2001 21:22:52 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: jaharkes@cs.cmu.edu, phillips@nl.linux.org
Subject: Re: Ext2 Directory Index - Delete Performance
Cc: adilger@turbolinux.com, ext2-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-Id: <20010419012241Z92303-1659+7@humbolt.nl.linux.org>
Date: Thu, 19 Apr 2001 03:22:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
> On Thu, Apr 19, 2001 at 02:27:48AM +0200, Daniel Phillips wrote:
> > more memory.  If you have enough memory, the inode cache won't thrash,
> > and even when it does, it does so gracefully - performance falls off
> > nice and slowly.  For example, 250 Meg of inode cache will handle 2
> > million inodes with no thrashing at all.
> 
> What inode cache are you talking about? According to the slabinfo output
> on my machine every inode takes up 480 bytes in the inode_cache slab. So
> 250MB is only able to hold about half a million inodes in memory.           
                                                                 
Sorry, I was a little loose with terminology there.  I should have said "inode
blocks in cache".  The inode cache is related.  When an Ext2 inode is pushed
out of the inode cache it gets transfered to a dirty block in memory, where it
shrinks to 128 bytes and shares the block with 31 other inodes.  These blocks
are in the buffer cache, and this is the cache I'm talking about.
--
Daniel
