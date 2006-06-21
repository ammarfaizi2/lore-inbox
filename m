Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWFUJVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWFUJVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWFUJVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:21:17 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:41617 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751432AbWFUJVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:21:16 -0400
Date: Wed, 21 Jun 2006 05:17:32 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: halt the CPU on serious errors
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606210520_MC3-1-C307-8E13@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060620075015.GB3030@rhlx01.fht-esslingen.de>

On Tue, 20 Jun 2006 09:50:15 +0200, Andreas Mohr wrote:

> Thanks for the very fast patch, but:
> 
> >       /* Assume hlt works */
> > -     halt();
> > -     for(;;);
> > +     for (;;)
> > +             halt();
> 
> The comment above seems to hint at this code in arch/i386/kernel/smp.c/
> stop_this_cpu() which does proper hlt checks:
> 
>         if (cpu_data[smp_processor_id()].hlt_works_ok)
>                 for(;;) halt();
>         for (;;);
> 
> So I'm unsure what happens if hlt is not supported properly. Maybe
> there's an invalid opcode exception in a loop then.

  Some ancient CPUs never wake up on interrupt after a halt.  See
include/asm-i386/bugs.h::check_hlt().

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
