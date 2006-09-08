Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWIHSEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWIHSEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWIHSEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:04:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751107AbWIHSEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:04:23 -0400
Date: Fri, 8 Sep 2006 11:04:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc6-mm1
Message-Id: <20060908110402.fd23e756.akpm@osdl.org>
In-Reply-To: <4501ABB7.6030203@s5r6.in-berlin.de>
References: <20060908011317.6cb0495a.akpm@osdl.org>
	<4501ABB7.6030203@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2006 19:43:19 +0200
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> ...
> > +nommu-move-the-fallback-arch_vma_name-to-a-sensible-place.patch
> ...
> 
> I get
> 
> 	kernel/signal.c:2742: warning: weak declaration of
> 	'arch_vma_name' after first use results in unspecified behavior
> 
> on X86_32, gcc 3.4.1-4mdk.
> 
> nommu-move-the-fallback-arch_vma_name-to-a-sensible-place.patch moves
> arch_vma_name() into kernel/signal.c, near its end.
> 
> vdso-improve-print_fatal_signals-support-by-adding-memory-maps.patch
> inserts a call to arch_vma_name() into kernel/signal.c, in the first
> half of signal.c.

Thanks.   Does this fix it?

--- a/include/linux/mm.h~nommu-move-the-fallback-arch_vma_name-to-a-sensible-place-fix
+++ a/include/linux/mm.h
@@ -1266,7 +1266,7 @@ void drop_slab(void);
 extern int randomize_va_space;
 #endif
 
-const char *arch_vma_name(struct vm_area_struct *vma);
+__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
_

