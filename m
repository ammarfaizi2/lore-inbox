Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932889AbWF2LZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbWF2LZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbWF2LZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:25:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:9370 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932889AbWF2LZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:25:03 -0400
Date: Thu, 29 Jun 2006 13:24:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: <1151538084.5317.26.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606291316280.12900@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org> 
 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271212150.17704@scrub.home> 
 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> 
 <Pine.LNX.4.64.0606271903320.12900@scrub.home>  <Pine.LNX.4.64.0606271919450.17704@scrub.home>
  <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> 
 <1151453231.24656.49.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.64.0606281218130.12900@scrub.home>
 <1151538084.5317.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Jun 2006, john stultz wrote:

> I agree cpufreq changes could be the source. However, things still
> aren't making sense, since the accumulation is cycle based to begin
> with, so any cpufreq caused drift in time won't be noticed until NTPd
> starts adjusting the output from current_tick_len().

Indeed, AFAICT the clock should just run too fast, that leaves pretty much 
only the update function doing something I didn't expect.

> Vladis: I don't want to overwhelm you with patches to try, I think
> Roman's debug patches should help show where the issue is. But if you've
> got the time, try the patch below to quickly see if the cpufreq changes
> are indeed causing the problem.

Another change that might help: Valdis, could you add another call to 
printk_clock_info() at the end of update_wall_time() after 
clocksource_calculate_interval()?

> Hmm. Yea, while I'm not sure this is the issue at hand, it does look
> like I need to get some of the boot ordering worked out here. Using the
> PIT early on probably isn't the best solution as the 18us access latency
> might not be the best for the transition calibration.

Since it shouldn't be used much I don't think it matters and it could 
also be HPET, basically whoever provides the timer interrupt.

bye, Roman
