Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTI2I14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTI2I14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:27:56 -0400
Received: from pat.uio.no ([129.240.130.16]:27809 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262881AbTI2I1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:27:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16247.60679.415937.295532@charged.uio.no>
Date: Mon, 29 Sep 2003 01:27:51 -0700
To: Frank Cusack <fcusack@fcusack.com>
Cc: torvalds@osld.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: effect of nfs blocksize on I/O ?
In-Reply-To: <20030929005250.A9110@google.com>
References: <20030928234236.A16924@google.com>
	<16247.56578.861224.328086@charged.uio.no>
	<20030929005250.A9110@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

    >> OTOH, bsize is of informational interest to programs that wish
    >> to optimize I/O throughput by grouping their data into
    >> appropriately sized records.

     > So then isn't the optimal record size 8192 for r/wsize=8192?
     > Since the data is going to be grouped into 8192-byte reads and
     > writes over the wire, shouldn't bsize match that?  Why should I
     > make 16x 512-byte write() syscalls (if "optimal" I/O size is
     > bsize=512) instead of 1x 8192-byte syscall?

Yes. It is already on my list of bugs.

We basically need to feed 'wtpref' (a.k.a. 'wsize') into the f_bsize,
and 'wtmult' into f_frsize.

OTOH, the s_blocksize (and inode->i_blkbits) might well want to stay
with wtmult.

Cheers,
  Trond
