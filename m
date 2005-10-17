Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVJQTT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVJQTT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVJQTT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:19:26 -0400
Received: from mail-haw.bigfish.com ([12.129.199.61]:12677 "EHLO
	mail33-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750917AbVJQTT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:19:26 -0400
X-BigFish: V
Message-ID: <4353F936.3090406@am.sony.com>
Date: Mon, 17 Oct 2005 12:19:18 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: "Bird, Tim" <Tim.Bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, george@mvista.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0510171948040.1386@scrub.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Antivirus: Scanned by F-Prot Antivirus (http://www.f-prot.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> } > > Calling them "process timer" and "kernel timer" would include
> their main 
> } > > usage, although that also means ptimer were the more correct
> abbreviation.
> } > 
> } > As said before I think the disctinction between timers and timeouts
> } > makes perfectly sense and ktimers are _not_ restricted to process
> } > timers. 
> } 
> } "main usage" != "restricted to"
> 
> IOW I didn't say that "process timer" are restricted to processes, but 
> it's their intended main usage. "kernel timer" are OTOH the first choice
> 
> for any internal kernel time issues (which are not just timeouts).

Maybe for a more experienced kernel person such as
yourself, this distinction make sense.  But
"process timer" and "kernel timer" don't carry much
semantic value for me.  They seem to convey an
arbitrary expectation of usage patterns.  Maybe
they match the current usage patterns in the kernel,
but I'd prefer naming based on functionality or
behaviour of the API.


> There is of course a difference, but is it big enough that they deserve 
> different APIs?

IMHO yes.  I think having separate APIs will eventually be
beneficial to allow better handling of resolution
manipulation in the future.

For example, timeouts are likely to need less resolution,
and it may be valuable to adjust the resolution of timeouts
to support coalescing timeouts for better tickless operation.
(Driving towards better power management performance for
embedded devices.)

> Just look into <linux/timer.h> it doesn't mention timeout 
> once, but according to Thomas that's our "timeout API". Look at the 
> description of mod_timer() in timer.c: "modify a timer's timeout".
> It seems I'm not only one who thinks that both are closely related.

I'm not sure if you are arguing for renaming the
old API.  I would be in favor of this (from an abstract
perspective, to clarify the usage in the kernel), but
it might be too big a change right now.

Regards,
 -- Tim



=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

