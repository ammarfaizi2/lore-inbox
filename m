Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSGEMcn>; Fri, 5 Jul 2002 08:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317437AbSGEMcm>; Fri, 5 Jul 2002 08:32:42 -0400
Received: from pat.uio.no ([129.240.130.16]:4841 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317436AbSGEMcl> convert rfc822-to-8bit;
	Fri, 5 Jul 2002 08:32:41 -0400
To: "Nils O." =?iso-8859-1?q?Sel=E5sdal?= <noselasd@frisurf.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: df on a nfs mounted share vs local?
References: <1025793209.10267.5.camel@space>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 05 Jul 2002 14:35:13 +0200
In-Reply-To: <1025793209.10267.5.camel@space>
Message-ID: <shsu1nel5dq.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Nils O <Selåsdal <noselasd@frisurf.no>> writes:

     > Just wondering, how come df reports root:~# df /mnt/export/
     > Filesystem 1k-blocks Used Available Use% Mounted on /dev/hda5
     > 2562252 383792 2178460 15% /mnt/export on the server, while on
     > a client that mounts /mnt/export over nfs: [root@space
     > download]# df /mnt/nfs/ Filesystem 1k-blocks Used Available
     > Use% Mounted on lfs:/mnt/export 2562256 383792 2178464 15%
     > /mnt/nfs

     > Just a few blocks diffrent, but I've seen much bigger.. also
     > seen +/- a few % on "Use"

It is a rounding error. The block size on the NFS client is typically
4 or 8k, whereas the block size on the local filesystem is typically
512 bytes.

On most UNIX implementations, the 'statvfs()' call supports two
variables f_bsize and f_frsize, which allow you to distinguish between
the two. Linux lacks kernel support for the latter variable.

Cheers,
  Trond
