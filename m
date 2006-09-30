Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWI3Ih4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWI3Ih4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWI3Ihz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:37:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbWI3Ihi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:37:38 -0400
Date: Sat, 30 Sep 2006 01:37:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 10/23] hrtimers: clean up locking
Message-Id: <20060930013712.15b0fa9a.akpm@osdl.org>
In-Reply-To: <20060929234439.950530000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234439.950530000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:29 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> improve kernel/hrtimers.c locking: use a per-CPU base with a lock to
> control locking of all clocks belonging to a CPU. This simplifies
> code that needs to lock all clocks at once. This makes life easier
> for high-res timers and dyntick. No functional change should happen
> due to this.
> 
> .. 
>
> -struct hrtimer_base;
> +struct hrtimer_clock_base;

It is better to place these forward declarations right at the top of the
include file.  That prevents people from later accidentally adding another
forward declaration of the same structure at an earlier point in the file,
and keeps all the same types of thing in the same place.

(two instances in this file)

> + * struct hrtimer_cpu_base - the per cpu clock bases
> + * @lock:		lock protecting the base and associated clock bases and timers

Looks crappy in 80-cols.  But I don't know if breaking this line will break
kerneldoc?

