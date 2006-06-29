Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWF2JSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWF2JSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWF2JSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:18:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751859AbWF2JSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:18:15 -0400
Date: Thu, 29 Jun 2006 02:18:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: i386 IPI handlers running with hardirq_count == 0
Message-Id: <20060629021800.9a1e16f4.akpm@osdl.org>
In-Reply-To: <26704.1151571677@kao2.melbourne.sgi.com>
References: <26704.1151571677@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 19:01:17 +1000
Keith Owens <kaos@ocs.com.au> wrote:

> Macro arch/i386/kernel/entry.S::BUILD_INTERRUPT generates the code to
> handle an IPI and call the corresponding smp_<name> C code.
> BUILD_INTERRUPT does not update the hardirq_count for the interrupted
> task, that is left to the C code.  Some of the C IPI handlers do not
> call irq_enter(), so they are running in IRQ context but the
> hardirq_count field does not reflect this.  For example,
> smp_invalidate_interrupt does not set the hardirq count.
> 
> What is the best fix, change BUILD_INTERRUPT to adjust the hardirq
> count or audit all the C handlers to ensure that they call irq_enter()?
> 

The IPI handlers run with IRQs disabled.  Do we need a fix?

