Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTJJPch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJJPch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:32:37 -0400
Received: from pat.uio.no ([129.240.130.16]:57341 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262884AbTJJPcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:32:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16262.53512.249701.158271@charged.uio.no>
Date: Fri, 10 Oct 2003 11:32:24 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Misc NFSv4 (was Re: statfs() / statvfs() syscall ballsup...)
In-Reply-To: <20031010143553.GA28795@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
	<3F85ED01.8020207@redhat.com>
	<20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk>
	<20031010044909.GB26379@mail.shareable.org>
	<16262.17185.757790.524584@charged.uio.no>
	<20031010123732.GA28224@mail.shareable.org>
	<16262.47147.943477.24070@charged.uio.no>
	<20031010143553.GA28795@mail.shareable.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:

     > Trond Myklebust wrote:
    >> Sure. We might even try actually implementing leases on NFSv4
    >> for delegated files.

     > That would be nice.  (Aside: Can NFSv4 do anything like
     > dnotify, or am I restricted to, in effect, keeping many files
     > open to detect changes in any of them?)

Delegations for directories are in the pipeline for the next minor
revision of the protocol (NFSv4.1). Delegations are such a new feature
to NFS that it was decided to restrict them to files only to give us
time to learn how best to use them.

I can't tell as of yet whether or not the model chosen will include
all the features of dnotify (for instance recall in case the
attributes change on a subfile is a subject of hot debate), but
certainly some of us are pushing for something like this.

     > Generally NFSv4 sounds like the way to go.  Should I be
     > recommending it to all my friends yet, is the implementation
     > ready for that?

The client implementation in 2.6.0 is still lacking several important
features, including locking, ACLs, delegation support and recovery of
state (in case of server reboot or network partitions). I'm hoping
Andrew/Linus will allow me to send updates once the early 2.6.x
codefreeze period is over.

That said, I definitely encourage people to test out the existing code
for stability, and I will be offering an 'NFS_ALL' series with those
features that are missing from the main tree as and when I judge they
are approaching release quality.

Cheers,
  Trond
