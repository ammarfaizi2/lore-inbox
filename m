Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVE0PE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVE0PE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVE0PE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:04:58 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:44714 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261820AbVE0PEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:04:41 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 27 May 2005 16:04:34 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: ntfs: remove redundant assignments
In-Reply-To: <20050526070437.GY29811@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.60.0505271603130.20905@hermes-1.csi.cam.ac.uk>
References: <1117044875.9510.2.camel@localhost>
 <Pine.LNX.4.60.0505252208120.25834@hermes-1.csi.cam.ac.uk>
 <courier.42956AFA.00002502@courier.cs.helsinki.fi>
 <20050526070437.GY29811@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005, Al Viro wrote:
> On Thu, May 26, 2005 at 09:21:46AM +0300, Pekka J Enberg wrote:
> > On Wed, 2005-05-25 at 22:10 +0100, Anton Altaparmakov wrote:
> > >This is not.  memset(0) is not the same as = NULL IMO.  I don't care if 
> > >the compiler thinks it is the same.  NULL does not have to be 0 so I 
> > >prefer to initialize pointers explicitly to NULL.  Even more so since this 
> > >code is not performance critical at all so I prefer clarity here.
> > 
> > I kind of figured out you were doing it on purpose. The fact is, NULL is 
> > zero on _all_ Linux architectures. If it weren't, we'd have a lot of broken 
> > code. Let me play the devils advocate here: why do you memset() (now 
> > kcalloc()) in the first place? 
> 
> Oh, come on...
> 
> 	ictx = kmalloc(sizeof(ntfs_index_context), GFP_NOFS);
> 	if (ictx)
> 		*ictx = (ntfs_index_context){.idx_ni = idx_ni};
> 	return ictx;
> 
> and be done with that.  Let compiler do its job.  And yes, that *will*
> give properly initialized pointers even for weird platforms.  Not that
> we had the slightest chance of porting to any of them...

Oh, cool.  I didn't think gcc-2.95 did this but I just tried it with 
2.95.2 and it worked.

Thanks,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
