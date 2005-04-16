Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVDPOXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVDPOXw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 10:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDPOXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 10:23:52 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:10746 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262667AbVDPOXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 10:23:50 -0400
Subject: Re: FUSYN and RT
From: Steven Rostedt <rostedt@goodmis.org>
To: john cooper <john.cooper@timesys.com>
Cc: Sven Dietrich <sdietrich@mvista.com>,
       "'Inaky Perez-Gonzalez'" <inaky@linux.intel.com>,
       robustmutexes@lists.osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, "'Esben Nielsen'" <simlo@phys.au.dk>
In-Reply-To: <42610DAC.5070506@timesys.com>
References: <000801c54230$73a0f940$c800a8c0@mvista.com>
	 <42610DAC.5070506@timesys.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 16 Apr 2005 10:23:05 -0400
Message-Id: <1113661385.4294.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-16 at 09:05 -0400, john cooper wrote:
> Sven Dietrich wrote:
[...]
> > This one probably should be a raw_spinlock. 
> > This lock is only held to protect access to the queues.
> > Since the queues are already priority ordered, there is
> > little benefit to ordering -the order of insertion-
> > in case of contention on a queue, compared with the complexity.
> 
> The choice of lock type should derive from both the calling
> context and the length of time the lock is expected to be held.
> 

In this case, I don't think time matters for choice of lock. Time
matters to keep it short since it does need the raw_spin_lock.  This
lock is part of the whole locking scheme, and would be similar to not
using raw_spin_locks in the implementation of rt_mutex.  Well, not
exactly the same, but if we want the fusyn code to use the same code as
rt_mutex for PI, then it will need to be a raw_spin_lock.

-- Steve


