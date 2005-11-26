Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVKZPL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKZPL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 10:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVKZPL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 10:11:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30164 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932250AbVKZPLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 10:11:25 -0500
Date: Sat, 26 Nov 2005 16:11:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/13] Time: x86-64 Conversion to Generic Timekeeping
Message-ID: <20051126151114.GA14570@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013628.18537.58457.sendpatchset@cog.beaverton.ibm.com> <20051126145528.GJ12999@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126145528.GJ12999@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> - clean up timeofday-arch-x86-64-part1.patch

the addon patch below is needed as well, to get x64 build and boot.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/x86_64/kernel/time.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -1134,6 +1134,18 @@ static cycle_t read_tsc_c3(void)
 
 #endif /* CONFIG_PARANOID_GENERIC_TIME */
 
+static struct clocksource clocksource_tsc = {
+	.name			= "tsc",
+	.rating			= 300,
+	.read			= read_tsc,
+	.vread			= vread_tsc,
+	.mask			= (cycle_t)-1,
+	.mult			= 0, /* to be set */
+	.shift			= 22,
+	.update_callback	= tsc_update_callback,
+	.is_continuous		= 1,
+};
+
 static int tsc_update_callback(void)
 {
 	int change = 0;
