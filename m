Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVCIOjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVCIOjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVCIOjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:39:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63912 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261716AbVCIOjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:39:41 -0500
Date: Wed, 9 Mar 2005 20:18:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, christoph@graphe.net
Subject: Re: aio stress panic on 2.6.11-mm1
Message-ID: <20050309144855.GA4445@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050308170107.231a145c.akpm@osdl.org> <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com> <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com> <1110366614.6280.86.camel@laptopd505.fenrus.org> <m1fyz5vzdu.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fyz5vzdu.fsf@muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 12:21:01PM +0100, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > On Wed, 2005-03-09 at 16:34 +0530, Suparna Bhattacharya wrote:
> >> Any sense of how costly it is to use spin_lock_irq's vs spin_lock
> >> (across different architectures) ? Isn't rwsem used very widely ?
>
> On P4s cli/sti is quite costly, let's says 100+ cycles. That is mostly
> because it synchronizes the CPU partly. The Intel tables say 26/36 cycles
> latency, but in practice it seems to take longer because of the
> synchronization.
>
> I would assume this is the worst case, everywhere else it should
> be cheaper (except perhaps in some virtualized environments)
> On P-M and AMD K7/K8 it is only a few cycles difference.
> >
> > oh also rwsems aren't used all that much simply because they are quite
> > more expensive than regular semaphores, so that you need a HUGE bias in
> > reader/writer ratio to make it even worth it...
> 
> I agree. I think in fact once Christopher L's lockless page fault fast path
> goes in it would be a good idea to reevaluate if mmap_sem should
> be really a rwsem and possibly change it back to a normal semaphore
> that perhaps gets dropped only on a page cache miss.


OK - makes sense. Thanks !

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

