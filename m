Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSHBS30>; Fri, 2 Aug 2002 14:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSHBS30>; Fri, 2 Aug 2002 14:29:26 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:35336 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S316573AbSHBS3Z>; Fri, 2 Aug 2002 14:29:25 -0400
Message-ID: <3D4AD00C.8060701@namesys.com>
Date: Fri, 02 Aug 2002 22:31:40 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: trond.myklebust@fys.uio.no, Steve Lord <lord@sgi.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Alexander Viro <viro@math.psu.edu>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>	<Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>	<20020801035119.GA21769@ravel.coda.cs.cmu.edu>	<1028246981.11223.56.camel@snafu>	<20020802135620.GA29534@ravel.coda.cs.cmu.edu>	<1028297194.30192.25.camel@jen.americas.sgi.com>	<3D4AA0E6.9000904@namesys.com>	<shslm7pclrx.fsf@charged.uio.no>	<3D4ABAE7.6000709@namesys.com>	<15690.49267.930478.333263@laputa.namesys.com>	<15690.50598.11204.868852@charged.uio.no> <15690.51993.704549.209766@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Trond Myklebust writes:
> > >>>>> " " == Nikita Danilov <Nikita@Namesys.COM> writes:
> > 
> >      > But there still is a problem with applications (if any) calling
> >      > seekdir/telldir directly...
> > 
> > Agreed. Note however that the semantics for seekdir/telldir as
> > specified by SUSv2 are much weaker than those in our current
> > getdents()+lseek().
> > 
> > >From the Opengroup documentation for seekdir, it states that:
> > 
> >   On systems that conform to the Single UNIX Specification, Version 2,
> >   a subsequent call to readdir() may not be at the desired position if
> >   the value of loc was not obtained from an earlier call to telldir(),
> >   or if a call to rewinddir() occurred between the call to telldir()
> >   and the call to seekdir().
> > 
> > IOW assigning a unique offset to each and every entry in the directory
> > is overkill (unless the user is calling telldir() for all those
> > entries).
>
Forgive the really dumb question, but does this mean we can just store 
the last entry returned to readdir in the directory metadata, and 
completely ignore the value of loc?

>
>Are you implying some kind of ->telldir() file operation that notifies
>file-system that user has intention to later restart readdir from the
>"current" position and changing glibc to call sys_telldir/sys_seekdir in
>stead of lseek? This will allow file-systems like reiser4 that cannot
>restart readdir from 32bitsful of data to, at least, allocate something
>in kernel on call to ->telldir() and free in ->release().
>
> > 
> > Cheers,
> >   Trond
>
>Nikita.
>
>
>  
>


-- 
Hans



