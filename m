Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSIATVU>; Sun, 1 Sep 2002 15:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSIATVU>; Sun, 1 Sep 2002 15:21:20 -0400
Received: from mons.uio.no ([129.240.130.14]:58108 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317351AbSIATVT>;
	Sun, 1 Sep 2002 15:21:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15730.27061.640906.564411@charged.uio.no>
Date: Sun, 1 Sep 2002 21:25:41 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <1030905777.2145.91.camel@ldb>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>
	<15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb>
	<15730.4100.308481.326297@charged.uio.no>
	<1030890821.2145.67.camel@ldb>
	<15730.17012.61365.788871@charged.uio.no>
	<1030905777.2145.91.camel@ldb>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:

     > But you'll need to modify the declaration of the various
     > function pointers whose implementations might need credentials
     > and modify all functions that call them and deal with
     > permissions.  Instead with my proposal the credentials are

Yes... And this is a useful activity in itself, as the existence of
all these hacks that temporarily change uid/gid/whatever... show.

     > automatically immutable across the syscall without needing to
     > worry at all about locks, counts and sharing.

I still have no opinion about your proposal for implementing CLONE_CRED.

What I fail to see is why you appear to insist it would be
incompatible with the idea of copy-on-write VFS credentials (which I
explained are interesting for other purposes).

I also fail to understand why you insist that we need to drop the idea
of copy-on-write credentials in order to optimize for this fringe case
in which somebody calls sys_access() or exec with euid != fsuid.

Now repeat after me

  "changing fsuid/fsgid is *not* the common case that needs optimization."

  Trond
