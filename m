Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSFJTxJ>; Mon, 10 Jun 2002 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSFJTxI>; Mon, 10 Jun 2002 15:53:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315929AbSFJTxI>;
	Mon, 10 Jun 2002 15:53:08 -0400
Message-ID: <3D050350.A7011AE4@zip.com.au>
Date: Mon, 10 Jun 2002 12:51:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com> <Pine.GSO.4.05.10206102055280.17299-100000@mausmaki.cosy.sbg.ac.at> <20020610191959.GJ14252@opus.bloom.county> <3D04FE64.B92706E8@zip.com.au> <20020610194442.GL14252@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> ...
> This reminds me of another slightly annoying issue.  At least for
> toolchains, Documentation/Changes works poorly for !i386.  How about we
> try and take care of things like this in <linux/compiler.h> ?
> Eg:
> 
> #if defined(CONFIG_SPARC) || defined(CONFIG_SPARC64)
> ...  egcs 1.1.2 check ...
> 
> #define __func__ __FUNCTION__
> #endif
> 
> #if defined(CONFIG_X86) || ...
> ... gcc-2.95.3 check ...
> #endif
> 

That won't work very well - if SPARC wants 2.91.66 then
we need to support that compiler on x86 as well.  So that
people won't use later-supported compiler features.  And
because many compiler bugs are platform-independent, so
they will be detected (and worked around) on x86.

wrt the __func__ thing: is it possible to do:

#if (compiler version test)
#define __FUNCTION__ __func__
#endif

to kill the 3.x warning?

-
