Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbUKQXOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbUKQXOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUKQXOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:14:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58051 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262669AbUKQXJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:09:55 -0500
Subject: Re: summary (Re: [patch] prefer TSC over PM Timer)
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@brodo.de,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <419BD0FF.4020602@mvista.com>
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
	 <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
	 <1100705495.32698.38.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0411170946410.9434@twinlark.arctic.org>
	 <419BD0FF.4020602@mvista.com>
Content-Type: text/plain
Date: Wed, 17 Nov 2004 15:09:43 -0800
Message-Id: <1100732984.3891.9.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 14:30 -0800, George Anzinger wrote:
> The APIC timer is again on a different "rock" which is not designed for time 
> keeping and, again, is calibrated at boot up against the "GOLD" standard PIT.
> 
> IMHO, the best time keeping we can get in and x86 box is to:
> 
> a) set up the PIT up to do the 1/HZ ticks (once set up we do not need to touch 
> it again so the I/O access issues become mute),
> 
> b) select either the TSC (if we think it is stable) or the pm_timer to do the 
> short term between tick interpolation and also to detect and correct for PIT 
> interrupt overrun (like we missed a tick or two).  We should prefer the TSC here 
> because of speed and that it is read every gettimeofday() access.

My only qualm here is that using the TSC to interpolate between timer
ticks allows for time inconsistencies. If the TSC isn't cumulatively
accurate, then when used in between ticks it will cause minor
inaccuracies and possible inconsistencies. I'd instead prefer picking a
single time source, and using NTP to correct for drift or inaccurate
calibration. 

Also breaking time subsystem from requiring regular periodic ticks
allows for tickless systems and additional power management savings. But
this should be saved for another thread. 

thanks
-john

