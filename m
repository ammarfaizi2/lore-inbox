Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWAYJ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWAYJ4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWAYJ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:56:44 -0500
Received: from cantor2.suse.de ([195.135.220.15]:40930 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751095AbWAYJ4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:56:43 -0500
Date: Wed, 25 Jan 2006 10:56:42 +0100
From: Nick Piggin <npiggin@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC] non-refcounted pages, application to slab?
Message-ID: <20060125095642.GB32578@wotan.suse.de>
References: <20060125093909.GE32653@wotan.suse.de> <43D74AC0.9020002@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D74AC0.9020002@cosmosbay.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 10:54:08AM +0100, Eric Dumazet wrote:
> Nick Piggin a écrit :
> 
> >@@ -2604,10 +2604,10 @@ static inline void *__cache_alloc(kmem_c
> > 
> > 	local_irq_save(save_flags);
> > 	objp = ____cache_alloc(cachep, flags);
> >+	prefetchw(objp);
> > 	local_irq_restore(save_flags);
> > 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
> > 					    __builtin_return_address(0));
> >-	prefetchw(objp);
> > 	return objp;
> > }
> 
> I'm not sure why you moved this prefetchw(obj) : This is not related to 
> your 'non-refcounting' part, is it ?
> 

Stray hunk. Thanks.

Nick

> When I added this prefetchw in slab code, I did place it *after* the 
> local_irq_restore(save_flags); because I was not sure if the 
> serialization/barrier (popf) would force the cpu (x86/x86_64 in mind) to 
> either :
> - finish all the loads (even if they are speculative/hints) (so giving a 
> bad latency)
> - cancel the speculative loads (so prefetchw() *before* the 
> local_irq_restore() would be useless.
> 
Makes sense.

