Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVFMRJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVFMRJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVFMRJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:09:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64174 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261423AbVFMRJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:09:27 -0400
Date: Mon, 13 Jun 2005 22:39:41 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
Message-ID: <20050613170941.GA1043@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610043018.GE18103@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,
        I went through the dynamic-tick patch on your website
(patch-dynamic-tick-2.6.12-rc6-050610-1) and was having some
questions about it:

1. dyn_tick->skip is set to the number of ticks that have
   to be skipped. This is set on the CPU which is the last
   (in online_map) to go idle and is based on when that
   CPU's next timer is set to expire.

   Other CPUs also seem to use the same interval
   to skip ticks. Shouldnt other CPU check their nearest timer
   rather than blindly skipping dyn_tick->skip number of ticks?

2. reprogram_apic_timer seems to reprogram the count-down
   APIC timer (APIC_TMICT) with an integral number of apic_timer_val.
   How accurate will this be? Shouldnt this take into account
   that we may not be reprogramming the timer on exactly "jiffy"
   boundary?

3. Is there any strong reason why you reprogram timers only when
   _all_ CPUs are idle?

4. In what aspects you think does your patch differ from VST (other
   than not relying on HRT!)?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
