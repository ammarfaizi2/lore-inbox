Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVJROiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVJROiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVJROiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:38:22 -0400
Received: from mail2.utc.com ([192.249.46.191]:44501 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S1750769AbVJROiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:38:21 -0400
Message-ID: <4355029E.9050809@cybsft.com>
Date: Tue, 18 Oct 2005 09:11:42 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
References: <20051017160536.GA2107@elte.hu> <1129576885.4720.3.camel@cmn3.stanford.edu> <1129599029.10429.1.camel@cmn3.stanford.edu> <20051018072844.GB21915@elte.hu>
In-Reply-To: <20051018072844.GB21915@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------090506060007080500090605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090506060007080500090605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:

Ingo,

The attached patch is necessary to build -rt8 if high res timers are not
enabled.

-- 
   kr

--------------090506060007080500090605
Content-Type: text/x-patch;
 name="ktimerfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ktimerfix.patch"

--- linux-2.6.14-rc4/kernel/ktimers.c.orig	2005-10-18 08:25:10.000000000 -0500
+++ linux-2.6.14-rc4/kernel/ktimers.c	2005-10-18 09:05:36.000000000 -0500
@@ -1222,7 +1222,9 @@
 		printk("rem:       %u/%u\n",
 			rem.tv.sec, rem.tv.nsec);
 		printk("overrun:   %d\n", timer->overrun);
+#ifdef CONFIG_HIGH_RES_TIMERS
 		printk("getoffset: %p\n", base->getoffset);
+#endif
 		WARN_ON(1);
 	}
 }

--------------090506060007080500090605--
