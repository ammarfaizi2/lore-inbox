Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVKVQzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVKVQzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVKVQzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:55:15 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:62611 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965005AbVKVQzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:55:13 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 22 Nov 2005 16:55:08 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Chris Adams <cmadams@hiwaay.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
In-Reply-To: <20051122161712.GA942598@hiwaay.net>
Message-ID: <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk>
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Chris Adams wrote:
> Once upon a time, Jan Harkes <jaharkes@cs.cmu.edu> said:
> >The only thing that tends to break are userspace archiving tools like
> >tar, which assume that 2 objects with the same 32-bit st_ino value are
> >identical.
> 
> That assumption is probably made because that's what POSIX and Single
> Unix Specification define: "The st_ino and st_dev fields taken together
> uniquely identify the file within the system."  Don't blame code that
> follows standards for breaking.

The standards are insufficient however.  For example dealing with named 
streams or extended attributes if exposed as "normal files" would 
naturally have the same st_ino (given they are the same inode as the 
normal file data) and st_dev fields.

> >I think that by now several actually double check that theinode
> >linkcount is larger than 1.
> 
> That is not a good check.  I could have two separate files that have
> multiple links; if st_ino is the same, how can tar make sense of it?

Now that is true.  In addition to checking the link count is larger then 
1, they should check the file size and if that matches compute the SHA-1 
digest of the data (or the MD5 sum or whatever) and probably should also 
check the various stat fields for equality before bothering with the 
checksum of the file contents.

Or Linux just needs a backup api that programs like this can use to 
save/restore files.  (Analogous to the MS Backup API but hopefully 
less horid...)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
