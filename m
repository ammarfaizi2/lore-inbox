Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312272AbSCRJ5W>; Mon, 18 Mar 2002 04:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312274AbSCRJ5M>; Mon, 18 Mar 2002 04:57:12 -0500
Received: from pat.uio.no ([129.240.130.16]:3293 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S312272AbSCRJ5A>;
	Mon, 18 Mar 2002 04:57:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15509.47571.248407.537415@charged.uio.no>
Date: Mon, 18 Mar 2002 10:56:35 +0100
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <200203180933.g2I9XTg07727@mule.m17n.org>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == NIIBE Yutaka <gniibe@m17n.org> writes:

     > Because the inode could be on inode_unused, being still on the
     > hash at the client side, and server could reuse the inode (in
     > case of unfsd/ext3).  When the inode will be reused for
     > different type, it will result error.  Here is a scenario for
     > non-patched 2.4.18:

     >    (1) Symbolic link has been removed.  The inode is put on inode_unused.
     >        Say the inode # was 0x1234.
     > (2) Client issue "creat", server returns inode # 0x1234 (by the
     >        reuse).
     > (3) Call chain is:

     > 	 nfs_create -> nfs_instantiate -> nfs_fhget -> __nfs_fhget ->
     > 	 iget4

     >        iget4 returns the cached inode object on inode_unused.
     > (4) nfs_fill_inode doesn't fill it, because inode->i_mode is
     >        not 0.
     > (5) nfs_refresh_inode result error because inode->i_mode !=
     >        fattr->mode.

     > Note that this is _real_ case.

Sure, but it is a consequence of a badly broken server that violates
the NFS specs concerning file handles. Rigging the client in order to
cope with *all* the consequences in terms of unfsd races is an
exercise in futility - it cannot be done.

The solution is not to keep flogging the dead horse that is unfsd. It
is to put the effort into fixing knfsd so that it can cope with all
those cases where people are using unfsd today.

Cheers,
   Trond
