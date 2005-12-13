Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVLMKNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVLMKNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVLMKNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:13:45 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:54175 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932600AbVLMKNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:13:44 -0500
Date: Tue, 13 Dec 2005 11:13:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213101300.GA2178@elte.hu>
References: <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22479.1134467689@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > We have atomic_cmpxchg. Can you use that for a sufficient generic
> > implementation?
> 
> No. CMPXCHG/CAS is not as available as XCHG, and it's also unnecessary.

take a look at the PREEMPT_RT implementation of mutexes: it uses 
cmpxchg(), and thus both the down() and the up() fastpath is lockless!  
(And that is a mutex type that does alot more things, as it supports 
priority inheritance.)

architectures which dont have cmpxchg can use a spinlock just fine.

	Ingo
