Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbSJHVRK>; Tue, 8 Oct 2002 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJHVRK>; Tue, 8 Oct 2002 17:17:10 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:30447 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261489AbSJHVRI>; Tue, 8 Oct 2002 17:17:08 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 8 Oct 2002 15:19:36 -0600
To: Christoph Hellwig <hch@infradead.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021008211936.GL3045@clusterfs.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org> <20021008195322.A14585@infradead.org> <200210082114.00576.agruen@suse.de> <20021008202038.A15692@infradead.org> <20021008214143.O2717@redhat.com> <20021008214736.A22169@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008214736.A22169@infradead.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 08, 2002  21:47 +0100, Christoph Hellwig wrote:
> On Tue, Oct 08, 2002 at 09:41:43PM +0100, Stephen C. Tweedie wrote:
> > On Tue, Oct 08, 2002 at 08:20:38PM +0100, Christoph Hellwig wrote:
> > > On Tue, Oct 08, 2002 at 09:14:00PM +0200, Andreas Gruenbacher wrote:
> > > > Users might just fill up all xattr space leaving no space for ACLs (or 
> > > > similar). If user xattrs are disabled this can no longer occur, so some 
> > > > administrators might be happy to have a choice.
> > > 
> > > Umm, that's why we have quota..
> > 
> > It's the per-inode extended attribute space that's at risk here,
> > quotas don't help.
> 
> Well, that's a more important problem.  But I doubt a hack to just turn off
> user xattrs is the right fix then.  A static reservation for ACLs or just
> totally separating them (like in XFS) seems more m?ture.

Yes, we have made proposals in the past to change the way ext2/3 EAs are
stored on disk, but nobody has had time to work on it yet.  The current
limitations of 4kB of EA per inode (user+system) is bad, as is the fact
that you need a full block for each inode if you have any unique
per-inode data (basically anything other than ACLs).

That said, the benefits of the current EA implementation far outweigh the 
limitations, and since this is an internal-to-ext2/3 issue, we can
change it at some later date without affecting the rest of the kernel.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

