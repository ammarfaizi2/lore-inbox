Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946144AbWKJJVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946144AbWKJJVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946145AbWKJJVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:21:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30393 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946144AbWKJJVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:21:01 -0500
Subject: Re: [patch 02/19] hrtimers: clean up callback tracking
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061109233034.296218000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233034.296218000@cruncher.tec.linutronix.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 10:20:58 +0100
Message-Id: <1163150458.3138.610.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 23:38 +0000, Thomas Gleixner wrote:
> plain text document attachment
> (hrtimers-clean-up-callback-tracking.patch)
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Reintroduce ktimers feature "optimized away" by the ktimers review process:
> remove the curr_timer pointer from the cpu-base and use the hrtimer state.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Index: linux-2.6.19-rc5-mm1/include/linux/hrtimer.h
> ===================================================================
> --- linux-2.6.19-rc5-mm1.orig/include/l
> -		if (unlikely(base->cpu_base->curr_timer == timer))
> +		if (unlikely(timer->state & HRTIMER_STATE_CALLBACK))
>  			return base;

this also could use the hrtimer_is_running() inline from the [01/19]
review


otherwise looks ok:

Acked-by: Arjan van de Ven <arjan@linux.intel.com>

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

