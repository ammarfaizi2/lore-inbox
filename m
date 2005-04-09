Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVDISm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVDISm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVDISmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:42:25 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:6890 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261318AbVDISmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:42:22 -0400
Date: Sat, 9 Apr 2005 20:42:21 +0200 (CEST)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: Francois Romieu <romieu@fr.zoreil.com>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <dipankar@in.ibm.com>, <antonb@au1.ibm.com>, <davej@codemonkey.org.uk>,
       <hpa@zytor.com>, <len.brown@intel.com>, <andmike@us.ibm.com>,
       <rth@twiddle.net>, <rusty@au1.ibm.com>, <schwidefsky@de.ibm.com>,
       <jgarzik@pobox.com>
Subject: Re: [RFC,PATCH 3/4] Change synchronize_kernel to _rcu and _sched
In-Reply-To: <20050409122045.GA6073@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.44.0504092039280.20335-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, Francois Romieu wrote:

> Manfred Spraul <manfred@colorfullife.com> :
> > [Jeff added to cc list - it's a network driver question]
> [...]
> > I haven't read the whole driver, but what about
> > 	spin_unlock_wait(&dev->xmit_lock);
> > ?
>
> The race here is a dev->close() against dev->hard_start_xmit() one where
> dev->hard_start_xmit() does not do any locking at all.
>
I always thought that all callers of dev->hard_start_xmit() acquire
dev->xmit_lock before calling hard_start_xmit().

Is that assumption wrong? I think I even rely on that in one of my
drivers.

--
	Manfred

