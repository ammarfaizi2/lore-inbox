Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbVICKQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbVICKQj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 06:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbVICKQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 06:16:39 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:9192 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1161202AbVICKQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 06:16:38 -0400
X-ORBL: [67.117.73.34]
Date: Sat, 3 Sep 2005 03:16:09 -0700
From: Tony Lindgren <tony@atomide.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Tony Lindgren <tony@atomide.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, tytso@mit.edu, cfriesen@nortel.com,
       rlrevell@joe-job.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: Updated dynamic tick patches
Message-ID: <20050903101609.GB5181@muru.com>
References: <20050831165843.GA4974@in.ibm.com> <200509011523.13994.kernel@kolivas.org> <20050901130721.GB10677@atomide.com> <20050902173432.GA5029@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902173432.GA5029@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 11:04:32PM +0530, Srivatsa Vaddagiri wrote:
> On Thu, Sep 01, 2005 at 04:07:22PM +0300, Tony Lindgren wrote:
> > Srivatsa, could you try the dyntick-test.c on your system after booting
> > to init=/bin/sh to make the system as idle as possible?
> 
> Tony,
> 	I get this o/p when I run your test on my SMP system with
> 2.6.13-mm1 + Con's latest patches (including the most recent
> lost tick calculation patch that I posted after that).
...
> 
> Don't see any ERROR status. The negative latencies doesn't seem to sound
> good. Do you see them too? I ran your test on my RH9 based T30 and
> find several negative latencies there too.

Good, thanks for testing.

>  Test: select 3000ms time:  3.000127s latency:  0.000127s status: OK

This is when I started seeing errors. Looks like if the next event from
next_timer_interrupt() is longer than HZ and idle HZ is very low, such
as 3 - 4 HZ, something gets confused.

I'll be looking into it more a bit later on, but until the problem
is solved, we should limit MAX_SKIP_TICKS to HZ/2.

Tony
