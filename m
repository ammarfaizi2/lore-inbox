Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268678AbUJDWEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268678AbUJDWEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUJDVzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:55:48 -0400
Received: from pat.uio.no ([129.240.130.16]:18365 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268677AbUJDVyP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:54:15 -0400
Subject: Re: [PATCH] NFS using CacheFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve Dickson <SteveD@redhat.com>
Cc: nfs@lists.sourceforge.net,
       Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4161B664.70109@RedHat.com>
References: <4161B664.70109@RedHat.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096926837.22446.141.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 23:53:57 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 04/10/2004 klokka 22:45, skreiv Steve Dickson:

> 3) There is no user level support. I realize this is extremely cheesy
>      but I noticed that the NFS posix mount  option (in the 2.6 kernel)
>      was no longer being used, so I high jacked it.  Which means
>      to make NFS to used CacheFS you need to use the posix option:
> 
>      mount -o posix server:/export/home /mnt/server/home

This is my one and only real gripe about it. The posix mount option is
clearly documented, so we really cannot play around with it. Why can't
you just add a separate cachefs flag?

Otherwise, I'm a bit dubious about the wisdom of putting
nfs_invalidatepage() and nfs_releasepage() into fs/nfs/file.c. These are
not file operations, but rather pure page cache operations. I would have
thought that either read.c or possibly nfs-cachefs.c would be more
appropriate.

Please note too that Chuck has made generic functions for copying and
comparing NFS filehandles. They should be used in nfs_cache_fh_match() &
co.
I'm a bit worried about the use of the raw IP address in
nfs_cache_server_match(). It seems to me that when we add the NFSv4.1
support for trunking over several different transport mechanisms (RDMA,
IPv4/v6 etc) on the same mountpoint, then we may end up with a problem.
We can probably leave it in for now, but later we may want to consider
switching to using server->hostname or something equivalent.

Otherwise, it looks good. Looking forward to try it out...

Cheers,
  Trond

