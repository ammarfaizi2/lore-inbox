Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263644AbUJ2WIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263644AbUJ2WIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUJ2WCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:02:30 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:57987 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263600AbUJ2VqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:46:23 -0400
Date: Fri, 29 Oct 2004 22:46:19 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes to fs/buffer.c?
In-Reply-To: <20041029133420.76a758b3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0410292237170.24884@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410291516580.19494@hermes-1.csi.cam.ac.uk>
 <20041029133420.76a758b3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > Is it ok to export 
> >  create_buffers() and to make __set_page_buffers() static inline and move 
> >  it to include/linux/buffer.h?
> 
> ho, hum - if you must ;)

I don't have to.  It is very easy for me to take a copy of each of these 
and stick it in fs/ntfs/aops.c.  Works out of the box.  Just seems silly 
to proliferate code like that rather than to make use of existing 
functions...  Would you not agree?  If not, I will just copy the functions 
and that's that.

> I'd be inclined to rename it to attach_page_buffers() or something though -
> create_buffers() is a bit generic-sounding.

create_empty_buffers() which is already exported and used by pretty much 
all fs is just as generic sounding...  However renaming create_buffers() 
to alloc_page_buffers() might be better as it doesn't actually attach the 
buffers to the page.  You still need the __set_page_buffers() to do that.  
Perhaps you meant to rename __set_page_buffers() to attach_page_buffers()?

Its time for bed now but I will cook up a new patch tomorrow or Monday 
depending on when I get some time on the computer...

Cheers,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
