Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWILU5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWILU5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWILU5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:57:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5355 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030221AbWILU5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:57:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060912205107.GF19707@waste.org> 
References: <20060912205107.GF19707@waste.org>  <20060912174339.GA19707@waste.org> <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> <15193.1158088232@warthog.cambridge.redhat.com> 
To: Matt Mackall <mpm@selenic.com>
Cc: David Howells <dhowells@redhat.com>, Aubrey <aubreylee@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Sep 2006 21:56:46 +0100
Message-ID: <6495.1158094606@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:

> > > You just broke the bit that shrinks the arena.
> > 
> > How?  This is only called once when things are being initialised.  There can
> > be no SLOB objects allocated prior to that point.
> 
> It's on a timer.

So what then?  The timer is still initialised:

	void kmem_cache_init(void)
	{
	+#if 0
		void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);

		if (p)
			free_page((unsigned long)p);
	+#endif

		mod_timer(&slob_timer, jiffies + HZ);
	}

David
