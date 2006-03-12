Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWCLQu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWCLQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWCLQu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:50:58 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:5564 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751287AbWCLQu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:50:57 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sun, 12 Mar 2006 16:50:24 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Christoph Hellwig <hch@lst.de>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: truncate and {m,c}time on ntfs
Message-ID: <Pine.LNX.4.64.0603121641380.29271@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

A patch of yours modified fs/ntfs/inode.c::ntfs_truncate() and inserted 
this comment:

[snip]
	/* normally ->truncate shouldn't update ctime or mtime,
	 * but ntfs did before so it got a copy & paste version
	 * of file_update_time.  one day someone should fix this
	 * for real.
	 */
[snip]

Did you realise that all (local) file systems in Linux kernel set both 
{m,c}time in their ->truncate function.  E.g. from 
fs/ext3.c/inode.c::ext3_truncate():

inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;

Would you be so kind to explain what is your problem with ntfs doing it, 
too?  And if your statement is correct and no file system should touch 
{m,c}time in their ->truncate() method, could you explain to me how the 
{m,c}time would be set otherwise when open(O_TRUNC) or {f,}truncate() is 
executed on a file?

Thanks a lot in advance.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
