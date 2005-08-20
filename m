Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVHTMth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVHTMth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 08:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVHTMth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 08:49:37 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:62151 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750721AbVHTMtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 08:49:36 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 20 Aug 2005 13:49:28 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <Pine.LNX.4.58.0508191502050.3412@g5.osdl.org>
Message-ID: <Pine.LNX.4.60.0508201342420.18687@hermes-1.csi.cam.ac.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> 
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192220440.7312@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0508191502050.3412@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, 19 Aug 2005, Linus Torvalds wrote:
> On Fri, 19 Aug 2005, Anton Altaparmakov wrote:
> > Yes, sure.  I have applied your patch to our 2.6.11.4 tree (with the one 
> > liner change I emailed you just now) and have kicked off a compile.
> 
> Actually, hold on. The original patch had another problem: it returned an
> uninitialized "page" pointer when page_getlink() failed.

I copied the fix to that problem from your new patch by hand and 
recompiled the kernel (that way I didn't have to rebuild the modules 
again).  Note I did not apply any of the fs specific changes.  I only did 
the VFS part of your patch that was actually necessary.  And I reverted my 
ncpfs fix so it is now again using the vfs supplied symlink helpers.

Having booted the new kernel and trying nautilus it worked fine accessing 
the same symlink that failed before, so your patch fixes the ncpfs 
problem as one would expect but always good to be sure.  (-:

btw. It may be an idea to switch smbfs to use the fixed generic symlink 
functions, too, so it benefits from symlink caching...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
