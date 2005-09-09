Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVIIMJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVIIMJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVIIMJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:09:04 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:13279 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932483AbVIIMJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:09:03 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH 2/25] NTFS: Allow
	highmem	kmalloc()	in	ntfs_malloc_nofs() and add _nofail() version.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509091453050.29168@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
	 <84144f0205090903366454da6@mail.gmail.com>
	 <1126263740.24291.16.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.58.0509091407220.27527@sbz-30.cs.Helsinki.FI>
	 <1126265138.24291.21.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.58.0509091426510.28121@sbz-30.cs.Helsinki.FI>
	 <1126266508.32261.3.camel@imp.csi.cam.ac.uk>
	 <1126266702.32261.5.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.58.0509091453050.29168@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 09 Sep 2005 13:08:58 +0100
Message-Id: <1126267738.32261.10.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 15:02 +0300, Pekka J Enberg wrote:
> On Fri, 9 Sep 2005, Anton Altaparmakov wrote:
> > > I completely disagree with you given that this is not "inventing [...]
> > > own memory allocators", it is just a convenient short hand.  I am sure a
> > > lot of people would agree with you though.  It is just a matter of
> > > personal preference.
> > 
> > I should add that this is not ntfs only, the idea is from another file
> > system which uses it, too.  Can't remember which one it was, though (xfs
> > maybe?).
> 
> Indeed. It is not just a matter of personal preference but also a matter 
> of subsystems introducing duplicate code like this. Quick grepping shows 
> UDF doing same thing  and XFS doing slightly differently but I am pretty 
> sure I've seen it elsewhere too.

Yes, that is usually a good indication that a generic function should be
provided.  However having a generic function with complicated and long
arguments is no use as everyone will want their own shorter one anyway.
And given the function is static inline it actually makes no difference
to the generated code size.  Also calling it __vmalloc_fast makes no
sense as it doesn't always use vmalloc...  Given we have kmalloc and
vmalloc maybe it should be just malloc?

Obviously if there were a suitable generic function I would use it but I
and I imagine all the other users would still wrap it with the old name.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

