Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSHBPgp>; Fri, 2 Aug 2002 11:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHBPgp>; Fri, 2 Aug 2002 11:36:45 -0400
Received: from mons.uio.no ([129.240.130.14]:65504 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S315278AbSHBPgl>;
	Fri, 2 Aug 2002 11:36:41 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Steve Lord <lord@sgi.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Alexander Viro <viro@math.psu.edu>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
	<Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>
	<20020801035119.GA21769@ravel.coda.cs.cmu.edu>
	<1028246981.11223.56.camel@snafu>
	<20020802135620.GA29534@ravel.coda.cs.cmu.edu>
	<1028297194.30192.25.camel@jen.americas.sgi.com>
	<3D4AA0E6.9000904@namesys.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 Aug 2002 17:39:46 +0200
In-Reply-To: <3D4AA0E6.9000904@namesys.com>
Message-ID: <shslm7pclrx.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hans Reiser <reiser@namesys.com> writes:

     > There are a number of interfaces that need expansion in 2.5.
     > Telldir and seekdir would be much better if they took as
     > argument some filesystem specific opaque cookie
     > (e.g. filename). Using a byte offset to reference a directory
     > entry that was found with a filename is an implementation
     > specific artifact that obviously only works for a ufs/s5fs/ext2
     > type of filesystem, and is just wrong.


     > 4 billion files is not enough to store the government's XML
     > databases in.

That's more of a glibc-specific bug. Most other libc implementations
appear to be quite capable of providing a userspace 'readdir()' which
doesn't ever use the lseek() syscall.

Note however that NFS compatibility *does* provide a limitation here:
the cookies that are passed between client and server are limited to
32 bits (NFSv2) or 64 bits (NFSv3/v4), so you'll be wanting to provide
some hack to get around this...

Cheers,
   Trond
