Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWDKBVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWDKBVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 21:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWDKBVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 21:21:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51881 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932131AbWDKBVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 21:21:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] coredump: kill ptrace related stuff
In-Reply-To: Oleg Nesterov's message of  Monday, 10 April 2006 17:35:52 +0400 <20060410133511.GA85@oleg>
X-Shopping-List: (1) Ardent squirrel ghost-melts
   (2) Inconvenient console winters
   (3) Coherent anarchic tensions
   (4) Inefficient companion rails
Message-Id: <20060411012109.4DB3A1809D1@magilla.sf.frob.com>
Date: Mon, 10 Apr 2006 18:21:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It turns out I misread SIGNAL_GROUP_EXIT check in ptrace_stop(),
> didn't notice '(->parent->signal != current->signal) ||' before
> it.

I thought that might have been it.

> Do you see any solution which doesn't need tasklist_lock to be
> held while traversing global process list?

Eh, kind of, but I'm not sure I want to get into it.  This only comes up in
a pathological case and we don't actually take the lock unless the weird
case really happened.  My inclination is to get the rest of the cleanups
and optimizations ironed out and merged in first.  Then we can revisit this
oddball case later on.

> > > 	3. Can't go to do_signal_stop() after return
> > > 	   from ptrace_stop() in get_signal_to_deliver()
> >
> > This is only true because of the check in get_signal_to_deliver,
> > which I've said I think should be taken out for other reasons.
>
> Yes, changelog refers to SIGNAL_GROUP_EXIT check in get_signal_to_deliver.
> However, do_signal_stop() returns 0 when it doesn't see SIGNAL_STOP_DEQUEUED,
> (which was cleared by SIGNAL_GROUP_EXIT), so I think we don't depend on
> SIGNAL_GROUP_EXIT check in get_signal_to_deliver. No?

Ah yes, you are right.  So there is no conflict with removing the check as
I want to do.


Thanks,
Roland
