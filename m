Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbRGIUF4>; Mon, 9 Jul 2001 16:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbRGIUFq>; Mon, 9 Jul 2001 16:05:46 -0400
Received: from pat.uio.no ([129.240.130.16]:59057 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264869AbRGIUFh>;
	Mon, 9 Jul 2001 16:05:37 -0400
MIME-Version: 1.0
Message-ID: <15178.3722.86802.671534@charged.uio.no>
Date: Mon, 9 Jul 2001 22:05:30 +0200
To: Craig Soules <soules@happyplace.pdl.cmu.edu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, jrs@world.std.com,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <Pine.LNX.3.96L.1010709153516.16113R-100000@happyplace.pdl.cmu.edu>
In-Reply-To: <15177.65286.592796.329570@charged.uio.no>
	<Pine.LNX.3.96L.1010709153516.16113R-100000@happyplace.pdl.cmu.edu>
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

    >> Your patch will automatically lead to duplicate entries in
    >> readdir() on most if not all servers whenever the attributes on
    >> the inode have been refreshed (whether or not the cache has
    >> been invalidated). That's a bug...

     > If I were to do a create during a readdir() operation which
     > inserted itself in the directory before the place it left off,
     > that entry would be left out of the listing.  That is also a
     > bug, wouldn't you think?

No: it's POSIX

If the client discovers that the cache is invalid, it clears it, and
refills the cache. We then start off at the next cookie after the last
read cookie. Test it on an ordinary filesystem and you'll see the
exact same behaviour. The act of creating or deleting files is *not*
supposed invalidate the readdir offset.

You are confusing the act of detecting whether or not the cache is
invalid with that of recovering after a cache invalidation. In the
former case we do have room for improvement: see for instance

  http://www.fys.uio.no/~trondmy/src/2.4.6/linux-2.4.6-cto.dif

which strengthens the attribute checking on open().

Cheers,
  Trond
