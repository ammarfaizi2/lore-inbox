Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSHaW0H>; Sat, 31 Aug 2002 18:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSHaW0H>; Sat, 31 Aug 2002 18:26:07 -0400
Received: from mons.uio.no ([129.240.130.14]:1474 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318033AbSHaW0F>;
	Sat, 31 Aug 2002 18:26:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15729.17279.474307.914587@charged.uio.no>
Date: Sun, 1 Sep 2002 00:30:23 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <1030822731.1458.127.camel@ldb>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:

     > Then the rest of the code doesn't need to know at all that
     > credentials are shared and is simpler and faster.  We have
     > however a larger penalty on credential change but, as you say,
     > that's extremely rare (well, perhaps not necessarily extremely,
     > but still rare).

What if I, in a fit of madness/perversion, decide to use CLONE_CRED
between 2 kernel threads (i.e. no 'kernel entry')?


Leaving CLONE_CRED aside, please do not forget that most of the
motivation for vfs_cred is the need to *cache* credentials.
This is something which we already do today in several filesystems:
Coda, Intermezzo, NFS, to name but the most obvious.
The result of the lack of a VFS-sanctioned credential is that we have
to use 'struct file' as a vehicle for passing credentials in, for
instance, the address_space_operations, and that each filesystem ends
up having to keep its own private copies of those credentials in
file->private_data.

Cheers,
  Trond
