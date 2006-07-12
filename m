Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWGLJoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWGLJoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWGLJoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:44:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26287 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751063AbWGLJoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:44:15 -0400
Date: Wed, 12 Jul 2006 11:38:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <rdreier@cisco.com>
Cc: Zach Brown <zach.brown@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] ipoib lockdep warning
Message-ID: <20060712093820.GA9218@elte.hu>
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com> <44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adasll7zp0p.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5008]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland Dreier <rdreier@cisco.com> wrote:

> Hmm, good point.
> 
> It sort of seems to me like the idr interfaces are broken by design.
[...]

> So, ugh... maybe the best thing to do is change lib/idr.c to use 
> spin_lock_irqsave() internally?

i agree that the IDR subsystem should be irq-safe if GFP_ATOMIC is 
passed in. So the _irqsave()/_irqrestore() fix should be done.

But i also think that you should avoid using GFP_ATOMIC for any sort of 
reliable IO path and push as much work into process context as possible. 
Is it acceptable for your infiniband IO model to fail with -ENOMEM if 
GFP_ATOMIC happens to fail, and is the IO retried transparently?

	Ingo
