Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269531AbUICB2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269531AbUICB2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269497AbUICBYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:24:48 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:2441 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269522AbUICBW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:22:27 -0400
Subject: Re: [RFC&PATCH] Alternative RCU implementation
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Manfred Spraul <manfred@colorfullife.com>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       rusty@rustcorp.com.au
In-Reply-To: <41378EB9.2060508@colorfullife.com>
References: <m3brgwgi30.fsf@new.localdomain>
	 <20040830004322.GA2060@us.ibm.com>
	 <1093886020.984.238.camel@new.localdomain>
	 <20040830185223.GF1243@us.ibm.com>
	 <1093922569.1003.159.camel@new.localdomain>
	 <20040901035350.GH1241@us.ibm.com>
	 <1094043719.986.51.camel@new.localdomain>
	 <20040902163854.GC1258@us.ibm.com>
	 <1094151272.985.103.camel@new.localdomain>
	 <41378EB9.2060508@colorfullife.com>
Content-Type: text/plain
Organization: 
Message-Id: <1094174357.985.169.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 02 Sep 2004 21:19:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 17:20, Manfred Spraul wrote:
> Jim Houston wrote:
> 
> >We add the following /proc files:
> >/proc/shield/ltmrs
> >	Setting a bit limits the use of local timers on the 
> >	corresponding cpu.
> >
> How do you handle schedule_delayed_work_on()?
> slab uses it to drain the per-cpu caches. It's not fatal if a cpu 
> doesn't drain it's caches (just some wasted memory), but it should be 
> documented.

Hi Manfred,

The timer shielding migrates most of the timers to non-shielded cpus
but does keep track of timers queued with add_timer_on().  These
are polled periodically from a non-shielded cpu, and an inter-processsor
interrupt is used to force the shielded cpu to handle their expiry.

Jim Houston - Concurrent Computer Corp.


