Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWJCEB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWJCEB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWJCEB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:01:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24781 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932339AbWJCEB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:01:26 -0400
Date: Mon, 2 Oct 2006 21:00:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
Message-Id: <20061002210053.16e5d23c.akpm@osdl.org>
In-Reply-To: <20061001225720.115967000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches make my Vaio run really really slowly.  Maybe a quarter of
the normal speed or lower.  Bisection shows that the bug is introduced by
clockevents-drivers-for-i386.patch+clockevents-drivers-for-i386-fix.patch

With all patches applied, the slowdown happens with
CONFIG_HIGH_RES_TIMERS=n and also with CONFIG_HIGH_RES_TIMERS=y &&
CONFIG_NO_HZ=y.  So something got collaterally damaged.

I put various helpful stuff at http://userweb.kernel.org/~akpm/x/

I uploaded all the patches I was using to
http://userweb.kernel.org/~akpm/x/patches/

It doesn't seem to be a cpufreq thing: cpuinfo_min_freq=800kHz,
cpuinfo_max_freq=2GHz and cpuinfo_cur_freq goes up to 2GHz under load. 
Wall time is increasing at one second per second.


