Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVF3Gws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVF3Gws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVF3Gwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:52:47 -0400
Received: from mtaout3.barak.net.il ([212.150.49.173]:28525 "EHLO
	mtaout3.barak.net.il") by vger.kernel.org with ESMTP
	id S262803AbVF3Gwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:52:32 -0400
Date: Thu, 30 Jun 2005 09:57:17 +0300
From: eliad lubovsky <eliadl@013.net>
Subject: Re: Handle kernel page faults using task gate
In-reply-to: <20050629192740.GA5940@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Message-id: <1120114635.3422.2.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1119997135.4074.106.camel@localhost.localdomain>
 <20050629130901.GA29776@elte.hu> <20050629192740.GA5940@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I clear the 'busy' bit?
I set my TSS descriptor with
__set_tss_desc(cpu, GDT_ENTRY_PAGE_FAULT_TSS, &pagefault_tss);

Eliad

On Wed, 2005-06-29 at 22:27, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * eliad lubovsky <eliadl@013.net> wrote:
> > 
> > > I am trying to handle page faults exceptions in the kernel using the 
> > > task gate mechanism. I succeeded to transfer the execution to my page 
> > > fault handler using a new TSS and updates to the GDT and IDT tables 
> > > (similar to the double fault mechanism in 2.6). After handling the 
> > > fault and allocating the physical page I use the iret instruction to 
> > > switch back to the previous task. The problem is that I got a double 
> > > fault with the same address that cause the fault (although the 
> > > physical page is allocated and mapped). Any clues?
> > 
> > are you clearing the 'nested task' (NT) flag of the new TSS once you 
> > have switched to it?
> 
> correction - i meant the 'busy' bit in the TSS descriptor. It's being 
> set by TSS-switch operations, and needs to be cleared.
> 
> 	Ingo

