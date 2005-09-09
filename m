Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVIIO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVIIO6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVIIO6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 10:58:20 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:4030 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751388AbVIIO6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 10:58:20 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc() in
	ntfs_malloc_nofs() and add _nofail() version.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Roland Dreier <rolandd@cisco.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <20050909145318.GA7061@infradead.org>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
	 <52ek7yi9as.fsf@cisco.com>  <20050909145318.GA7061@infradead.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 09 Sep 2005 15:58:03 +0100
Message-Id: <1126277883.2824.10.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 15:53 +0100, Christoph Hellwig wrote:
> On Fri, Sep 09, 2005 at 07:51:23AM -0700, Roland Dreier wrote:
> >     Anton> fs/ntfs/malloc.h::ntfs_malloc_nofs() to do the kmalloc()
> >     Anton> based allocations with __GFP_HIGHMEM, analogous to how the
> >     Anton> vmalloc() based allocations are done.
> > 
> > Does it make sense to pass __GFP_HIGHMEM to kmalloc()?
> 
> Not at all (as you indicated below..)
> 
> > kmalloc() has
> > to return memory from lowmem, since it gives you an address from the
> > direct-mapped kernel area, so at best kmalloc() ignores this flag.

Correct, but it doesn't do any harm either AFAICS (it gets masked out by
kmalloc) and it makes the ntfs code simpler since I can then use the
same gfp_flags parameter both for the kmalloc and the vmalloc rather
than needing two different ones.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

