Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVCILXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVCILXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVCILWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:22:37 -0500
Received: from one.firstfloor.org ([213.235.205.2]:3751 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261570AbVCILVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:21:02 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, christoph@graphe.net
Subject: Re: aio stress panic on 2.6.11-mm1
References: <20050308170107.231a145c.akpm@osdl.org>
	<1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	<18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com>
	<1110366614.6280.86.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@muc.de>
Date: Wed, 09 Mar 2005 12:21:01 +0100
In-Reply-To: <1110366614.6280.86.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Wed, 09 Mar 2005 12:10:13 +0100")
Message-ID: <m1fyz5vzdu.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Wed, 2005-03-09 at 16:34 +0530, Suparna Bhattacharya wrote:
>> Any sense of how costly it is to use spin_lock_irq's vs spin_lock
>> (across different architectures) ? Isn't rwsem used very widely ?
>
> oh also rwsems aren't used all that much simply because they are quite
> more expensive than regular semaphores, so that you need a HUGE bias in
> reader/writer ratio to make it even worth it...

I agree. I think in fact once Christopher L's lockless page fault fast path
goes in it would be a good idea to reevaluate if mmap_sem should
be really a rwsem and possibly change it back to a normal semaphore
that perhaps gets dropped only on a page cache miss.

-Andi
