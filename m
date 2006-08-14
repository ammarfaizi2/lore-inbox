Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751986AbWHNLPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbWHNLPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWHNLPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:15:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751986AbWHNLPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:15:10 -0400
Subject: Re: [PATCH] Fix potential deadlock in mthca
From: Ingo Molnar <mingo@redhat.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Roland Dreier <rdreier@cisco.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44DCAD34.5040502@linux.intel.com>
References: <adad5b7ntyh.fsf@cisco.com>  <44DCAD34.5040502@linux.intel.com>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 13:07:51 +0200
Message-Id: <1155553671.22848.38.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 09:15 -0700, Arjan van de Ven wrote:
> Roland Dreier wrote:
> > Here's a long-standing bug that lockdep found very nicely.
> > 
> > Ingo/Arjan, can you confirm that the fix looks OK and I am using
> > spin_lock_nested() properly?  I couldn't find much documentation or
> > many examples of it, so I'm not positive this is the right way to
> > handle this fix.
> > 
> 
> looks correct to me;
> 
> Acked-by: Arjan van de Ven <arjan@linux.intel.com>

looks good to me too.

Acked-by: Ingo Molnar <mingo@elte.hu>

btw., we could introduce a new spin-lock op: 

	spin_lock_double(l1, l2);
	...
	spin_unlock_double(l1, l2);

because some other code, like kernel/sched.c, fs/dcache.c and
kernel/futex.c uses quite similar locking.

	Ingo

