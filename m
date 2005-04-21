Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVDUIdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVDUIdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVDUIcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:32:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:59565 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261482AbVDUHyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:54:40 -0400
Message-ID: <42675C2F.2030500@suse.de>
Date: Thu, 21 Apr 2005 09:54:23 +0200
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@suse.cz>, Frank Sorenson <frank@tuxrocks.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
       Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1 - C-state measures
References: <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com> <42651C38.6090807@suse.de> <20050419210958.GE25328@elf.ucw.cz> <20050420200109.GE16352@atomide.com>
In-Reply-To: <20050420200109.GE16352@atomide.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren wrote:
> * Pavel Machek <pavel@suse.cz> [050419 14:10]:
>>Hi!
>>
>>>The machine is a Pentium M 2.00 GHz, supporting C0-C4 processor power states.
>>>The machine run at 2.00 GHz all the time.
>>..
>>>_passing bm_history=0xFFFFFFFF (default) to processor module:_
>>>
>>>Average current the last 470 seconds: *1986mA* (also measured better
>>>values ~1800, does battery level play a role?!?)
>>Probably yes. If voltage changes, 2000mA means different ammount of power.
> 
> Thomas, thanks for doing all the stats and patches to squeeze some
> real power savings out of this! :)
> 
> We should display both average mA and average Watts with pmstats.
> BTW, I've posted Thomas' version of pmstats as pmstats-0.2.gz to
> muru.com also.
> 
>>>(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/1000_HZ_bm_history_FFFFFFFF)
>>>
>>>
>>>_passing bm_history=0xFF to processor module:_
>>>
>>>Average current the last 190 seconds: *1757mA*
>>>(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/1000_HZ_bm_history_FF)
>>>(Usage count could be bogus, as some invokations could not succeed
>>>if bm has currently been active).
>>Ok.
>>
>>>idle_ms == 100, bm_promote_bs == 30
>>>Average current the last 80 seconds: *1466mA*
>>>(cmp.
>>>ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/tony_dyn_tick_processor_idle_100_bm_30)
>>Very nice indeed. That seems like ~5W saved, right? That might give
>>you one more hour of battery life....
> 
> Depending on your battery capacity. But looking at the average Watts
> on the first 8 lines of the two stats above:
> 
> 1000_HZ_bm_history_FFFFFFFF:
> (21.43 + 23.32 + 23.32 + 21.71 + 21.71 + 23.84 + 23.84 + 22.62) / 8
> = 22.724W
> 
> tony_dyn_tick_processor_idle_100_bm_30:
> (16.07 + 16.07 + 16.00 + 16.00 + 16.08 + 16.08 + 16.29 + 16.29) / 8
> = 16.11W
> 
> And then comparing these two:
> 22.72 / 16.11 = 1.4103
> 
> So according to my calculations this should provide about 1.4 times
> longer battery life compared to what you were getting earlier...
> That is assuming system is mostly idle, of course.
> 
Be aware that speedstep was off (2.0 GHz). When CPU frequency is controlled
you won't have that much enhancement anymore ...

       Thomas
