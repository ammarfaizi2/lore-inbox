Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWGEKwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWGEKwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWGEKwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:52:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:64392 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932418AbWGEKwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:52:18 -0400
Date: Wed, 5 Jul 2006 12:47:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705104744.GA24284@elte.hu>
References: <20060705084914.GA8798@elte.hu> <20060705023120.2b70add6.akpm@osdl.org> <20060705093259.GA11237@elte.hu> <20060705103756.GA5456@infradead.org> <20060705034441.a123ca7a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705034441.a123ca7a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5020]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > > shrinks fs/select.o by eight bytes.  (More than I expected).  So 
> > > > it does appear to be a space win, but a pretty slim one.
> > > 
> > > there are 855 calls to these functions in the allyesconfig vmlinux 
> > > i did, and i measured a combined size reduction of 34791 bytes. 
> > > That averages to a 40 bytes win per call site. (on i386.)
> > 
> > And more importantly it's a function that's called in slowpathes per 
> > definition.  So saving text sounds like a good idea, how minimal it 
> > may be.
> 
> Well yes - as I said, it's a net win.  But 31 bytes per callsite seems 
> weird and makes one wonder what's going on.

that's how big those instructions are roughly, while with the function 
call we likely have those parameters in registers already, mitigating 
some of the function-call overhead. (these tests were done with REGPARM 
turned on)

some of the assignments are also indirect, necessiating further loads, 
such as:

    INIT_LIST_HEAD(&q->task_list);

i roughly expected a net uninlining win of roughly this magnitude.

	Ingo
