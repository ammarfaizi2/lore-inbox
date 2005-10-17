Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVJQJ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVJQJ4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVJQJ4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:56:12 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:36780 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932242AbVJQJ4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:56:11 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: ntfs CFT - was: Re: 2.6.14-rc4-mm1
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051016154108.25735ee3.akpm@osdl.org>
References: <20051016154108.25735ee3.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 17 Oct 2005 10:56:07 +0100
Message-Id: <1129542967.26285.30.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-16 at 15:41 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> 
>  git-ntfs.patch

This is a request for testers for ntfs.  2.6.14-rc4-mm1 contains a
pretty much complete re-write of file write support so some more testers
than just myself would be good before I submit it for inclusion in
2.6.15...

The rewrite means that the following features are now supported:

Given an existing uncompressed and unencrypted file, you can use:

- write(2) to write to the file, including beyond the end of the
existing file, and the file will be extended appropriately.  Both
resident and non-resident files are supported.  Support for heavily
fragmented files still has some limitations but you will just get an
EOPNOTSUPP error if you hit one.  Everything will still be consistent on
the volume.  Sparse files can also be written to and holes will be
filled in appropriately.

- truncate(2) and ftruncate(2) to change the size of the file, inlcuding
using open(2) with O_TRUNC flag.  As with write(2) there still are some
limitations for heavily fragmented files, and as above, everything will
still be consistent on the volume if you hit an unsupported case.

What this means is that you can now run your favourite editor on an
existing file, e.g. "vim /ntfs/somefile.txt" works fine and you can save
your changes.  Also things like running OpenOffice should work to edit
existing MS Office documents but I haven't tried it yet (it should work
as long as OpenOffice does not need to create temporary files in the
same directory as the document).

Still not supported features are creation/deletion of files/directories
and mmap(2) based writes to sparse regions of files.  (The mmap(2)
support has not been modified since the last release, only the file
write(2) support was rewritten.)

If you do try it, please let me know how it worked for you! - Thanks a
lot in advance for testing!

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
.

