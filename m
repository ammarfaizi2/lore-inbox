Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVBORuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVBORuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVBORup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:50:45 -0500
Received: from pat.uio.no ([129.240.130.16]:25811 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261665AbVBORt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:49:27 -0500
Subject: Re: [patch 11/13] Client side of nfsacl
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050122203620.005569000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203620.005569000@blunzn.suse.de>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 12:49:17 -0500
Message-Id: <1108489757.10073.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.889, required 12,
	autolearn=disabled, AWL 2.11, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> vanlig tekstdokument vedlegg (patches.suse)
> This adds acl support fo nfs clients via the NFSACL protocol extension,
> by implementing the getxattr, listxattr, setxattr, and removexattr iops
> for the system.posix_acl_access and system.posix_acl_default attributes.
> This patch implements a dumb version that uses no caching (and thus adds
> some overhead). (Another patch in this patchset adds caching as well.)

Why are you adding a POSIX-ACL specific function to the nfs_xdr
functions? It is never going to be used for either NFSv2 or NFSv4.

I suggest you rather do the same thing we're doing for the NFSv4 acls,
and provide an nfsv3-specific struct inode_operations that points to
nfsv3-specific {get,set,list}xattr functions.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

