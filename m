Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUAVJ3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUAVJ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:29:51 -0500
Received: from brown.csi.cam.ac.uk ([131.111.8.14]:63629 "EHLO
	brown.csi.cam.ac.uk") by vger.kernel.org with ESMTP id S266005AbUAVJ3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:29:49 -0500
Subject: Re: [PATCH-BK-2.6] NTFS fix "du" and "stat" output (NTFS 2.1.6).
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: David Sanders <linux@sandersweb.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       ntfsdev <linux-ntfs-dev@lists.sourceforge.net>
In-Reply-To: <200401211412.55229@sandersweb.net>
References: <Pine.SOL.4.58.0401191413180.7391@yellow.csi.cam.ac.uk>
	 <200401211318.53776@sandersweb.net>  <200401211412.55229@sandersweb.net>
Content-Type: text/plain
Organization: University of Cambridge
Message-Id: <1074763798.16785.35.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 09:29:58 +0000
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 19:14, David Sanders wrote:
[snip]
> Also, chkdsk in winnt4 reports the cluster size in 512 bytes.  The ntfs 
> driver seems to think the size is 4096 bytes (or 1024 bytes in 2.4 
> kernel).

To quote from the man page for "stat(2)":

"The value st_blksize [which is the "IO Block:" field in the stat(1)
output you are referring to above] gives the "preferred" blocksize for
efficient file system I/O.  (Writing to a file in smaller chunks may
cause an inefficient read-modify-rewrite.)"

And this is what it is saying.  In the new NTFS driver doing any form of
i/o is most efficient if it is done in 4096 byte chunks, i.e. a single
read or write of 4096 bytes will be faster than reading or writing a
single byte 4096 times over.  The old NTFS driver didn't really care.
IMO 512 would have been a better value to 1024 as the driver uses 512
byte i/o requests but it doesn't really matter much.

To summarise: the st_blksize/"IO Block" has absolutely nothing at all to
do with the cluster size of the NTFS volume.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


