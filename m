Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTFIXsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTFIXsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:48:06 -0400
Received: from pat.uio.no ([129.240.130.16]:3019 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262299AbTFIXsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:48:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16101.8150.408526.624242@charged.uio.no>
Date: Tue, 10 Jun 2003 02:01:26 +0200
To: Frank Cusack <fcusack@fcusack.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, marcelo@conectiva.com.br,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
In-Reply-To: <20030609134655.A10940@google.com>
References: <20030609065141.A9781@google.com>
	<Pine.LNX.4.44.0306090848080.12683-100000@home.transmeta.com>
	<16100.47243.421268.704120@charged.uio.no>
	<20030609134655.A10940@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > On Mon, Jun 09, 2003 at 06:40:43PM +0200, Trond Myklebust
     > wrote:
    >> If people prefer 'rm -rf' correctness instead of
    >> unlinked-but-open, then we could do that by changing the
    >> behaviour of 'unlink' on a silly-deleted filed. Currently it
    >> returns EBUSY, but we could just as well have it complete the
    >> unlink, and mark the inode as being stale...

     > Actually, *currently* it unlinks. :-) That's the problem.

No. The problem is that it aliases the dentry, and so it unlinks
incorrectly...

Cheers,
  Trond
