Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVCILS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVCILS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVCILS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:18:27 -0500
Received: from one.firstfloor.org ([213.235.205.2]:1703 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261595AbVCILRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:17:20 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: aio stress panic on 2.6.11-mm1
References: <20050308170107.231a145c.akpm@osdl.org>
	<1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	<18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com>
	<1110366469.6280.84.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@muc.de>
Date: Wed, 09 Mar 2005 12:17:19 +0100
In-Reply-To: <1110366469.6280.84.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Wed, 09 Mar 2005 12:07:48 +0100")
Message-ID: <m1k6ohvzk0.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Wed, 2005-03-09 at 16:34 +0530, Suparna Bhattacharya wrote:
>> Any sense of how costly it is to use spin_lock_irq's vs spin_lock
>> (across different architectures)
>
> on x86 it makes a difference of maybe a few cycles. At most.
> However please consider using spin_lock_irqsave(); the _irq() variant,
> while it can be used correctly, is a major source of bugs since it
> unconditionally enables interrupts on unlock.

irqsave is much worse than _irq on P4.

However the spinlock already synchronizes the CPU, so some of the
cost should be mitigated.

-Andi
