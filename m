Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVJYH7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVJYH7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVJYH7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:59:34 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:42976 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932083AbVJYH7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:59:33 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com>
References: <1130168619.19518.43.camel@imp.csi.cam.ac.uk>
	 <1130167005.19518.35.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
	 <7872.1130167591@warthog.cambridge.redhat.com>
	 <9792.1130171024@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 25 Oct 2005 08:59:19 +0100
Message-Id: <1130227159.8169.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 20:11 +0100, Hugh Dickins wrote:
> On Mon, 24 Oct 2005, David Howells wrote:
> > 
> > The attached patch adds a new VMA operation to notify a filesystem or other
> > driver about the MMU generating a fault because userspace attempted to write
> > to a page mapped through a read-only PTE.
> > 
> > This facility permits the filesystem or driver to:
> > 
> >  (*) Implement storage allocation/reservation on attempted write, and so to
> >      deal with problems such as ENOSPC more gracefully (perhaps by generating
> >      SIGBUS).
> > 
> >  (*) Delay making the page writable until the contents have been written to a
> >      backing cache. This is useful for NFS/AFS when using FS-Cache/CacheFS.
> >      It permits the filesystem to have some guarantee about the state of the
> >      cache.
> 
> I've only given it a quick look, it looks pretty good, but too hastily
> thrown together, without understanding of the intervening changes:

There really is quite a difference between mm/*.c in -mm and Linus
kernel at present.  Is all this planned to be merged as soon as 2.6.14
is out or is -mm just a playground for now with no mainline merge
intentions?

Just asking so I know whether to work against stock kernels or -mm for
the moment...

[snip some corrections I am in no position to comment on at the moment]
> > @@ -1945,7 +1998,7 @@ static int do_file_page(struct mm_struct
> 
> Drop all those changes to do_file_page (which I added), they're no
> longer necessary.  A case appeared which made it clear that we cannot
> rely on resolving this issue for get_user_pages in a single call to
> handle_mm_fault, and that's why the VM_FAULT_WRITE stuff got added. 
> 
> This complication of do_file_page was always ugly, and I'm delighted
> to drop it.  Whereas the call to do_wp_page from do_swap_page is less
> obtrusive and may still be a worthwhile optimization, though I added
> it for the same disgraced reason a year or more back.

Cool, that reduces the size of the patch.  (-:

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

