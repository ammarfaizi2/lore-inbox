Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTFIQ1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264523AbTFIQ1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:27:33 -0400
Received: from pat.uio.no ([129.240.130.16]:26269 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264516AbTFIQ1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:27:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16100.47243.421268.704120@charged.uio.no>
Date: Mon, 9 Jun 2003 18:40:43 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Frank Cusack <fcusack@fcusack.com>, <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number
 mismatch)
In-Reply-To: <Pine.LNX.4.44.0306090848080.12683-100000@home.transmeta.com>
References: <20030609065141.A9781@google.com>
	<Pine.LNX.4.44.0306090848080.12683-100000@home.transmeta.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > I think your #1 is "obviously correct", but the fact that it
     > breaks rmdir sounds like a bummer. However, since it only
     > breaks rmdir when silly-renames exist - and since silly-renames
     > should only happen when you have a file descriptor still open -
     > I'd be inclined to say that this is the right behaviour.

I agree.

If people prefer 'rm -rf' correctness instead of unlinked-but-open,
then we could do that by changing the behaviour of 'unlink' on a
silly-deleted filed. Currently it returns EBUSY, but we could just as
well have it complete the unlink, and mark the inode as being stale...

Cheers,
   Trond
