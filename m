Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUIFBpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUIFBpo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 21:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUIFBpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 21:45:43 -0400
Received: from dhcp160178161.columbus.rr.com ([24.160.178.161]:16403 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S267380AbUIFBpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 21:45:41 -0400
Date: Sun, 5 Sep 2004 21:43:08 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Joseph Fannin <jhf@rivenstone.net>, albert_herranz@yahoo.es,
       roland@redhat.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: 2.6.9-rc1-mm1 ppc build broken
Message-ID: <20040906014308.GA2638@samarkand.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Joseph Fannin <jhf@rivenstone.net>, albert_herranz@yahoo.es,
	roland@redhat.com, linux-kernel@vger.kernel.org,
	benh@kernel.crashing.org
References: <200408302348.i7UNmvw0006978@magilla.sf.frob.com> <20040831105118.85292.qmail@web52306.mail.yahoo.com> <20040904203715.GA3049@samarkand.rivenstone.net> <20040905145355.0cf48d5c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905145355.0cf48d5c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040818i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 02:53:55PM -0700, Andrew Morton wrote:
> jhf@rivenstone.net (Joseph Fannin) wrote:

> >      This is still broken in -mm3.  This fix works for my powermac too,
> >  except that arch/ppc/syslib/open_pic.c misses errno.h when it does not
> >  get it through mm.h.  I can't speak for other platforms, but I'll
> >  include the patch.
> 
> OK, now I have an ordering problem.  If I understand you correctly, this
> patch fixes a ppc problem which was introduced by a patch from the bk-ia64
> tree, yes?

   Yes.
 
> If so, my options are to ask Tony to add this patch to the bk-ia64 tree so
> they all go in at the same time, or to merge this patch into Linus's tree
> prior to the ia64 patch.  To do the latter, I'd need confirmation that your
> patch is safe against current -linus.  Can you please confirm this?

    -rc1-bk12 with this patch applied builds and runs okay on my
Powermac, so yes.  Thanks!

> +++ 25-akpm/arch/ppc/syslib/open_pic.c	2004-09-05 14:50:54.266081672 -0700
> @@ -16,6 +16,7 @@
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/sysdev.h>
> +#include <linux/errno.h>
>  #include <asm/ptrace.h>
>  #include <asm/signal.h>
>  #include <asm/io.h>
> diff -puN include/asm-ppc/io.h~ppc-build-fix include/asm-ppc/io.h
> +++ 25-akpm/include/asm-ppc/io.h	2004-09-05 14:50:54.276080152 -0700
> @@ -4,7 +4,6 @@
>  
>  #include <linux/config.h>
>  #include <linux/types.h>
> -#include <linux/mm.h>
>  
>  #include <asm/page.h>
>  #include <asm/byteorder.h>

-- 
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.
