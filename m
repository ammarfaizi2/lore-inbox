Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269511AbUIZLgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269511AbUIZLgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 07:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269515AbUIZLgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 07:36:23 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:26558 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269511AbUIZLgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 07:36:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Sun, 26 Sep 2004 13:37:53 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200409251214.28743.rjw@sisk.pl> <200409261208.02209.rjw@sisk.pl> <20040926100955.GI10435@elf.ucw.cz>
In-Reply-To: <20040926100955.GI10435@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409261337.53298.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 of September 2004 12:09, Pavel Machek wrote:
> Hi!
> 
> > > > I've just tried to suspend my box and I must admit I've given up after 
30 
> > > > minutes (sic!) of waiting when there were only 12% of pages written to 
> > disk.  
> > > > Apparently, swsusp slows down to an unacceptable level after saying 
"PM: 
> > > > Writing image to disk".
> > > > 
> > > > The box is an Athlon 64-based notebook.  The .config is available at:
> > > > http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3.config
> > > > and the output of dmesg is available at:
> > > > http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3-dmesg.log
> > > 
> > > We have seen something similar after hdparm was used on specific
> > > machines. Are you using hdparm?
> > 
> > Not explicitly, but it's used by SuSE initscripts to set IDE DMA, AFAICS.  
> > However, the problem did not occur on 2.6.9-rc2-mm1 with the same 
> > initscripts.
> 
> Okay, so try what happens without the initscripts

I turned the stuff off but of course it didn't change anything. :-)

> and try to locate change that breaks it...

Well, I'm a bit confused:

--- linux-2.6.9-rc2-mm1/kernel/power/swsusp.c   2004-09-16 14:06:56.000000000 
+0200
+++ linux-2.6.9-rc2-mm3/kernel/power/swsusp.c   2004-09-24 11:35:18.000000000 
+0200
@@ -862,8 +862,8 @@
        error = swsusp_arch_suspend();
        /* Restore control flow magically appears here */
        restore_processor_state();
-       local_irq_enable();
        restore_highmem();
+       local_irq_enable();
        return error;
 }

What else should I look for?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
