Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSFJUF6>; Mon, 10 Jun 2002 16:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315993AbSFJUF5>; Mon, 10 Jun 2002 16:05:57 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:11984
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315988AbSFJUFz>; Mon, 10 Jun 2002 16:05:55 -0400
Date: Mon, 10 Jun 2002 13:05:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020610200552.GM14252@opus.bloom.county>
In-Reply-To: <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com> <Pine.GSO.4.05.10206102055280.17299-100000@mausmaki.cosy.sbg.ac.at> <20020610191959.GJ14252@opus.bloom.county> <3D04FE64.B92706E8@zip.com.au> <20020610194442.GL14252@opus.bloom.county> <3D050350.A7011AE4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 12:51:44PM -0700, Andrew Morton wrote:
> Tom Rini wrote:
> > 
> > ...
> > This reminds me of another slightly annoying issue.  At least for
> > toolchains, Documentation/Changes works poorly for !i386.  How about we
> > try and take care of things like this in <linux/compiler.h> ?
> > Eg:
> > 
> > #if defined(CONFIG_SPARC) || defined(CONFIG_SPARC64)
> > ...  egcs 1.1.2 check ...
> > 
> > #define __func__ __FUNCTION__
> > #endif
> > 
> > #if defined(CONFIG_X86) || ...
> > ... gcc-2.95.3 check ...
> > #endif
> > 
> 
> That won't work very well - if SPARC wants 2.91.66 then
> we need to support that compiler on x86 as well.  So that
> people won't use later-supported compiler features.  And
> because many compiler bugs are platform-independent, so
> they will be detected (and worked around) on x86.

Well, didn't someone just find a bug where egcs-1.1.2 falls down on x86
in an important area?

> wrt the __func__ thing: is it possible to do:
> 
> #if (compiler version test)
> #define __FUNCTION__ __func__
> #endif
> 
> to kill the 3.x warning?

Well, the warning (at least from what I've seen) is when you do:
"In " __FUNCTION__ " something bad happened\n", which __func__ just
won't do.  Doing:
"In %s something bad happened\n", __FUNCTION__
Is OK[1].

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

[1]: gcc version 3.1.1 20020606 (Debian prerelease), just a simple
program with -Wall.
