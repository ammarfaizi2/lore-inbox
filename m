Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWI3Itc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWI3Itc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWI3Itc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:49:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751168AbWI3Ita (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:49:30 -0400
Date: Sat, 30 Sep 2006 01:45:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 20/23] add /proc/sys/kernel/timeout_granularity
Message-Id: <20060930014541.9674fe79.akpm@osdl.org>
In-Reply-To: <20060929234441.113265000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234441.113265000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:39 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> Introduce timeout granularity: process timer wheel timers every
> timeout_granularity jiffies. Defaults to 1 (process timers HZ times
> per second - most finegrained).
> 
> ...
>
> +	timeout_granularity=
> +			[KNL]
> +			Timeout granularity: process timer wheel timers every
> +			timeout_granularity jiffies. Defaults to 1 (process
> +			timers HZ times per second - most finegrained).
> +

Please do not expose HZ to userspace in this fashion.  It means that an
application which was developed and tested on a 1000Hz kernel might fail on a
250Hz kernel.

