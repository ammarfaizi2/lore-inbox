Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSJ1FcE>; Mon, 28 Oct 2002 00:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbSJ1FcE>; Mon, 28 Oct 2002 00:32:04 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:11262 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262881AbSJ1FcD>; Mon, 28 Oct 2002 00:32:03 -0500
Date: Sun, 27 Oct 2002 22:35:59 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
Message-ID: <20021028053559.GC17533@clusterfs.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20021027121318.GA2249@averell.suse.lists.linux.kernel> <20021027214913.GA17533@clusterfs.com.suse.lists.linux.kernel> <p73znszrx66.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73znszrx66.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 28, 2002  05:42 +0100, Andi Kleen wrote:
> Andreas Dilger <adilger@clusterfs.com> writes:
> > 1) It would be good if it were possible to select this with a config
> >    option (I don't care which way the default goes), so that people who
> >    don't need/care about the increased resolution don't need the extra
> >    space in their inodes and minor extra overhead.  To make this a lot
> >    easier to code, having something akin to the inode_update_time()
> >    which does all of the i_[acm]time updates as appropriate.
> 
> You're joking right? That's twelve bytes of more state per struct inode
> and I bet even with the most insidious micro benchmark you won't be 
> able to detect a difference in speed from the basic manipulation.

Except that people have a lot of inodes in their slab caches...  It's not
so much the processing overhead as the extra memory.  struct inode is
bloated enough without adding more into it that isn't necessarily useful
for some people (people who don't have lots of RAM, or don't use any
filesystems which support the higher resolution, or are slow enough that
compiles don't have problems, or don't compile at all)...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

