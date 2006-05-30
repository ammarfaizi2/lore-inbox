Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWE3UEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWE3UEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWE3UEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:04:50 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:11199 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932445AbWE3UEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:04:49 -0400
Date: Tue, 30 May 2006 22:05:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, -rc5-mm1] lock validator: disable NMI watchdog if CONFIG_LOCKDEP, i386
Message-ID: <20060530200509.GA24928@elte.hu>
References: <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer> <1148990725.8610.1.camel@homer> <20060530120641.GA8263@elte.hu> <1148991422.8610.8.camel@homer> <20060530121952.GA9625@elte.hu> <1148992098.8700.2.camel@homer> <20060530122950.GA10216@elte.hu> <p73mzcz1g0h.fsf@verdi.suse.de> <20060530194748.GC22742@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530194748.GC22742@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> yeah, totally agreed, they need to be raw notifiers. Havent had time 
> to investigate it in detail yet - i went for the easier hack of 
> disabling NMIs while lockdep is enabled.

hm ... atomic_notifier_call_chain ought to be fine - it uses 
rcu_read_lock(), which uses preempt_disable(), which is NMI-safe.

so i think this NMI problem might be lockdep-specific. I think it might 
be the NMI iret that confuses lockdep. (and irqflags-trace in 
particular)

	Ingo
