Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbUKSMH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUKSMH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUKSMFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:05:38 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:21175 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261378AbUKSMED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:04:03 -0500
Subject: Re: performance of filesystem xattrs with Samba4
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: tridge@samba.org
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <16797.41728.984065.479474@samba.org>
References: <16797.41728.984065.479474@samba.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Fri, 19 Nov 2004 12:03:53 +0000
Message-Id: <1100865833.6443.17.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 18:38 +1100, tridge@samba.org wrote:
> I've been developing the posix backend for Samba4 over the last few
> months. It has now reached the stage where it is passing most of the
> test suites, so its time to start some performance testing.
> 
> The biggest change from the kernels point of view is that Samba4 makes
> extensive use of filesystem xattrs. Almost every file with have a
> user.DosAttrib xattr containing file attributes and additional
> timestamp fields. A lot of files will also have a system.NTACL
> attribute containing a NT ACL, and many files will have a
> user.DosStreams xattr for NT alternate data streams. Some rare files
> will have a user.DosEAs xattr for DOS extended attribute
> support. Files with streams will also have separate xattrs for each NT
> stream.
[snip]
> Soon we'll be starting to integrate the xattr support with a LSM
> module, to allow the kernel to interpret the NT ACLs directly to avoid
> races, make things a little more efficient (using a xattr cache
> holding unpacked ACLs), and allowing for the possibility of non-Samba
> file access to obey the NT ACLs.

Note, that NTFS supports all those things natively on the file system,
so it may be worth keeping in mind when designing your APIs.  It would
be nice if one day when ntfs write support is finished, when running
Samba on an NTFS partition on Linux, Samba can directly access all those
things directly from NTFS.  I guess a good way would be if your
interface is sufficiently abstracted so that it can use xattrs as a
backend or a native backend which NTFS could provide for you or Samba
could provide for NTFS.  For example NTFS stores the 4 different times
in NT format in each inode (base Mft record) so you would not have to
take an xattr performance hit there.

Anyway, just thought I would mention this, I am not expecting you to do
anything about it, especially since full NTFS read-write support is
still a long way away...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

