Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265289AbSJRQdJ>; Fri, 18 Oct 2002 12:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265287AbSJRQdJ>; Fri, 18 Oct 2002 12:33:09 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:11786 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S265289AbSJRQdG>;
	Fri, 18 Oct 2002 12:33:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] remove sys_security
Date: Fri, 18 Oct 2002 18:38:56 +0200
User-Agent: KMail/1.4.3
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <20021018140543.C1670@infradead.org> <200210181514.g9IFEErG006526@turing-police.cc.vt.edu>
In-Reply-To: <200210181514.g9IFEErG006526@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210181838.56735.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002 17:14, Valdis.Kletnieks@vt.edu wrote:
> Do you have a projected timeline of when this mythical "all the warts in
> the kernel are fixed and all the userspace cruft is cleaned up" world will
> happen? I'd like some sort of reasonable estimate, so I know whether this
> will be before or after I retire. (While we're at it, can we reverse the
> definition of the 'r' and 'x' permissions on directories, so 'umask 037'
> doesn't result in directories with borked permissions?  I'm actually
> somewhat serious here - this is the sort of thing that will need to be
> cleaned up and fixed all over the place...)

A "dmask" sounds like a really good idea!

> > Instead of adding hacks for tempfile races you rather want to
> > give each user a private namesapace and it's own /tmp (IMHO
> > we should also get rid of symlinks entirely, but they're in too wide
> > use nowdays unfortunately).
>
> Symlinks are in too wide use, and too much code knows about them - yes,
> it might be nice if we threw symlinks out the window and replaced them with
> a union-mount scheme.  But would that be any less disruptive than what LSM
> does?

We will never get rid of symlinks.  Make a change like that and the result 
will not be recognisable as Unix.

In any case it only solves a part of the problem.  Any time that a program can 
be tricked into writing to the wrong file by a symlink attack it could be 
tricked into writing to the wrong file by a buffer overflow.

> 1) "We could deploy extended attributes and ACLs, except that they're not
> supported yet on the filesystem that would otherwise be most suited.  Once
> they're integrated into that filesystem it will be great, but we're not
> sure which release of the kernel it will happen in, or when that will be.
> And once it DOES get supported, we don't have any guarantee that some
> clever person won't find a way around the permissions that the kernel
> maintainer(*) isn't allowed to explain to us, like we've seen at least once
> already that we know of.  Oh, and if the facilities provided don't match
> our business model, we're stuck maintaining local patches or changing our
> business model".

You forgot to mention that migrating to an extended attribute based system 
would have to wait until there is a release kernel supporting it (2.6 at the 
earliest).

Also there's another problem, we need to create files, directories, and device 
nodes with the permission set as an atomic operation.  Until it's possible to 
create a file system object with some EAs already set then they can not be 
used for what we are doing.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

