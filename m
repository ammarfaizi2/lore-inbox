Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVCIL3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVCIL3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVCIL3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:29:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:30111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261601AbVCIL3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:29:33 -0500
Date: Wed, 9 Mar 2005 03:28:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: suparna@in.ibm.com, dhowells@redhat.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: aio stress panic on 2.6.11-mm1
Message-Id: <20050309032832.159e58a4.akpm@osdl.org>
In-Reply-To: <1110366469.6280.84.camel@laptopd505.fenrus.org>
References: <20050308170107.231a145c.akpm@osdl.org>
	<1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	<18744.1110364438@redhat.com>
	<20050309110404.GA4088@in.ibm.com>
	<1110366469.6280.84.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Wed, 2005-03-09 at 16:34 +0530, Suparna Bhattacharya wrote:
> > Any sense of how costly it is to use spin_lock_irq's vs spin_lock
> > (across different architectures)
> 
> on x86 it makes a difference of maybe a few cycles. At most.
> However please consider using spin_lock_irqsave(); the _irq() variant,
> while it can be used correctly, is a major source of bugs since it
> unconditionally enables interrupts on unlock.
> 

spin_lock_irq() is OK for down_*(), since down() can call schedule() anyway.

spin_lock_irqsave() should be used in up_*() and I guess down_*_trylock(),
although the latter shouldn't need to go into the slowpath anyway.

