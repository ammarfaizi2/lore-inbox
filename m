Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbTFRX06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265612AbTFRX06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:26:58 -0400
Received: from pat.uio.no ([129.240.130.16]:3546 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265611AbTFRX05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:26:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.63615.561414.52943@charged.uio.no>
Date: Wed, 18 Jun 2003 16:40:47 -0700
To: Frank Cusack <fcusack@fcusack.com>
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() again, and trivial nfs_fhget
In-Reply-To: <20030617165507.A19126@google.com>
References: <20030617051408.A17974@google.com>
	<shs1xxsr1gx.fsf@charged.uio.no>
	<20030617165507.A19126@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

    >> There is already code to handle this case in the NFS filesystem
    >> code itself.

     > No, there isn't.

Yes there is. Look again at nfs_unlink(), following the path

  if (atomic_read(&dentry->d_count) > 1)

which is *always* the case if we have sillyrenamed the file. Then look
at the comment "We don't allow a dentry to be silly-renamed twice."

Cheers,
  Trond
