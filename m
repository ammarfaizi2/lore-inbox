Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282844AbRLQUet>; Mon, 17 Dec 2001 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282860AbRLQUej>; Mon, 17 Dec 2001 15:34:39 -0500
Received: from pat.uio.no ([129.240.130.16]:47311 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S282844AbRLQUeb>;
	Mon, 17 Dec 2001 15:34:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15390.22219.82855.526773@charged.uio.no>
Date: Mon, 17 Dec 2001 21:34:19 +0100
To: Alexander Viro <viro@math.psu.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
        dzafman@kahuna.cag.cpqcorp.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client llseek
In-Reply-To: <Pine.GSO.4.21.0112171339180.3992-100000@weyl.math.psu.edu>
In-Reply-To: <20011217181748.GA15970@cs.cmu.edu>
	<Pine.GSO.4.21.0112171339180.3992-100000@weyl.math.psu.edu>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Alexander Viro <viro@math.psu.edu> writes:

     > getattr() is needed and will be added (patch exists), but the
     > thing about ->revalidate()...  It's a bloody mess that will
     > need serious cleanups.  And I'd rather have fewer code paths
     > involved into that cleanup.

AFAIK, revalidate() was originally simply meant to check the validity
of the cached attributes, refreshing them if the cache is stale.

If it is being used as a replacement for getattr() in some cases but
not others, then I agree it needs to go.

That said, I would still like the ability to inform the filesystem
that it needs to refresh the attribute cache. This is required in
order to close the remaining hole in the close-to-open cache semantics
when doing opendir(".").
For the moment, I'm hacking in a call 'check_stale(inode)' that is
used by the 'cto' patch to notify NFS in the above case, when the VFS
tries to open() a file while bypassing the dentry revalidation call.

Cheers,
  Trond
