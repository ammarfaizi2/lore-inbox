Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSIATgK>; Sun, 1 Sep 2002 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSIATgK>; Sun, 1 Sep 2002 15:36:10 -0400
Received: from pat.uio.no ([129.240.130.16]:40703 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317396AbSIATgH>;
	Sun, 1 Sep 2002 15:36:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15730.27952.29723.552617@charged.uio.no>
Date: Sun, 1 Sep 2002 21:40:32 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <1030906488.2145.104.camel@ldb>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>
	<15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb>
	<15730.4100.308481.326297@charged.uio.no>
	<15730.8121.554630.859558@charged.uio.no>
	<1030890022.2145.52.camel@ldb>
	<15730.17171.162970.367575@charged.uio.no>
	<1030906488.2145.104.camel@ldb>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:

     > And, in the common case of open, why do you need to copy the
     > structure to check permissions?  I think that open should just
     > check the current values.  open might want to copy credentials

Because, as has been explained to you, we have things like Coda,
Intermezzo, NFS, for which this is insufficient.

     > in case you want to do the inode lookup asynchronously but then
     > it doesn't make sense to optimize for this since you already
     > have the huge disk read penalty.  BTW, the 2.5.32 open does the
     > check in vfs_permission without copying anything.  Anyway it's
     > just a 3 long copy plus an atomic inc vs. 1 long copy and
     > atomic inc.  And if you don't need the groups array, it's just
     > a 2 longs copy that on some architectures with very slow atomic
     > operations (e.g. sparc) is much better.

But we we do need to check the groups array in the VFS. And as Linus
pointed out, there is a good case for passing info from the
user_struct too (crypto), etc...

Cheers,
  Trond
