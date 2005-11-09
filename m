Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVKIXXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVKIXXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVKIXXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:23:09 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:54407 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750824AbVKIXXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:23:07 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 9 Nov 2005 23:22:57 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] Remove read-only check from inode_update_time().
In-Reply-To: <1131577451.21652.10.camel@kleikamp.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0511092320140.19282@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0511092243001.7946@hermes-1.csi.cam.ac.uk>
 <1131577451.21652.10.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Dave Kleikamp wrote:
> On Wed, 2005-11-09 at 22:48 +0000, Anton Altaparmakov wrote:
> > Hi Andrew,
> > 
> > The read-only check in inode_update_time() (or file_update_time() as it is 
> > now in -mm) is unnecessary as the VFS better have done all the read-only 
> > checks and aborted much earlier in the file write code paths where 
> > inode/file_update_time() is only called from.
> 
> I notice inode_update_time is called from pipe_writev.  I don't know how
> likely it would be in practice, but wouldn't it be possible to write to
> a pipe on a read-only partition?  In that case the read-only check still
> makes sense.

It would still make sense but only if you can write to a pipe on a 
read-only partition which I have always assumed is not possible.

However, now that you queried this, I went and tried it and yes, you can 
write to a named pipe after remounting read-only, so you are right, the 
check does make sense in this case.  One learns something new every day.  
(-:

Andrew, please do not apply my patch...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
