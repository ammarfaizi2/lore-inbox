Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVAaWiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVAaWiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVAaWiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:38:16 -0500
Received: from fmr15.intel.com ([192.55.52.69]:55213 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261410AbVAaWiE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:38:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpufreq_(ondemand|conservative)
Date: Mon, 31 Jan 2005 14:37:51 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003E65C4B@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpufreq_(ondemand|conservative)
Thread-Index: AcUBXDoJ8EEStrgbSMi2/T/hhJmKkgGiG59A
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Alexander Clouter" <alex@digriz.org.uk>, <linux@dominikbrodowski.de>
Cc: <linux-kernel@vger.kernel.org>, <cpufreq@ZenII.linux.org.uk>
X-OriginalArrivalTime: 31 Jan 2005 22:37:52.0913 (UTC) FILETIME=[802AF010:01C507E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alex,

Sorry for the late reply. Neat work splitting up all these patches. 

>5) cpufreq_ondemand-2.6.11-rc1-mm1-05_safe_down_skip.diff
>	although I have not noticed any problems without it 
>being done a 
>	little alarm bell fires off in my head about how 
>down_skip really 
>	should be initialised (what if the cpu-freq is not at a 
>minimum when 
>	we start off or ac power is unplugged and we get 
>policy->min changing 
>	to a lower value?).  Again a minor patch, if not worth 
>it obviously 
>	it can be removed and should also be from cpufreq_conservative

I don't think this patch is required as you are initializing a static
variable. They should be zero without initialization as well.

All patches except the above looks good and ready to go. Can you send
them individually to cpufreq list, with Signed-off line.

Thanks,
Venki 
 

>-----Original Message-----
>From: Alexander Clouter [mailto:alex@digriz.org.uk] 
>Sent: Sunday, January 23, 2005 7:00 AM
>To: linux@dominikbrodowski.de; Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org; cpufreq@ZenII.linux.org.uk
>Subject: [PATCH] cpufreq_(ondemand|conservative)
>
>Hi All,
>
>Well after Dominik reminded me about the updates to 
>cpufreq_ondemand I had
>made some time back and also my cpufreq governor called 
>cpufreq_conservative,
>I dug out my coffee and started fixing them up for another 
>round of peer
>review.  My governor is pretty much a minor rewrite of the 
>cpufreq_ondemand
>governor but instead gracefully increases and decreases the 
>cpufreq which
>should make it much more suitable for battery power environments.
>
>All the patches are for 2.6.11-rc1-mm1 but also apply cleanly to
>2.6.11-rc1-mm2.  Unfortunately 2.6.11-rc1-mm2 oops'es in key_scancode
>(drivers/char/keyboard.c) when I presses any keys on my text 
>console (tty1)
>after init has loaded so I am waiting till 2.6.11-rc2-mm1 
>appears before I
>file a bug report.
>
>The 'improvements' I have made to cpufreq_ondemand are:
>
>1) cpufreq_ondemand-2.6.11-rc1-mm1-01_ignore-nice.diff
>	this adds a new parameter in /sys called
>	/sys/.../cpufreq/ondemand/ignore_nice which by default 
>is set to '0'.
>	Any 'nice' tasks running will be considered as idle 
>time unless you 
>	set the value in ignore_nice to '1', then it will be simply 
>	considered as a regular cpu time sucking program.
>
>	Last time I did this Venki mentioned some possible corner case 
>	conditions[1] and so this time I make it recalculate 
>the idle times 
>	when the value of ignore_nice is flipped.  If I am 
>right this should 
>	fix any possible issues that would have arisen from this...?
>
>2) cpufreq_ondemand-2.6.11-rc1-mm1-02_check-rate-and-break-out.diff
>	a very simple patch which prevents us from changing the 
>cpufreq from 
>	'x' to 'x' un-necessarily.  No-one could find any 
>problems with this 
>	so it has pretty much remained untouched.
>
>3) cpufreq_ondemand-2.6.11-rc1-mm1-03_sys_freq_step.diff
>	this feature also adds a new parameter in /sys called
>	/sys/.../cpufreq/ondemand/freq_step which by default is 
>set to '5'.  
>	You can change this to any value between '0' (why?) and 
>'100' to 
>	alter how much the cpu will change its frequency by on 
>the way down.
>
>4) cpufreq_ondemand-2.6.11-rc1-mm1-04_ignore_steal.diff
>	I noticed a new cpustat has appeared called 'steal'[2] 
>which from 
>	what I can tell should be treated like an iowait stat.  
>'steal' only 
>	seems supported by S/390 but I think it should be 
>'considered'.  This 
>	is a minor patch and if I have gotten confused then 
>obviously it 
>	should be removed (and from cpufreq_conservative)
>
>5) cpufreq_ondemand-2.6.11-rc1-mm1-05_safe_down_skip.diff
>	although I have not noticed any problems without it 
>being done a 
>	little alarm bell fires off in my head about how 
>down_skip really 
>	should be initialised (what if the cpu-freq is not at a 
>minimum when 
>	we start off or ac power is unplugged and we get 
>policy->min changing 
>	to a lower value?).  Again a minor patch, if not worth 
>it obviously 
>	it can be removed and should also be from cpufreq_conservative
>
>Now cpufreq_conservative started off as a copy of 
>cpufreq_ondemand with all
>the above patches and then amended from there.  If you install 
>the patches
>you can see with a diff (attached for _show_ and not use) that 
>there is not
>much in the way of difference between them.  It works by me 
>creating and
>initialising an array to each cpu's policy->cur (this could 
>should be nice in 
>an SMP environment, bug reports would be appreciated) and then 
>changing the 
>contents by freq_step each time we need to increase or 
>decrease the cpufreq.  
>This results in a smoother transition on the way up and down.  
>Also by the 
>nature of this governor it polls 100 times fewer than cpufreq_ondemand.
>
>Let me know what you think, the patches work for me, the 
>question is do they 
>work for you :)
>
>Cheers all
>
>Alex
>
>[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=110013659005496&w=2
>[2] http://marc.theaimsgroup.com/?l=linux-kernel&m=109888788719020&w=2
>
>-- 
> ________________________________________ 
>/ A foolish consistency is the hobgoblin \
>| of little minds.                       |
>|                                        |
>\ -- Ralph Waldo Emerson                 /
> ---------------------------------------- 
>        \   ^__^
>         \  (oo)\_______
>            (__)\       )\/\
>                ||----w |
>                ||     ||
>
