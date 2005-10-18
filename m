Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVJRGml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVJRGml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVJRGml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:42:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60591 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751100AbVJRGmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:42:40 -0400
Date: Tue, 18 Oct 2005 08:42:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051018064259.GA21236@elte.hu>
References: <20051017160536.GA2107@elte.hu> <Pine.LNX.4.10.10510171417220.24518-101000@godzilla.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10510171417220.24518-101000@godzilla.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> I found this latency ~5 minutes after boot up, no load . It looks like 
> vgacon_scroll() has a memset like operation which can grow.

do you have PRINTK_IGNORE_LOGLEVEL enabled? If yes then much of the 
printk code will run with interrupts disabled - hence non-preemptable.  
PRINTK_IGNORE_LOGLEVEL is a debugging feature for developers. I have 
added an extra explanation to the Kconfig, see below.

	Ingo

Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -18,6 +18,11 @@ config PRINTK_IGNORE_LOGLEVEL
 	  distributions disable kernel log messages during
 	  certain phases of system startup.)
 
+	  NOTE: this option also makes printk non-preemptible,
+	  which might improve the output of debugging info or
+	  crash info, but it might also cause latencies if your
+	  kernel is printk-ing alot.
+
 	  Normally you dont need or want this option.
 
 config DEBUG_KERNEL
