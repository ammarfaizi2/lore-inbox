Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUJRH31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUJRH31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 03:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUJRH31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 03:29:27 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:59879 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S263770AbUJRH3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 03:29:23 -0400
Date: Mon, 18 Oct 2004 09:20:45 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Alexander Clouter <alex-kernel@digriz.org.uk>
Cc: venkatesh.pallipadi@intel.com, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041018072045.GA17164@dominikbrodowski.de>
Mail-Followup-To: Alexander Clouter <alex-kernel@digriz.org.uk>,
	venkatesh.pallipadi@intel.com, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20041017222916.GA30841@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017222916.GA30841@inskipp.digriz.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 17, 2004 at 11:29:16PM +0100, Alexander Clouter wrote:
> After playing with the cpufreq_ondemand governor (many thanks to those whom 
> made it) I made a number of alterations which suit me at least.  Really 
> looking for feedback and of course once people have fixed any bugs they find 
> and made the code look neater, possible inclusion?

Or possibly a "fork" -- different dynamic cpufreq governors aren't a bad
thing to have. Else the whole modular approach would be wrong... So, even
if it doesn't get merged into cpufreq_ondemand, you can maintain it as a
differently named cpufreq governor.


> 2. controllable through 
> 	/sys/.../ondemand/ignore_nice, you can tell it to consider 'nice' 
> 	time as also idle cpu cycles.  Set it to '1' to treat 'nice' as cpu 
> 	in an active state.

Interesting bit, IIRC some userspace tool also does that.

> 4. (minor) I changed DEF_SAMPLING_RATE_LATENCY_MULTIPLIER to 50000 and
> 	DEF_SAMPLING_DOWN_FACTOR to 5 as I found the defaults a bit annoying 
> 	on my system and resulted in the cpufreq constantly jumping.
> 
> 	For my patch it works far better if the sampling rate is much lower 
> 	anyway, which can only be good for cpu efficiency in the long run

However, this means it takes much longer for the system to react to changes
in load... it's a tricky issue.

> 6. debugging (with 'watch -n1 cat /sys/.../ondemand/requested_freq') and 
> 	backwards 'compatibility' to act like the 'userspace' governor is 
> 	avaliable with /sys/.../ondemand/requested_freq if 
> 	'freq_step_percent' is set to zero

Please don't do that. Userspace is the governor for userspace frequency
setting; if you want it, switch to userspace, if you want dynamic frequency
selection, use the original ondemand or your governor.

	Dominik
