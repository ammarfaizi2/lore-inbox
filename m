Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTDMWwg (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTDMWwg (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:52:36 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:59408 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262655AbTDMWwf (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 18:52:35 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Robert Love <rml@tech9.net>, David Brown <dave@codewhore.org>
Subject: Re: Preempt on PowerPC/SMP appears to leak memory
Date: Mon, 14 Apr 2003 01:03:26 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030412152951.GA10367@codewhore.org> <1050271044.767.7.camel@localhost>
In-Reply-To: <1050271044.767.7.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304140103.26761.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 April 2003 23:57, Robert Love wrote:

Hi Robert,

> http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preem
>pt-kernel-rml-2.4.20-2.patch
> It has a couple fixes for proper protection of per-CPU data, including
> some PPC-specific ones.
one thing in it seems bogus:

diff -Naurp preempt-1/kernel/exit.c preempt-2/kernel/exit.c
--- preempt-1/kernel/exit.c        2003-04-14 00:31:39 +0200
+++ preempt-2/kernel/exit.c        2003-04-14 00:31:48 +0200
@@ -282,7 +282,9 @@ struct mm_struct * start_lazy_tlb(void)
        current->mm = NULL;
        /* active_mm is still 'mm' */
        atomic_inc(&mm->mm_count);
+       preempt_disable();
        enter_lazy_tlb(mm, current, smp_processor_id());
+       preempt_disable();
        return mm;
 }

This is an incremental diff snipplet. The second preempt_disable(); should be 
a preempt_enable(); no?

ciao, Marc
