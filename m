Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290684AbSARMmf>; Fri, 18 Jan 2002 07:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290686AbSARMmZ>; Fri, 18 Jan 2002 07:42:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8453 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290684AbSARMmM>; Fri, 18 Jan 2002 07:42:12 -0500
Subject: Re: [PATCH 2.5.3-pre1] Fix NFS dentry lookup behaviour
To: trond.myklebust@fys.uio.no
Date: Fri, 18 Jan 2002 12:53:33 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <15432.4299.720181.998342@charged.uio.no> from "Trond Myklebust" at Jan 18, 2002 01:10:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RYWT-0006qT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> all in path_walk() for the special case of accessing cwd. That has 2
> consequences:
> 
>   - open(".") may succeed even if cwd is know to be a stale dentry.
> 
>   - The attribute cache, and hence also the data cache, does not get
>     revalidated. This breaks close-to-open semantics for those who
>     require it, and leads to silly inconsistencies: typically 'ls -l'
>     returning gratuitous "file 'blah' does not exist" errors.

This wants fixing at its vfs root (pardon the pun). NFS is not the only
afflicted file system here. Clustered file systems like opengfs face the
same problems where "." can go away from another node
