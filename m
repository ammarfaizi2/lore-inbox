Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274990AbRJQIbc>; Wed, 17 Oct 2001 04:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275045AbRJQIbX>; Wed, 17 Oct 2001 04:31:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64522 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274990AbRJQIbH>; Wed, 17 Oct 2001 04:31:07 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: libz, libbz2, ramfs and cramfs
Date: 17 Oct 2001 01:31:14 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qjfki$ob5$1@cesium.transmeta.com>
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com> <3BCBE29D.CFEC1F05@alacritech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BCBE29D.CFEC1F05@alacritech.com>
By author:    "Matt D. Robinson" <yakker@alacritech.com>
In newsgroup: linux.dev.kernel
> > 
> > The -ac tree is moving to a single copy of zlib, in fs/inflate_fs.  It
> > is currently used by cramfs and zisofs.  jffs2 in the -ac tree still
> > uses its own copy of zlib and should be converted.
> 
> Any plans to fix this for the Linus tree?  Also, why place this in fs?
> Shouldn't this be around for PPP along with other things that
> can use it (like LKCD)?
> 

PPP uses a nonstandard deviant of zlib, or *so I've been told*, so
that one is out.

The reason it's in fs is because I wasn't feeling sure that the memory
management as implemented is adequate for non-fs-related
applications.  I might change that, though, but I wanted to move
somewhat slowly.

Memory management in zlib is nontrivial.  If you port the user-space
zlib the "obvious" way to kernel space, you get memory management that
is completely unacceptable to a filesystem application -- too easy to
get random errors due to memory allocation failures.

A major problem is that the module name "deflate" is used by PPP,
despite it being a nonstandard format...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
