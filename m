Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTFDORr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTFDORq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:17:46 -0400
Received: from pat.uio.no ([129.240.130.16]:62129 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263310AbTFDORp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:17:45 -0400
To: Frank Cusack <fcusack@fcusack.com>
Cc: lkml <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: Re: nfs_refresh_inode: inode number mismatch
References: <20030603165438.A24791@google.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Jun 2003 16:19:38 +0200
In-Reply-To: <20030603165438.A24791@google.com>
Message-ID: <shswug2sz5x.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have ques\tions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > Hi, [Previously sent to nfs@sourceforge with no response]

     > I'm using a frankenstein kernel, 2.4.21-rc3 with some -ac bits,
     > and 2.5.69 NFS+RPC backported to it.  Like the CITI kernel (for
     > krb5), but a little more aggressive on the bits backported.
     > For the purpose of this email, I think the code I have
     > questions with is similar or even identical from
     > 2.4.21->2.5.69.  I can reproduce this problem on a RH
     > 2.4.20-9smp kernel.

     > Consider these two shells running on the same machine:

     > 	    1 2

     > 	cd /nfs cd /nfs mkdir t echo foo > t/foo less t/foo
     > 	 [less waits for input]
     > 					rm -rf t
     > 	'v'
     > 	 [vi tries to access tmp/foo]

     > At this point, fs/nfs/inode.c:__nfs_refresh_inode() prints the
     > "inode number mismatch" error.  AFAICT, this is just noise, but
     > the noise is driving me crazy. :-)

Inode number mismatch points to either an an obvious server error (it
is not providing unique filehandles) or corruption of the fattr struct
that was passed to nfs_refresh_inode().

Cheers,
  Trond
