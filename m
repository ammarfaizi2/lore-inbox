Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWE3HrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWE3HrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 03:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWE3HrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 03:47:10 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:22929 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932179AbWE3HrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 03:47:09 -0400
Date: Tue, 30 May 2006 09:47:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530074729.GA26458@elte.hu>
References: <20060529212109.GA2058@elte.hu> <1148964741.7704.10.camel@homer> <1148970941.3636.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148970941.3636.13.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> > Darn.  It said all tests passed, then oopsed.
>
> does this fix it?
> 
> type->name can be NULL legitimately; all places but one check for this 
> already. Fix this off-by-one.

that used to be the case, but shouldnt happen anymore - with current 
lockdep code we always pass some string to the lock init code. (that's 
what lock-init-improvement.patch achieves in essence.) Worst-case the 
string should be "old_style_spin_init" or "old_style_rw_init".

So Mike please try the other patch i sent - it also adds a debugging 
check so that we can see where that NULL name comes from. It could be 
something benign like me forgetting to pass in a string somewhere in the 
initialization macros, but it could also be something more nasty like an 
initialize-by-memset assumption.

	Ingo
