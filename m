Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVIMU1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVIMU1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVIMU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:27:13 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:50382 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932394AbVIMU1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:27:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=g1oBYxYZyXk5rSpM1j9zdvC0fJXZnm1QtTtnbwXgoesU9pdCXdeZiqAlRc7u1J2XGJ8Ihp4Ibvti8Zf/NYBGFQsfb4IMZmoCEuab7BYVgvXDmd/xi9y7dwWHTquWOExHcdkwPqIhcnVnFPPSixXnqkd3awl8q8FiVxcLwNoo98U=
Date: Wed, 14 Sep 2005 00:37:20 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Grant Grundler <grundler@parisc-linux.org>
Subject: Re: -git11 breaks parisc and sh even more
Message-ID: <20050913203720.GA12868@mipter.zuzino.mipt.ru>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru> <20050913185759.GA17272@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913185759.GA17272@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 08:57:59PM +0200, Sam Ravnborg wrote:
> On Tue, Sep 13, 2005 at 09:47:54PM +0400, Alexey Dobriyan wrote:
> > 2.6.13-git10 was OK (read: allmodconfig still broken, but not _that_
> > early).

> > parisc:
> > 
> > 2.6.13-git11

> >   CC      arch/parisc/kernel/asm-offsets.s
> > In file included from include/asm/spinlock.h:4,
> >                  from include/asm/bitops.h:5,
> >                  from include/linux/bitops.h:77,
> >                  from include/linux/thread_info.h:20,
> >                  from include/linux/spinlock.h:53,
> >                  from include/linux/capability.h:45,
> >                  from include/linux/sched.h:7,
> >                  from arch/parisc/kernel/asm-offsets.c:31:
> > include/asm/system.h:174: error: parse error before "pa_tlb_lock"

> > In file included from include/linux/spinlock_types.h:13,
> >                  from include/linux/spinlock.h:80,
> >                  from include/linux/capability.h:45,
> >                  from include/linux/sched.h:7,
> >                  from include/linux/mm.h:4,
> >                  from arch/sh/kernel/asm-offsets.c:13:
> > include/asm/spinlock_types.h:16: error: parse error before "atomic_t"

> I have tried to understand why this happens with no success..
> Not much has changed in how we actually compile the .c -> .s files.
> In both cases it looks like gcc is warning that a sane typedef is not
> present.
> 
> Have you tried to dive more into this, or have you just reported the
> breakage?

fb1c8f93d869b34cacb8b8932e2b83d96a19d720 is first bad commit
diff-tree fb1c8f93d869b34cacb8b8932e2b83d96a19d720 (from 4327edf6b8a7ac7dce144313947995538842d8fd)
Author: Ingo Molnar <mingo@elte.hu>
Date:   Sat Sep 10 00:25:56 2005 -0700

    [PATCH] spinlock consolidation
    
    This patch (written by me and also containing many suggestions of Arjan van
    de Ven) does a major cleanup of the spinlock code.  It does the following
    things:

	[snip]

    arm, i386, ia64, ppc, ppc64, s390/s390x, x64 was build-tested via
    crosscompilers.  m32r, mips, sh, sparc, have not been tested yet, but should
    be mostly fine.

P. S.: git bisect absolutely rocks! 10 minutes.

