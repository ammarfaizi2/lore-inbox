Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbUKGEtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUKGEtt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 23:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbUKGEtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 23:49:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:18298 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261535AbUKGEtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 23:49:47 -0500
Date: Sun, 7 Nov 2004 04:49:27 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Chiaki <ishikawa@yk.rim.or.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: Configuration system bug? : tmpfs listing in /proc/filesystems
    when TMPFS was not configured!?
In-Reply-To: <418D8470.9070907@yk.rim.or.jp>
Message-ID: <Pine.LNX.4.44.0411070436080.12803-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Nov 2004, Chiaki wrote:
> Should not this line be ifdef'ed out???
> That is, should we modify the line like this?
> 
> #ifdef CONFIG_TMPFS
> 	error = register_filesystem(&tmpfs_fs_type);
> #endif

I'd be more inclined to register under a different
name than "tmpfs" in the !CONFIG_TMPFS case.

But as I said in my earlier reply to you (which you should have
received before you sent this?), it's been like this ever since
2.4.4 when "tmpfs" and CONFIG_TMPFS came into being, so I don't
see why we need to change it now.

The real 2.4.9 error is fixed by the patch below that I sent then:
does that solve your problems?

Hugh

--- 2.6.9/mm/shmem.c	2004-10-18 22:56:29.000000000 +0100
+++ linux/mm/shmem.c	2004-11-06 21:04:41.743173040 +0000
@@ -1904,6 +1904,8 @@ static int shmem_fill_super(struct super
 		sbinfo->max_inodes = inodes;
 		sbinfo->free_inodes = inodes;
 	}
+#else
+	sb->s_flags |= MS_NOUSER;
 #endif
 
 	sb->s_maxbytes = SHMEM_MAX_BYTES;

