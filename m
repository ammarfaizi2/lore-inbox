Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbUKQX2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbUKQX2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbUKQX0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:26:44 -0500
Received: from 2-227.coreds.net ([207.55.227.2]:25587 "EHLO data.mvista.com")
	by vger.kernel.org with ESMTP id S262577AbUKQXY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:24:29 -0500
Message-ID: <419BDD9D.7090200@mvista.com>
Date: Wed, 17 Nov 2004 15:24:13 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@brodo.de,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: summary (Re: [patch] prefer TSC over PM Timer)
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>	 <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>	 <1100705495.32698.38.camel@localhost.localdomain>	 <Pine.LNX.4.61.0411170946410.9434@twinlark.arctic.org>	 <419BD0FF.4020602@mvista.com> <1100732984.3891.9.camel@leatherman>
In-Reply-To: <1100732984.3891.9.camel@leatherman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2004-11-17 at 14:30 -0800, George Anzinger wrote:
> 
>>The APIC timer is again on a different "rock" which is not designed for time 
>>keeping and, again, is calibrated at boot up against the "GOLD" standard PIT.
>>
>>IMHO, the best time keeping we can get in and x86 box is to:
>>
>>a) set up the PIT up to do the 1/HZ ticks (once set up we do not need to touch 
>>it again so the I/O access issues become mute),
>>
>>b) select either the TSC (if we think it is stable) or the pm_timer to do the 
>>short term between tick interpolation and also to detect and correct for PIT 
>>interrupt overrun (like we missed a tick or two).  We should prefer the TSC here 
>>because of speed and that it is read every gettimeofday() access.
> 
> 
> My only qualm here is that using the TSC to interpolate between timer
> ticks allows for time inconsistencies. If the TSC isn't cumulatively
> accurate, then when used in between ticks it will cause minor
> inaccuracies and possible inconsistencies. I'd instead prefer picking a
> single time source, and using NTP to correct for drift or inaccurate
> calibration. 

I think the inconstistancies are of the order of micro seconds and so will not 
really show.  Not all systems are connected to an NTP server.  One possibility 
is to build in an ntp like thing that averages out the PIT ticks and refines the 
TSC count per tick thing over a much longer period.  This would drive the errors 
way down into the noise and it still honors the notion of the PIT being the 
STANDARD for time.
> 
> Also breaking time subsystem from requiring regular periodic ticks
> allows for tickless systems and additional power management savings. But
> this should be saved for another thread. 

Amen!
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

