Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVEXO4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVEXO4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVEXO4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:56:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13206 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261277AbVEXO4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:56:39 -0400
Date: Tue, 24 May 2005 15:56:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
Message-ID: <20050524145636.GA15943@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20050524121541.GA17049@elte.hu> <20050524132105.GA29477@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524132105.GA29477@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 03:21:05PM +0200, Ingo Molnar wrote:
> 
> this patch (ontop of the current -mm scheduler patchset plus the 
> previous 2 patches from me) adds a new preemption model: 'Voluntary 
> Kernel Preemption'. The 3 models can be selected from a new menu:
> 
>             (X) No Forced Preemption (Server)
>             ( ) Voluntary Kernel Preemption (Desktop)
>             ( ) Preemptible Kernel (Low-Latency Desktop)
> 
> we still default to the stock (Server) preemption model.
> 
> Voluntary preemption works by adding a cond_resched() 
> (reschedule-if-needed) call to every might_sleep() check.

I still disagree with this one violently.  If you want a cond_resched()
add it where nessecary, but don't hide it behind might_sleep - there
could be quite a lot might_sleeps in common codepathes and they should
stay purely a debug aid.

