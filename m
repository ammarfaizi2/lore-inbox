Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269624AbUICKIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269624AbUICKIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269658AbUICKHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:07:31 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:35579 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S269624AbUICKGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:06:24 -0400
Date: Fri, 3 Sep 2004 11:54:35 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george@mvista.com, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       len.brown@intel.com, davidm@hpl.hp.com, ak@suse.de, paulus@samba.org,
       schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
Message-ID: <20040903095435.GA11572@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
	george@mvista.com, albert@users.sourceforge.net,
	Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
	len.brown@intel.com, davidm@hpl.hp.com, ak@suse.de, paulus@samba.org,
	schwidefsky@de.ibm.com, jimix@us.ibm.com,
	keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
	Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for this exciting code. A few questions:

- Where do you intend to put the "delay" code to? Generalize it as well?

- cpufreq hooks to tsc.c and i386_tsc.c[*] can easily be added. For them to
  work _better_ than current code: can timeofday_hook() be called (with IRQs
  disabled) _anywhen_ from kernel context? 
   [*] actually, only one of them needs the notifier, AFAICS...

- what about keeping lower-priority timesources still "active" in some sort to
  a) enable loading _and_ unloading timsources (even modularizing them
	becoms possible which should make testing easier...),
  b) call them every couple of seconds to verify the currently used
	timesource is still sane (and if not, call cpufreq_delayed_get() for
	example or disable the timesource). This would mean that e.g. pmtmr 
	and pit can be used to "verify" and "backup" tsc, or otherwise... 
	The "clock=tsc" override would only affect the priority of the 
	timesource then, making it so large that no other timesource can 
	"preempt" it, but doesn't avoid making other timesources available
	for backup and verification purposes.

Thanks,

	Dominik
