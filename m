Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSHBRoE>; Fri, 2 Aug 2002 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSHBRoE>; Fri, 2 Aug 2002 13:44:04 -0400
Received: from pat.uio.no ([129.240.130.16]:48113 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315442AbSHBRoD>;
	Fri, 2 Aug 2002 13:44:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.50598.11204.868852@charged.uio.no>
Date: Fri, 2 Aug 2002 19:47:18 +0200
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Hans Reiser <reiser@namesys.com>, Steve Lord <lord@sgi.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Alexander Viro <viro@math.psu.edu>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
In-Reply-To: <15690.49267.930478.333263@laputa.namesys.com>
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
	<Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>
	<20020801035119.GA21769@ravel.coda.cs.cmu.edu>
	<1028246981.11223.56.camel@snafu>
	<20020802135620.GA29534@ravel.coda.cs.cmu.edu>
	<1028297194.30192.25.camel@jen.americas.sgi.com>
	<3D4AA0E6.9000904@namesys.com>
	<shslm7pclrx.fsf@charged.uio.no>
	<3D4ABAE7.6000709@namesys.com>
	<15690.49267.930478.333263@laputa.namesys.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Nikita Danilov <Nikita@Namesys.COM> writes:

     > But there still is a problem with applications (if any) calling
     > seekdir/telldir directly...

Agreed. Note however that the semantics for seekdir/telldir as
specified by SUSv2 are much weaker than those in our current
getdents()+lseek().

>From the Opengroup documentation for seekdir, it states that:

  On systems that conform to the Single UNIX Specification, Version 2,
  a subsequent call to readdir() may not be at the desired position if
  the value of loc was not obtained from an earlier call to telldir(),
  or if a call to rewinddir() occurred between the call to telldir()
  and the call to seekdir().

IOW assigning a unique offset to each and every entry in the directory
is overkill (unless the user is calling telldir() for all those
entries).

Cheers,
  Trond
