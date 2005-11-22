Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVKVTZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVKVTZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbVKVTZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:25:41 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:39879 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965136AbVKVTZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:25:40 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 22 Nov 2005 19:25:20 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
In-Reply-To: <20051122171847.GD31823@thunk.org>
Message-ID: <Pine.LNX.4.64.0511221921530.7002@hermes-1.csi.cam.ac.uk>
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net>
 <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk>
 <20051122171847.GD31823@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Theodore Ts'o wrote:
> On Tue, Nov 22, 2005 at 04:55:08PM +0000, Anton Altaparmakov wrote:
> > > That assumption is probably made because that's what POSIX and Single
> > > Unix Specification define: "The st_ino and st_dev fields taken together
> > > uniquely identify the file within the system."  Don't blame code that
> > > follows standards for breaking.
> > 
> > The standards are insufficient however.  For example dealing with named 
> > streams or extended attributes if exposed as "normal files" would 
> > naturally have the same st_ino (given they are the same inode as the 
> > normal file data) and st_dev fields.
> 
> Um, but that's why even Solaris's openat(2) proposal doesn't expose
> streams or extended attributes as "normal files".  The answer is that
> you can't just expose named streams or extended attributes as "normal
> files" without screwing yourself.

Reiser4 does I believe...

> Also, I haven't checked to see what Solaris does, but technically
> their UFS implementation does actually use separate inodes for their
> named streams, so stat(2) could return separate inode numbers for the
> named streams.  (In fact, if you take a Solaris UFS filesystem with
> extended attributs, and run it on a Solaris 8 fsck, the directory
> containing named streams/extended attributes will show up in
> lost+found.)

I was not talking about Solaris/UFS.  NTFS has named streams and extended 
attributes and both are stored as separate attribute records inside the 
same inode as the data attribute.  (A bit simplified as multiple inodes 
can be in use for one "file" when an inode's attributes become large than 
an inode - in that case attributes are either moved whole to a new inode 
and/or are chopped up in bits and each bit goes to a different inode.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
