Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSIAM6o>; Sun, 1 Sep 2002 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSIAM6o>; Sun, 1 Sep 2002 08:58:44 -0400
Received: from mons.uio.no ([129.240.130.14]:44777 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316887AbSIAM6m>;
	Sun, 1 Sep 2002 08:58:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15730.4100.308481.326297@charged.uio.no>
Date: Sun, 1 Sep 2002 15:03:00 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <1030835635.1422.39.camel@ldb>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>
	<15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:

     > For example, rather than this;
<snip>

     > you can just do this:
     > - uid_t saved_fsuid = current->fsuid;
     > +               uid_t saved_fsuid = current->fscred.uid;
     >                 kernel_cap_t saved_cap =
     >                 current->cap_effective;
 
But I don't want to have to do that at all. Why should I change the
actual task's privileges in order to call down into a single VFS
function?
The point of VFS support for credentials is to eliminate these hacks,
and cut down on all this gratuitous changing of privilege. That's what
we want the API changes for.

Who cares if changing fsuid/fsgid is more expensive? The only place we
should actually be doing that is in sys_fsuid(), sys_fsgid(), and
possibly daemonize(), where adequate security checks can be made.

Cheers,
  Trond
