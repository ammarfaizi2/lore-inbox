Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbRGSLAb>; Thu, 19 Jul 2001 07:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267533AbRGSLAV>; Thu, 19 Jul 2001 07:00:21 -0400
Received: from pat.uio.no ([129.240.130.16]:17069 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267532AbRGSLAH>;
	Thu, 19 Jul 2001 07:00:07 -0400
MIME-Version: 1.0
Message-ID: <15190.48565.273451.582533@charged.uio.no>
Date: Thu, 19 Jul 2001 13:00:05 +0200
To: "Marco d'Itri" <md@Linux.IT>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs_refresh_inode: inode number mismatch
In-Reply-To: <20010719002520.A5112@wonderland.linux.it>
In-Reply-To: <shsd76zsxd2.fsf@charged.uio.no>
	<20010719002520.A5112@wonderland.linux.it>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>>>>> " " == Marco d'Itri <md@Linux.IT> writes:

     > On Jul 17, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
    >> > Jul 18 00:15:07 newsserver kernel: nfs_refresh_inode: inode
    >> > number mismatch Jul 18 00:15:07 newsserver kernel: expected
    >> > (0x3b30ac75/0x48d5), got (0x3b30ac75/0x8d04)

    >> If, on the other hand, you're using a clean kernel, I'd look
    >> into what the server is doing. It sounds like it's doing the
    >> same thing that the userland `nfs-server' does: namely to
    >> recycle filehandles after a file gets deleted...
     > Anything specific I can tell to their tech support?

     > Can I ignore these messages or I risk data corruption?

There's always a small danger of data corruption, since the NFS client
can't rely on the file handle actually being a pointer to the file we
expect.

Try 2.4.6 first though, as a couple of fixes were implemented there
that should reduce the frequency of such messages. Basically we ensure
that inodes are removed from the cache when we do believe that it has
been deleted.

A proper fix, though, would be for the server to implement filehandles
that are unique as per RFC1813...

Cheers,
  Trond
