Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264669AbRGIS7z>; Mon, 9 Jul 2001 14:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbRGIS7o>; Mon, 9 Jul 2001 14:59:44 -0400
Received: from mons.uio.no ([129.240.130.14]:10134 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264669AbRGIS71>;
	Mon, 9 Jul 2001 14:59:27 -0400
MIME-Version: 1.0
Message-ID: <15177.65286.592796.329570@charged.uio.no>
Date: Mon, 9 Jul 2001 20:59:18 +0200
To: Craig Soules <soules@happyplace.pdl.cmu.edu>
Cc: jrs@world.std.com, linux-kernel@vger.kernel.org
Subject: NFS Client patch
In-Reply-To: <Pine.LNX.3.96L.1010709131315.16113O-200000@happyplace.pdl.cmu.edu>
In-Reply-To: <Pine.LNX.3.96L.1010709131315.16113O-200000@happyplace.pdl.cmu.edu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Craig Soules <soules@happyplace.pdl.cmu.edu> writes:

     > Hello, I hope that I am sending this to the appropriate people.
     > I have been working on a project known as Self-Securing Storage
     > here at Carnegie Mellon University.  We have developed our
     > storage server to act as an NFSv2 server, and have been using
     > the Linux NFSv2 client to do our benchmarking. I have run
     > across a small problem with the 2.4 implementation of the Linux
     > NFSv2 client.

     > The problem is in the readdir() operation.  The current cookie
     > for a given readdir operation is being stored in the file
     > descriptor.  The problem is that it is not being reset to 0 if
     > a change has been made to the directory as is indicated in the
     > NFSv2 spec.  This problem is often seen when doing an operation
     > such as rm -rf to a large directory tree due to the
     > asynchronous remove operation that has been implemented.

The NFSv2 spec says no such thing. It simply says that you set the
cookie to zero when you want to start at the beginning of the
directory. This is only needed when we want to reread the directory
into the page cache.

Your patch will automatically lead to duplicate entries in readdir()
on most if not all servers whenever the attributes on the inode have
been refreshed (whether or not the cache has been invalidated). That's
a bug...

Cheers,
   Trond
