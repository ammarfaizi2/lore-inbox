Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbTJJWRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTJJWRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:17:16 -0400
Received: from pat.uio.no ([129.240.130.16]:62904 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263109AbTJJWRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:17:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16263.12262.325060.354532@charged.uio.no>
Date: Fri, 10 Oct 2003 18:17:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <Pine.LNX.4.44.0310101402370.25501-100000@home.osdl.org>
References: <16263.6450.819475.453165@charged.uio.no>
	<Pine.LNX.4.44.0310101402370.25501-100000@home.osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@osdl.org> writes:

     > (As to the read-ahead issue: there's nothing saying that you
     > can't wait for the pages if they aren't up-to-date, and really
     > synchronize with read-ahead. But that will require filesystem
     > help, if only to be able to recognize that there is active IO
     > going on. So NFS would have to keep track of a "read list" the
     > same way it does for writeback pages).

Well... I was thinking more in terms of a rw_semaphore to lock out new
calls to nfs_file_(read|write|sendfile) in combination with a call to
invalidate_inode_pages2().

Such a mechanism can also be used in schemes to improve on the generic
data/attribute cache consistency in order to reduce the number of
bogus cache invalidations due to RPC ordering races. Those can tend to
be expensive...

Note: Anybody using mmap() in combination with file locking will
however continue to enjoy the privilege of being able to screw up...

Cheers,
  Trond
