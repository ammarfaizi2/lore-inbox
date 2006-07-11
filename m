Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWGKXxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWGKXxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWGKXxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:53:31 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:16524 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932270AbWGKXxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:53:30 -0400
Message-ID: <44B439F7.3090008@oracle.com>
Date: Tue, 11 Jul 2006 16:53:27 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] ipoib lockdep warning
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com> <44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
In-Reply-To: <adasll7zp0p.fsf@cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Hmm, good point.
> 
> It sort of seems to me like the idr interfaces are broken by design.
> Internally, lib/idr.c uses bare spin_lock(&idp->lock) with no
> interrupt disabling or anything in both the idr_pre_get() and
> idr_get_new() code paths.

I wasn't thrilled to see that either.  We seem to have a fair precedent
(list.h, rbtree, etc) for leaving serialization to callers.

> So, ugh... maybe the best thing to do is change lib/idr.c to use
> spin_lock_irqsave() internally?

I dunno, it seems to have had _irq() locking in the past?  From the
comment at the top:

 * Modified by George Anzinger to reuse immediately and to use
 * find bit instructions.  Also removed _irq on spinlocks.

- z
