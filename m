Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265202AbUD3S1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265202AbUD3S1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUD3S1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:27:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:30882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265202AbUD3SYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:24:47 -0400
Date: Fri, 30 Apr 2004 11:27:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP
Message-Id: <20040430112704.3dca3c4c.akpm@osdl.org>
In-Reply-To: <200404301611.i3UGBkdK026345@harpo.it.uu.se>
References: <200404301611.i3UGBkdK026345@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> The change to mm/slab.c between 2.6.6-rc2-bk4 and -bk5
> broke x86-64 SMP. The symptoms are general protection
> faults in __switch_to shortly after init starts, and
> then the machine is dead. (Can't be more specific, my
> box can't log early boot oopses.)
> 
> I'm only seeing this with x86-64 SMP; x86-64 UP and i386
> SMP on the same machine (Athlon64 UP) have no problems.
> 
> Reverting 2.6.6-rc2-bk5's change to mm/slab.c eliminates
> the problem.

The "-bk5" terminology doesn't mean much to people who use bitkeeper or who
use http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ - I assume
you refer to the alignment changes?

Does this fix?

diff -puN include/asm-x86_64/processor.h~a include/asm-x86_64/processor.h
--- 25/include/asm-x86_64/processor.h~a	Fri Apr 30 11:24:58 2004
+++ 25-akpm/include/asm-x86_64/processor.h	Fri Apr 30 11:25:28 2004
@@ -20,6 +20,8 @@
 #include <asm/mmsegment.h>
 #include <linux/personality.h>
 
+#define ARCH_MIN_TASKALIGN L1_CACHE_BYTES
+
 #define TF_MASK		0x00000100
 #define IF_MASK		0x00000200
 #define IOPL_MASK	0x00003000

_

