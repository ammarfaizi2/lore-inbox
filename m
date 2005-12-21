Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVLUS1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVLUS1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLUS1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:27:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33967 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932491AbVLUS1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:27:09 -0500
Date: Wed, 21 Dec 2005 19:26:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
Message-ID: <20051221182622.GA8714@elte.hu>
References: <20051219013718.GA28038@elte.hu> <43A98101.364DB5CF@tv-sign.ru> <20051221155742.GA7375@elte.hu> <43A99618.6D6655C6@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A99618.6D6655C6@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> But why we can't add the waiter to ->wait_list _after_ xchg() ? What 
> makes the difference? Fastpath atomic op can happen before or after 
> xchg(), this is ok. Unlock path will look at ->wait_list only after 
> taking spinlock, at this time we already added this waiter to the 
> ->wait_list.
> 
> In other words: we are holding ->wait_lock, nobody can even look at 
> ->wait_list. We can add the waiter to ->wait_list before or after 
> atomic_xchg() - it does not matter.

hm, you are right - i've added this optimization.

	Ingo
