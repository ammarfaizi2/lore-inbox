Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265784AbSKAVxi>; Fri, 1 Nov 2002 16:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265785AbSKAVxi>; Fri, 1 Nov 2002 16:53:38 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:32502 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265784AbSKAVxh>; Fri, 1 Nov 2002 16:53:37 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 1 Nov 2002 14:56:54 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
Message-ID: <20021101215653.GH8864@clusterfs.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Reiserfs mail-list <Reiserfs-List@Namesys.COM>
References: <20021031163104.A9845@infradead.org> <Pine.LNX.4.44.0210311053170.1526-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210311053170.1526-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2002  10:57 -0800, Linus Torvalds wrote:
> On Thu, 31 Oct 2002, Christoph Hellwig wrote:
> > What about chaing truncate_inode_pages to take an additional len
> > argument so you don't have to remove all pages past an offset?
> 
> Actually, we may want that for other reasons anyway. In particular, I can
> well imagine why a networked filesystem in particular might want to
> invalidate a range of a file cache, but not necessarily all of it.
> 
> (Yeah, I don't know of any network filesystem that does invalidation on
> anything but a file granularity, but I assume such filesystems have to
> exist. Especially in cluster environments it sounds like a sane thing to
> do invalidates on a finer granularity)

Yes, we definitely need such a beast for Lustre.  Currently (because we
haven't gotten around to fixing it) we invalidate the whole file if
there is a lock conflict when we really only want to invalidate a
page or range of pages.

Our "performance" release isn't until next year - we're still working
on "performant" right now, but in the case of multiple clients writing
to non-overlapping areas in a file, or different files we're still
pretty good - abount 1.5GB/s aggregate write speed with 20 storage targets.

We have 62 storage targets in our target environment, but haven't done
a full tests because we're working on some nasty distributed metadata
bugs right now.  Since the client->target I/O is pretty much independent,
there should be no problems hitting 4.5 GB/s aggregate write speed.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

