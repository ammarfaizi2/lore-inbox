Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUIAARN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUIAARN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIAAO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:14:29 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:12261 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264261AbUIAAOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 20:14:01 -0400
Subject: Re: [RFC&PATCH] Alternative RCU implementation
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: dipankar@in.ibm.com
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040830173853.GB4639@in.ibm.com>
References: <m3brgwgi30.fsf@new.localdomain>
	 <20040830004322.GA2060@us.ibm.com>
	 <1093886020.984.238.camel@new.localdomain>
	 <20040830173853.GB4639@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093997450.4069.1.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 31 Aug 2004 20:10:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 13:38, Dipankar Sarma wrote:

> > I'm also trying to figure out if I need the call_rcu_bh() changes.
> > Since my patch will recognize a grace periods as soon as any 
> > pending read-side critical sections complete, I suspect that I
> > don't need this change.
> 
> Except that under a softirq flood, a reader in a different read-side
> critical section may get delayed a lot holding up RCU. Let me know
> if I am missing something here.

Hi Dipankar,

O.k.  That makes sense.  So the rcu_read_lock_bh(), rcu_read_unlock_bh()
and call_rcu_bh() would be the preferred interface.  Are there cases
where they can't be used?  How do you decide where to use the _bh 
flavor?

I see that local_bh_enable() WARNS if interrupts are disabled.  Is that
the issue?  Are rcu_read_lock()/rcu_read_unlock() ever called from 
code which disables interrupts?

Jim Houston - Concurrent Computer Corp.

