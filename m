Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTJKDrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 23:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbTJKDrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 23:47:55 -0400
Received: from pat.uio.no ([129.240.130.16]:14469 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263241AbTJKDrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 23:47:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16263.32096.746760.290534@charged.uio.no>
Date: Fri, 10 Oct 2003 23:47:44 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Joel.Becker@oracle.com,
       cfriesen@nortelnetworks.com, jamie@shareable.org,
       linux-kernel@vger.kernel.org
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010195343.6e821192.akpm@osdl.org>
References: <20031010172001.GA29301@ca-server1.us.oracle.com>
	<Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org>
	<16262.62026.603149.157026@charged.uio.no>
	<20031010195343.6e821192.akpm@osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@osdl.org> writes:

     > POSIX does not define the fadvise() semantics very clearly, so
     > it is largely up to us to decide what makes sense.  There are a
     > number of things which we can do quite easily in there - it's
     > mainly a matter of working out exactly what we want to do.

Possibly, but there really is no need to get over-creative either. The
SUS definition of msync(MS_INVALIDATE) reads as follows:

        When MS_INVALIDATE is specified, msync() shall invalidate all
        cached copies of mapped data that are inconsistent with the
        permanent storage locations such that subsequent references
        shall obtain data that was consistent with the permanent
        storage locations sometime between the call to msync() and the
        first subsequent memory reference to the data.

(ref: http://www.opengroup.org/onlinepubs/007904975/functions/msync.html)

i.e. a strict implementation would mean that msync() will in fact act
as a synchronization point that is fully consistent with Linus'
proposal for a "this region is stale" function.

Unfortunately Linux appears incapable of implementing such a strict
definition of msync() as it stands.

Cheers,
  Trond
