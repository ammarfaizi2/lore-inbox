Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbTJJUk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTJJUk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:40:29 -0400
Received: from pat.uio.no ([129.240.130.16]:16586 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262539AbTJJUk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:40:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16263.6450.819475.453165@charged.uio.no>
Date: Fri, 10 Oct 2003 16:40:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <Pine.LNX.4.44.0310101059330.20420-100000@home.osdl.org>
References: <16262.62026.603149.157026@charged.uio.no>
	<Pine.LNX.4.44.0310101059330.20420-100000@home.osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     > If you had a "this region is stale" thing, you'd just use
     > it. And if it was local disk, it wouldn't do anything.

Note that in order to be race-free, such a command would also have to
wait on any outstanding operations (i.e. both pending reads and
writes) on the region in question in order to make sure that none have
crossed the synchronization point. It is not a question of just
calling invalidate_inode_pages() and thinking that all is well...

In fact, I recently noticed that we still have this race in the NFS
file locking code: readahead may have been scheduled before we
actually set the file lock on the server, and may thus fill the page
cache with stale data.

Cheers,
  Trond
