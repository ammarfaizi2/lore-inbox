Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWCZTUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWCZTUx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 14:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWCZTUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 14:20:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751123AbWCZTUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 14:20:53 -0500
Date: Sun, 26 Mar 2006 11:16:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org, simlo@phys.au.dk
Subject: Re: [patch] PI-futex: -V2
Message-Id: <20060326111645.3cf2c206.akpm@osdl.org>
In-Reply-To: <20060326160353.GA13282@elte.hu>
References: <20060325184612.GF16724@elte.hu>
	<20060325220728.3d5c8d36.akpm@osdl.org>
	<20060326160353.GA13282@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> > > +	for (;;) {
>  > > +		if (top_waiter)
>  > > +			plist_del(&top_waiter->pi_list_entry,
>  > > +				  &owner->pi_waiters);
>  > > +
>  > > +		if (waiter && waiter == rt_mutex_top_waiter(lock)) {
>  > 
>  > rt_mutex_top_waiter() can never return NULL, so the test for NULL 
>  > could be removed.
> 
>  it might be NULL if adjust_pi_chain() is called from remove_waiter(), 
>  and next_waiter there is NULL (because !rt_mutex_has_waiters() after the 
>  removal of the current waiter).

Yes, `waiter' might be NULL.  But rt_mutex_top_waiter() will never return
NULL.  So it might be possible to just do

	if (waiter == rt_mutex_top_waiter(lock))

Which might actually be less efficient, and more obscure.  Just pointing it
out.
