Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbRENUqC>; Mon, 14 May 2001 16:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbRENUpw>; Mon, 14 May 2001 16:45:52 -0400
Received: from pat.uio.no ([129.240.130.16]:37268 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262486AbRENUpn>;
	Mon, 14 May 2001 16:45:43 -0400
MIME-Version: 1.0
Message-ID: <15104.17393.392226.632794@charged.uio.no>
Date: Mon, 14 May 2001 22:45:37 +0200
To: "Chuck Lever" <cel@netapp.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
        "NFS maillist" <nfs@lists.sourceforge.net>
Subject: RE: [NFS] [PATCH] New patch to flush out dirty mmap()ed NFS pages in 2.4.4
In-Reply-To: <NFBBLKEIKLGDCJAAAEKOMEDACAAA.cel@netapp.com>
In-Reply-To: <15102.39186.106340.57504@charged.uio.no>
	<NFBBLKEIKLGDCJAAAEKOMEDACAAA.cel@netapp.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chuck Lever <cel@netapp.com> writes:

     > the default behavior is that close() waits for all write-backs
     > to be committed to the server's disk.  you might add support
     > for the "nocto" mount option so that waiting is skipped for
     > shared mmap'd files, but then what happens to data that is
     > pinned on the client because a write-back failed after close()
     > returns to the application?

It gets written back slowly (by flushd) or the user can speed things
up using msync(). The latter will wait on completion.
In addition, I fixed up sys_sync() so that it (and also bdflush, &
friends) now also synchronizes to the server...

     > what's the application domain Linus is trying to optimize?

AFAIK the most common use of (writeable) mmap() is for caching and
possibly for local IPC.

As I understood it, Linus' position is that we have msync() as a
documented generic synchronization point. Since, we were unable to
find any examples of programs that rely on stricter rules for mmap
(barring those which actually use locking), he suggested that our
policy should be that which impacts the least on performance.

Cheers,
   Trond
