Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWGLVUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWGLVUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWGLVUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:20:30 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59017 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932455AbWGLVUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:20:30 -0400
Date: Wed, 12 Jul 2006 23:14:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <rdreier@cisco.com>
Cc: akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>,
       Zach Brown <zach.brown@oracle.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
Message-ID: <20060712211443.GA10944@elte.hu>
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com> <44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com> <20060712093820.GA9218@elte.hu> <adaveq2v9gn.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaveq2v9gn.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland Dreier <rdreier@cisco.com> wrote:

> Currently, the code in lib/idr.c uses a bare spin_lock(&idp->lock) to 
> do internal locking.  This is a nasty trap for code that might call 
> idr functions from different contexts; for example, it seems perfectly 
> reasonable to call idr_get_new() from process context and idr_remove() 
> from interrupt context -- but with the current locking this would lead 
> to a potential deadlock.
> 
> The simplest fix for this is to just convert the idr locking to use 
> spin_lock_irqsave().
> 
> In particular, this fixes a very complicated locking issue detected by 
> lockdep, involving the ib_ipoib driver's priv->lock and 
> dev->_xmit_lock, which get involved with the ib_sa module's 
> query_idr.lock.
> 
> Cc: Arjan van de Ven <arjan@infradead.org>
> Cc: Ingo Molnar <mingo@elte.hu>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
