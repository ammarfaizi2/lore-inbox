Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVCIRkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVCIRkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVCIRkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:40:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:30708 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262103AbVCIRiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:38:52 -0500
Subject: Re: [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks
From: Badari Pulavarty <pbadari@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, suparna@in.ibm.com,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4175.1110370343@redhat.com>
References: <20050309032832.159e58a4.akpm@osdl.org>
	 <20050308170107.231a145c.akpm@osdl.org>
	 <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	 <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com>
	 <1110366469.6280.84.camel@laptopd505.fenrus.org>
	 <4175.1110370343@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1110389707.24286.156.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Mar 2005 09:35:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch seems to have helped. I don't see the Oops anymore - my
tests are still running (past 1 hour - it used to panic in 10 min).

Thanks,
Badari

On Wed, 2005-03-09 at 04:12, David Howells wrote:
> The attached patch makes read/write semaphores use interrupt disabling
> spinlocks, thus rendering the up functions and trylock functions available for
> use in interrupt context.
> 
> I've assumed that the normal down functions must be called with interrupts
> enabled (since they might schedule), and used the irq-disabling spinlock
> variants that don't save the flags.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> warthog>diffstat -p1 rwsem-irqspin-2611mm2.diff


