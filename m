Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbTFSSYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbTFSSYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:24:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10481 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265883AbTFSSYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:24:16 -0400
Subject: Re: [patch] setscheduler fix
From: Robert Love <rml@tech9.net>
To: Joe Korty <joe.korty@ccur.com>
Cc: george anzinger <george@mvista.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>
In-Reply-To: <20030619182057.GA1228@rudolph.ccur.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com>
	 <3EF1DE35.20402@mvista.com> <20030619171950.GA936@rudolph.ccur.com>
	 <1056044732.8770.39.camel@localhost>
	 <20030619182057.GA1228@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1056047890.1066.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 19 Jun 2003 11:38:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 11:20, Joe Korty wrote:

> Looks good to me.

Good.

> migration_thread and try_to_wake_up already have a simplier version of
> your test that seems to be correct for that environment, so no change
> is needed there.
> 
> wake_up_forked_process in principle might need your patch, but as it
> appears to be called only from boot code it is unimportant that it
> have the lowest possible latency, so no change is needed there either.

Agreed.

This is worse than just a latency issue, by the way. Imagine if a
FIFO/50 thread promotes a FIFO/40 thread to FIFO/60. The thread should
run immediately (because, at priority 60, it is the highest), but it may
not until the FIFO/50 thread completes.

	Robert Love

