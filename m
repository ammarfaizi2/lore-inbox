Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVIILsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVIILsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVIILsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:48:37 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:62654 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751324AbVIILsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:48:36 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH 2/25] NTFS: Allow highmem
	kmalloc()	in	ntfs_malloc_nofs() and add _nofail() version.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509091426510.28121@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
	 <84144f0205090903366454da6@mail.gmail.com>
	 <1126263740.24291.16.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.58.0509091407220.27527@sbz-30.cs.Helsinki.FI>
	 <1126265138.24291.21.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.58.0509091426510.28121@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 09 Sep 2005 12:48:27 +0100
Message-Id: <1126266508.32261.3.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 14:38 +0300, Pekka J Enberg wrote: 
> On Fri, 9 Sep 2005, Anton Altaparmakov wrote:
> > They could be but I would rather not.  What if one day I decide to
> > change how ntfs_malloc_nofs() works?  Then it would be needed to
> > carefully go through the whole driver looking for places where kmalloc
> > is used and change those, too.
> > 
> > From a software design point of view you should never mix interfaces
> > when accessing an object if you want clean and maintainable code.  And
> > using kmalloc() sometimes and ntfs_malloc_nofs() at other times for the
> > same object would violate that.
> > 
> > The wrapper is a static inline so I would assume gcc can optimize away
> > everything when a constant size is passed in like in the example you
> > point out above.
> 
> Hey, I am not worried about performance. It's just that filesystems (or 
> any other subsystem for that matter) should not invent their own memory 
> allocators. Perhaps should provide a generic __vmalloc_fast() if this is 
> really required?

Even if that were the case I would still use a wrapper.  I am far too
lazy to write __vmalloc(x, GFP_NOFS | __GFP_HIGHMEM); or even
__vmalloc(x, GFP_NOFS | __GFP_HIGHMEM | __GFP_NOFAIL); when I can get
away with ntfs_malloc_nofs{,nofail}()...  (-;

I completely disagree with you given that this is not "inventing [...]
own memory allocators", it is just a convenient short hand.  I am sure a
lot of people would agree with you though.  It is just a matter of
personal preference.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

