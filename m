Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTJJRya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTJJRya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:54:30 -0400
Received: from pat.uio.no ([129.240.130.16]:59026 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262419AbTJJRy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:54:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16262.62026.603149.157026@charged.uio.no>
Date: Fri, 10 Oct 2003 13:54:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org>
References: <20031010172001.GA29301@ca-server1.us.oracle.com>
	<Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@osdl.org> writes:

     > On Fri, 10 Oct 2003, Joel Becker wrote:
    >>
    >> msync() forces write(), like fsync().  It doesn't force read().

     > Actually, the kernel has a "readahead(fd, offset, size)" system
     > call that will start asynchronous read-ahead on any
     > mapping. After that, just touching the page will obviously map
     > in and synchronize the result.

That's different. That's just preheating the page cache.

It does nothing for the case Joel mentioned where 2 different nodes
are writing to the same device, and you need to force a read in order
to resynchronize the page cache.
Apart from O_DIRECT, we have nothing in the kernel as it stands that
will allow userland to deal with this case.

Cheers,
  Trond
