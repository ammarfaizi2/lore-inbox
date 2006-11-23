Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757480AbWKWVtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757480AbWKWVtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757483AbWKWVtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:49:10 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:9383 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1757480AbWKWVtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:49:09 -0500
Date: Fri, 24 Nov 2006 00:49:08 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061123214908.GB106@oleg>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061123204054.GA4533@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123204054.GA4533@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23, Paul E. McKenney wrote:
>
>                            For general use, I believe that this has
> difficulties with the sequence of events I sent out on November 20th, see:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116397154808901&w=2
>
> ...
>
> I don't understand why an unlucky sequence of events mightn't be able
> to hang this __wait_event().  Suppose we did the atomic_dec_and_test(),
> then some other CPU executed xxx_read_unlock(), finding no one to awaken,
> then we execute the __wait_event()?

Please note how ->ctr[] is initialized,

	atomic_set(sp->ctr + 0, 1);	<---- 1, not 0
	atomic_set(sp->ctr + 1, 0);

atomic_read(sp->ctr + idx) == 0 means that this counter is inactive,
nobody use it.

Oleg.

