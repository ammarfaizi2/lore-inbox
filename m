Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUACWIz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUACWIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:08:55 -0500
Received: from gprs214-230.eurotel.cz ([160.218.214.230]:51841 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264255AbUACWIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:08:54 -0500
Date: Sat, 3 Jan 2004 23:10:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-uv3 patch set released
Message-ID: <20040103221001.GB2775@elf.ucw.cz>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org> <Pine.LNX.4.58L.0312300935040.22101@logos.cnet> <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Anyway, in ide_wait_stat(), the "timeout" value is always either 
> "WAIT_DRQ" (5*HZ/100) or it is "WAIT_READY" (3*HZ/100). And look at 
> WAIT_READY a bit more: 
> 
> 	#if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
> 	#define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very slow */
> 	#else
> 	#define WAIT_READY      (3*HZ/100)      /* 30msec - should be instantaneous */
> 	#endif /* CONFIG_APM || CONFIG_APM_MODULE */
> 
> I bet that the _real_ problem is this. That "3*HZ/100" value is just too 
> damn short. It has already been increased to 5*HZ for anything that has 
> APM enabled, but anybody who doesn't use APM gets a _really_ short 
> timeout.
> 
> My suggestion: change the non-APM timeout to something much larger. Make
> it ten times bigger, rather than leaving it at a value that us so small
> that a single interrupt could make a difference..
> 
> In fact, right now a single timer interrupt on 2.4.x is the difference
> between waiting 20ms and 30ms. That's a _big_ relative difference.
> 
> Andrew - unless you disagree, I'd just be inlined to change both the DRQ
> and READY timeouts to be a bit larger. On working hardware it shouldn't
> matter, so how about just making them both be something like 100 msec (and
> leave that strange really big APM value alone).

I believe you should get rid of that CONFIG_APM. Its wrong. CONFIG_APM
no longer corresponds with "is laptop". You can have laptop with ACPI
etc.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
