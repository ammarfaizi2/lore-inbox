Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVJRATj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVJRATj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVJRATj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:19:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25846 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP
	id S1751425AbVJRATi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:19:38 -0400
Date: Mon, 17 Oct 2005 17:19:34 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <20051017160536.GA2107@elte.hu>
Message-ID: <Pine.LNX.4.10.10510171713420.26804-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The clocksource_lock should be a raw because it's locked with the raw lock
system_time_lock held, and interrupts are off . So it could sleep with
interrupts disabled. I just compile tested this, but I think it should be
fine .

Daniel

Index: linux-2.6.13/kernel/time/clocksource.c
===================================================================
--- linux-2.6.13.orig/kernel/time/clocksource.c
+++ linux-2.6.13/kernel/time/clocksource.c
@@ -46,7 +46,7 @@ extern struct clocksource clocksource_ji
 static struct clocksource *curr_clocksource = &clocksource_jiffies;
 static struct clocksource *next_clocksource;
 static LIST_HEAD(clocksource_list);
-static DECLARE_SEQLOCK(clocksource_lock);
+static DECLARE_RAW_SEQLOCK(clocksource_lock);
 
 static char override_name[32];
 



