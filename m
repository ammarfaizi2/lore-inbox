Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286723AbSAPSdI>; Wed, 16 Jan 2002 13:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286221AbSAPSc5>; Wed, 16 Jan 2002 13:32:57 -0500
Received: from mailc.telia.com ([194.22.190.4]:15350 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S286215AbSAPScr>;
	Wed, 16 Jan 2002 13:32:47 -0500
To: Dave Jones <davej@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, David Weinehall <tao@acc.umu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, John Weber <weber@nyc.rr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <20020116013811.E5235@khan.acc.umu.se>
	<Pine.LNX.4.33.0201151639320.1213-100000@penguin.transmeta.com>
	<20020116015513.L32088@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Jan 2002 19:32:38 +0100
In-Reply-To: <20020116015513.L32088@suse.de>
Message-ID: <m2sn96no3d.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> writes:

> On Tue, Jan 15, 2002 at 04:41:08PM -0800, Linus Torvalds wrote:
>  > > #ifndef _LINUX_POSIX_TYPES_H   /* __FD_CLR */
>  > > #include <linux/posix_types.h>
>  > > #endif
>  > If this actally makes any noticeable difference to compilation speed I
>  > could live with it. Does it?
> 
>  I'm sure I read somewhere that gcc is clever enough to know
>  when it hits a #include, it checks for a symbol equal to a
>  mangled version of the filename before including it.
>  (Ie, doing this transparently).
> 
>  Then again, I may have imagined it all.

Not exactly, but there is an optimization in cpp that makes it
possible to do the cleanup Linus wants without sacrificing
performance. From the cpp info pages:

        The GNU C preprocessor is programmed to notice when a header
        file uses this particular construct and handle it efficiently.
        If a header file is contained entirely in a `#ifndef'
        conditional, modulo whitespace and comments, then it remembers
        that fact.  If a subsequent `#include' specifies the same
        file, and the macro in the `#ifndef' is already defined, then
        the directive is skipped without processing the specified file
        at all.

I did an strace on cpp to verify that this optimization actually
works.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
