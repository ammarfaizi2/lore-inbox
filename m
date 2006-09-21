Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWIUIEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWIUIEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWIUIEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:04:04 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:44983 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751029AbWIUIEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:04:01 -0400
Date: Thu, 21 Sep 2006 01:04:35 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, rmk@arm.linux.org.uk,
       Kevin Hilman <khilman@mvista.com>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: 2.6.18-rt1
Message-ID: <20060921080435.GA29636@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920194650.GA21037@elte.hu>
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20 2006, at 21:46, Ingo Molnar was caught saying:
> 
> * Gene Heskett <gene.heskett@verizon.net> wrote:
> 
> > That looks like the chorus of the song I saw when it crashed on boot, 
> > pretty darned close to identical.
> 
> ok, i've uploaded -rt3:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this should have this one fixed.

I am seeing an intermittent lock up on the ARM Versatile board during the
ALSA driver init  that only shows up with (PREEMPT_RT & !HIGH_RES_TIMERS 
& ARM_EABI) enabled. If HRT is disabled and EABI is enabled, the kernel 
works every time, and same with !RT & !HRT & EABI.  I get no oops, just
a complete lock up with no console output.

In summary:


PREEMPT	HRT	EABI	BOOTS
------------------------------------------
2.6.18-rt3
------------------------------------------
RT	Y	Y	Y
RT	N	Y	Intermittent
RT	N	N	Y
NONE	Y	Y	Y
NONE	N	Y	Y
NONE	N	N	Y
------------------------------------------
2.6.18-vanilla
------------------------------------------
N/A		Y	Y
------------------------------------------

I need to go pinpoint the exact point where it is locking up during
the ALSA driver init (calls to udelay() seem suspect to me) and it
is very possible that this is a toolchain issue but want to see if
any other ARM folks are seeing issues with EABI & !HRT.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

"An open heart has no possessions, only experiences" - Matt Bibbeau
