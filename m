Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWIIOpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWIIOpC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWIIOpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:45:01 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30665 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932231AbWIIOo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:44:59 -0400
From: Andi Kleen <ak@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: 2.6.18-rc6-mm1 - x86_64-mm-lockdep-dont-force-framepointer.patch
Date: Sat, 9 Sep 2006 15:39:00 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060908011317.6cb0495a.akpm@osdl.org> <20060908122327.GD6913@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060908122327.GD6913@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609091539.00489.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 September 2006 14:23, Heiko Carstens wrote:
> x86_64-mm-lockdep-dont-force-framepointer.patch does this:
> > Don't force frame pointers for lockdep
> >
> > Now that stacktrace supports dwarf2 don't force frame pointers for
> > lockdep anymore
> >
> > Cc: mingo@elte.hu
> > Signed-off-by: Andi Kleen <ak@suse.de>
> >
> > ---
> >  lib/Kconfig.debug |    1 -
> >  1 files changed, 1 deletion(-)
> >
> > Index: linux/lib/Kconfig.debug
> > ===================================================================
> > --- linux.orig/lib/Kconfig.debug
> > +++ linux/lib/Kconfig.debug
> > @@ -218,7 +218,6 @@ config LOCKDEP
> >         bool
> >         depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT &&
> > STACKTRACE_SUPPORT && LOCKDEP_SUPPORT select STACKTRACE
> > -       select FRAME_POINTER
>
> This patch affects all architecture. I'd like to keep the "select
> FRAME_POINTER" for s390, since we don't support dwarf2.

Perhaps you should port the unwinder then?  I know you use it 
in userland.

> So this patch should be dropped.

I changed it now to add a if !X86 so it should be ok now

-Andi



