Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSHBSom>; Fri, 2 Aug 2002 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSHBSom>; Fri, 2 Aug 2002 14:44:42 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:27660 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S316591AbSHBSol>; Fri, 2 Aug 2002 14:44:41 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.54248.33518.887768@laputa.namesys.com>
Date: Fri, 2 Aug 2002 22:48:08 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Hans Reiser <reiser@namesys.com>
Cc: trond.myklebust@fys.uio.no, Steve Lord <lord@sgi.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Alexander Viro <viro@math.psu.edu>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
In-Reply-To: <3D4AD00C.8060701@namesys.com>
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
	<15690.50598.11204.868852@charged.uio.no>
	<15690.51993.704549.209766@laputa.namesys.com>
	<3D4AD00C.8060701@namesys.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Drdoom-Fodder: crypt CERT passwd security root crash satan
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > Nikita Danilov wrote:
 > 
 > >Trond Myklebust writes:
 > > > >>>>> " " == Nikita Danilov <Nikita@Namesys.COM> writes:
 > > > 
 > > >      > But there still is a problem with applications (if any) calling
 > > >      > seekdir/telldir directly...
 > > > 
 > > > Agreed. Note however that the semantics for seekdir/telldir as
 > > > specified by SUSv2 are much weaker than those in our current
 > > > getdents()+lseek().
 > > > 
 > > > >From the Opengroup documentation for seekdir, it states that:
 > > > 
 > > >   On systems that conform to the Single UNIX Specification, Version 2,
 > > >   a subsequent call to readdir() may not be at the desired position if
 > > >   the value of loc was not obtained from an earlier call to telldir(),
 > > >   or if a call to rewinddir() occurred between the call to telldir()
 > > >   and the call to seekdir().
 > > > 
 > > > IOW assigning a unique offset to each and every entry in the directory
 > > > is overkill (unless the user is calling telldir() for all those
 > > > entries).
 > >
 > Forgive the really dumb question, but does this mean we can just store 
 > the last entry returned to readdir in the directory metadata, and 
 > completely ignore the value of loc?

If application is using readdir, then yes: glibc internally maps readdir
into getdents plus at most one lseek on directory for "adjustment"
purposes (if I remember correctly, problem is that kernel struct dirent
has extra field and glibc cannot tell in advance how many of them will
fit into supplied user buffer).

But if application uses seekdir(3)/telldir(3) directly---then no.

 > 
 > >
 > >Are you implying some kind of ->telldir() file operation that notifies
 > >file-system that user has intention to later restart readdir from the
 > >"current" position and changing glibc to call sys_telldir/sys_seekdir in
 > >stead of lseek? This will allow file-systems like reiser4 that cannot
 > >restart readdir from 32bitsful of data to, at least, allocate something
 > >in kernel on call to ->telldir() and free in ->release().
 > >
 > > > 
 > > > Cheers,
 > > >   Trond
 > >

Nikita.

 > >
 > >
 > >  
 > >
 > 
 > 
 > -- 
 > Hans
 > 
 > 
 > 
