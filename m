Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271026AbTGWVmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTGWVmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:42:24 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:63705 "HELO
	develer.com") by vger.kernel.org with SMTP id S271026AbTGWVmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:42:23 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Date: Wed, 23 Jul 2003 23:57:24 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <200307232046.46990.bernie@develer.com> <20030723193246.GA836@lst.de>
In-Reply-To: <20030723193246.GA836@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307232357.25128.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 July 2003 21:32, Christoph Hellwig wrote:

> Yes, we need to get this down again.  What compiler and compiler
> flags are you using?  Could you retry with the following ripped
> from include/linux/compiler.h:
>
> #if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
> #define inline          __inline__ __attribute__((always_inline))
> #define __inline__      __inline__ __attribute__((always_inline))
> #define __inline        __inline__ __attribute__((always_inline))
> #endif

Not much changed:

   text    data     bss     dec     hex filename
 845924   51204   78896  976024   ee498 linux-2.5.x/vmlinux-inline
 840368   48392   78896  967656   ec3e8 linux-2.5.x/vmlinux-noinline

By the way: this is uClinux 2.5.75-uc0. 2.6.0-test1 should be very close.
I'm building with gcc 3.3.1-pre with some ColdFire/uClinux patches.

> I'd especially be interested in the fs/ numbers after this.

 Neither did it change much here:

   text    data     bss     dec     hex filename
 224145    6952    5468  236565   39c15 linux-2.5.x/fs/built-in.o.inline
 223591    6952    5468  236011   399eb linux-2.5.x/fs/built-in.o

> Also -Os on both would be quite cool.

   text    data     bss     dec     hex filename
 845924   51204   78896  976024   ee498 linux-2.5.x/vmlinux-inline-O2
 819276   52460   78896  950632   e8168 linux-2.5.x/vmlinux-inline-Os

   text    data     bss     dec     hex filename
 840368   48392   78896  967656   ec3e8 linux-2.5.x/vmlinux-noinline-O2
 815052   48316   78896  942264   e60b8 linux-2.5.x/vmlinux-noinline-Os

This is quite a saving! I'll send a patch to Greg (uClinux maintainer)
once I've tested it a bit more.


NOTE: I just noticed the 2.4.x kernel was built with -O1 because I
had symbolic debug enabled. That's not fair: 2.4.20 would probably
come out even smaller than I reported!

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


