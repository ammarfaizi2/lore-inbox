Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWAPIV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWAPIV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWAPIV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:21:57 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:21385 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932247AbWAPIV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:21:56 -0500
Date: Mon, 16 Jan 2006 09:21:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       greg@kroah.com, zaitcev@redhat.com
Subject: Re: 2.6.15-mm4: sem2mutex problem in USB OHCI
Message-ID: <20060116082159.GA9744@elte.hu>
References: <200601150058.58518.rjw@sisk.pl> <20060114160526.228da734.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114160526.228da734.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> >  Badness in __mutex_trylock_slowpath at kernel/mutex.c:281
> > 
> >  Call Trace: <IRQ> <ffffffff80148d8d>{mutex_trylock+141}
> >
> >         <ffffffff880abaf0>{:ohci_hcd:ohci_hub_status_data+480}
> >         <ffffffff802d25d0>{rh_timer_func+0} <ffffffff802d24c3>{usb_hcd_poll_rh_status+67}
> >         <ffffffff802d25d0>{rh_timer_func+0} <ffffffff802d25d9>{rh_timer_func+9}
> >         <ffffffff8013a3cc>{run_timer_softirq+396}

> err, taking a mutex from softirq context.

btw., i'm wondering how the down_trylock() can be correct code: what 
guarantees progress if the trylock happens to fail all the time? (or 
just happens to fail frequently, due to some other, unrelated dev->mutex 
workload)

Shouldnt this code use some other solution to process these timed events 
more robustly?

	Ingo
