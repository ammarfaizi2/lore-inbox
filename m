Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSFJToq>; Mon, 10 Jun 2002 15:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSFJTop>; Mon, 10 Jun 2002 15:44:45 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:7376 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315923AbSFJToo>; Mon, 10 Jun 2002 15:44:44 -0400
Date: Mon, 10 Jun 2002 12:44:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020610194442.GL14252@opus.bloom.county>
In-Reply-To: <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com> <Pine.GSO.4.05.10206102055280.17299-100000@mausmaki.cosy.sbg.ac.at> <20020610191959.GJ14252@opus.bloom.county> <3D04FE64.B92706E8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 12:30:44PM -0700, Andrew Morton wrote:
> Tom Rini wrote:
> > 
> > On Mon, Jun 10, 2002 at 08:57:02PM +0200, Thomas 'Dent' Mirlacher wrote:
> > > On Mon, 10 Jun 2002, Maksim (Max) Krasnyanskiy wrote:
> > >
> > > > Hi Martin,
> > > >
> > > > How about replacing __FUNCTION__ with __func__ ?
> > > > GCC 3.x warns that __FUNCTION__ is obsolete and will be removed.
> > >
> > > is __func__ already supported for gcc 2.96?
> > 
> > Well it works with 2.95.3, which is the important part...
> 
> The 2.5 kernel must be buildable on gcc-2.91.66, aka egcs-1.1.2.
> 
> The 2.95.x requirement was reverted because sparc (or sparc64?)
> needs egcs-1.1.2.
> 
> __func__ does *not* work on egcs-1.1.2 and so cannot be used in Linux.
> 
> `struct blah = { .open = driver_open };' *does* work in egcs-1.1.2
> and is OK to use.

This reminds me of another slightly annoying issue.  At least for
toolchains, Documentation/Changes works poorly for !i386.  How about we
try and take care of things like this in <linux/compiler.h> ?
Eg:

#if defined(CONFIG_SPARC) || defined(CONFIG_SPARC64)
...  egcs 1.1.2 check ...

#define __func__ __FUNCTION__
#endif

#if defined(CONFIG_X86) || ...
... gcc-2.95.3 check ...
#endif

Or not, I'm not really sure..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
