Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVBFTmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVBFTmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVBFTmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:42:39 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:52365 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261291AbVBFTmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:42:23 -0500
Date: Sun, 6 Feb 2005 19:42:17 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: nathans@sgi.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page cache
 pages.
In-Reply-To: <20050203024755.1792b6c0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0502061932270.21938@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
 <20050202143422.41c29202.akpm@osdl.org> <1107427057.9010.18.camel@imp.csi.cam.ac.uk>
 <20050203024755.1792b6c0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Andrew Morton wrote:
> I did a patch which switched loop to use the file_operations.read/write
> about a year ago.  Forget what happened to it.  It always seemed the right
> thing to do..

How did you implement the write?  At the moment the loop driver gets hold 
of both source and destination pages (the latter via grab_cache_page() and 
aops->prepare_write()) and copies/transforms directly from the source to 
the destination page (and then calls commit_write() on the destination 
page).  Did you allocate a buffer for each request, copy/transform to the 
buffer and then submit the buffer via file_operations->write?  That would 
clearly be not very efficient but given fops->write() is not atomic I 
don't see how that could be optimised further...

Perhaps the loop driver should work as is when 
aops->{prepare,commit}_write() are not NULL and should fall back to 
a buffered fops->write() otherwise?

Or have I missed some way in which the fops->write() case can be 
optimized?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
