Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVAHNXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVAHNXw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVAHNXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:23:51 -0500
Received: from gprs215-164.eurotel.cz ([160.218.215.164]:62336 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261163AbVAHNXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:23:14 -0500
Date: Sat, 8 Jan 2005 14:22:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>, David Shaohua <shaohua.li@intel.com>
Subject: Re: Patch 2/3: Reduce number of get_cmos_time_calls.
Message-ID: <20050108132258.GC7363@elf.ucw.cz>
References: <1105176732.5478.20.camel@desktop.cunninghams> <1105177184.5478.39.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105177184.5478.39.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Change sleep_start from signed to unsigned long. This appears to address
> an issue with the clock being occasionally off by around 1 hr 10
> minutes.

sleep_start is in seconds, right? I do not see how it could explain
1hr10 difference... Please do not apply this.

OTOH try this code (in userspace, run as root). It did strange thigs
to my time, and it is unrelated to swsusp. (But it does similar weird
things with interrupts).

pavel@amd:~$ cat misc/latency.c
void
main(void)
{
        int i;
        iopl(3);
        while (1) {
                asm volatile("cli");
                //              for (i=0; i<20000000; i++)
                for (i=0; i<1000000000; i++)
                        asm volatile("");
                asm volatile("sti");
                sleep(1);
        }
}
pavel@amd:~$

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
