Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSHaAx3>; Fri, 30 Aug 2002 20:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSHaAx3>; Fri, 30 Aug 2002 20:53:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54793 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315458AbSHaAx0>; Fri, 30 Aug 2002 20:53:26 -0400
Date: Fri, 30 Aug 2002 18:04:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
In-Reply-To: <1030755064.1225.18.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208301759060.5561-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 31 Aug 2002, Alan Cox wrote:
>
> On Sat, 2002-08-31 at 01:49, Linus Torvalds wrote:
> > > struct pcred {
> > >        atomic_t	count;
> > >        uid_t	uid, euid, suid;
> > >        gid_t	gid, egid, sgid;
> > >        struct ucred  *cred;
> > >        kernel_cap_t ... capabilities ...
> > >        struct user_struct *user;
> > > };
> > 
> 
> Needs fsuid too, and space for the security LSM modules to attach
> private information. SELinux needs a few more credentials than base
> kernels!

Note that "fsuid" would _be_ the "struct ucred *" thing (but hopefully
renamed: "ucred" is a really bad name, since it has almost nothing to do
with the user, and has everything to do with VFS. I don't know where BSD
got the "u" from).

Think of "fsuid"  and "fsgid" as small special-case "filesystem
credentials" already - they're separate from the regular uid/gid because
they have different sharing semantics (uid/euid are visible to signals,
the FS credentials aren't).

So I dont' think that is a problem.

The issue about attaching additional credential information (both to the
user credentials _and_ to the VFS credentials) is true, though.

		Linus

