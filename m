Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUEACBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUEACBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 22:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUEACBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 22:01:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:37256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261920AbUEACBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 22:01:32 -0400
Date: Fri, 30 Apr 2004 19:01:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mikpe@csd.uu.se, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP
Message-Id: <20040430190102.2994000e.akpm@osdl.org>
In-Reply-To: <20040501014807.GC14663@wotan.suse.de>
References: <200404301611.i3UGBkdK026345@harpo.it.uu.se>
	<20040430112704.3dca3c4c.akpm@osdl.org>
	<20040501014807.GC14663@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > Does this fix?
> > 
> > diff -puN include/asm-x86_64/processor.h~a include/asm-x86_64/processor.h
> > --- 25/include/asm-x86_64/processor.h~a	Fri Apr 30 11:24:58 2004
> > +++ 25-akpm/include/asm-x86_64/processor.h	Fri Apr 30 11:25:28 2004
> > @@ -20,6 +20,8 @@
> >  #include <asm/mmsegment.h>
> >  #include <linux/personality.h>
> >  
> > +#define ARCH_MIN_TASKALIGN L1_CACHE_BYTES
> 
> 16 should be enough actually. The problem is the FXSAVE instruction that 
> is used to switch the FPU state, and that only requires 16 byte alignment.
> 

yup.  I sent Linus the patch which changes the default from 0 to
L1_CACHE_SIZE in kernel/fork.c.  x86_64 can override that by setting
ARCH_MIN_TASKALIGN to 16 in asm/processor.h
