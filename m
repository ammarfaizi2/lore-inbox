Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVLUXNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVLUXNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVLUXNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:13:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:15491 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932323AbVLUXNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:13:10 -0500
Date: Thu, 22 Dec 2005 00:12:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 3/3] mutex subsystem: move the core to the new atomic helpers
Message-ID: <20051221231218.GA6747@elte.hu>
References: <20051221155411.GA7243@elte.hu> <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain>
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


* Nicolas Pitre <nico@cam.org> wrote:

> This patch moves the core mutex code over to the atomic helpers from 
> previous patch.  There is no change for i386 and x86_64, except for 
> the forced unlock state that is now done outside the spinlock (doing 
> so doesn't matter since another CPU could have locked the mutex right 
> away even if it was unlocked inside the spinlock).  This however 
> brings great improvements on ARM for example.

i'm wondering how much difference it makes on ARM - could you show us 
the before and after disassembly of the fastpath, to see the 
improvement?

your patches look OK to me, only one small detail sticks out: i'd 
suggest to rename the atomic_*_contended macros to be arch_mutex_*_..., 
i dont think any other code can make use of it. Also, it would be nice 
to see the actual ARM patches as well, which make use of the new 
infrastructure.

could you resend them against my latest queue that i just posted? I'll 
look at integrating them tomorrow.

	Ingo
