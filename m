Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVLTEb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVLTEb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 23:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVLTEb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 23:31:56 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:33704 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750789AbVLTEbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 23:31:55 -0500
Date: Tue, 20 Dec 2005 05:31:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051220043109.GC32039@elte.hu>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com> <1135025932.4760.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135025932.4760.1.camel@localhost.localdomain>
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


* David Woodhouse <dwmw2@infradead.org> wrote:

> On Mon, 2005-12-19 at 09:49 -0800, Zwane Mwaikambo wrote:
> > Hi Ingo,
> >         Doesn't this corrupt caller saved registers?
> 
> Looks like it. I _really_ don't like calling functions from inline 
> asm. It's not nice. Can't we use atomic_dec_return() for this?

we can use atomic_dec_return(), but that will add one more instruction 
to the fastpath. OTOH, atomic_dec_return() is available on every 
architecture, so it's a really tempting thing. I'll experiment with it.

	Ingo
