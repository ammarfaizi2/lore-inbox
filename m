Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWGFGbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWGFGbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 02:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWGFGbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 02:31:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030183AbWGFGbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 02:31:41 -0400
Date: Wed, 5 Jul 2006 23:31:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com, kmannth@gmail.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu, tglx@linutronix.de, Natalie.Protasevich@UNISYS.com
Subject: Re: 2.6.17-mm6
Message-Id: <20060705233123.dcb0a10b.akpm@osdl.org>
In-Reply-To: <20060705225905.53e61ca0.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	<a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	<20060705155037.7228aa48.akpm@osdl.org>
	<a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	<20060705164457.60e6dbc2.akpm@osdl.org>
	<20060705164820.379a69ba.akpm@osdl.org>
	<a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com>
	<20060705172545.815872b6.akpm@osdl.org>
	<m1u05v2st3.fsf@ebiederm.dsl.xmission.com>
	<20060705225905.53e61ca0.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 22:59:05 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Wed, 05 Jul 2006 23:42:00 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > So I suspect that we need to de-percpuify kernel_stat.irqs.
> 
> I think so.

Maybe not.  If we do this, we lose the pretty CPUn columns in
/proc/interrupts.  That /proc/interrupts display requires that we maintain
NR_CPUS*NR_IRQS counters.

Given that a large NR_IRQs space will be sparsely populated, we should
dynamically allocate the NR_CPUS storage for each active IRQ, as you say.

That involves putting it into the irq_desc (as good a place as any).  And a
rather large number of trivial edits.  I guess we do this only for genirq?
