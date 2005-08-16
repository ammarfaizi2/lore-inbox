Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVHPGgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVHPGgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 02:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVHPGgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 02:36:23 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:7335
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932605AbVHPGgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 02:36:23 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High
	Resolution Timers & RCU-tasklist features
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Ryan Brown <some.nzguy@gmail.com>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <430127CC.5080102@mvista.com>
References: <20050811110051.GA20872@elte.hu>
	 <1c1c8636050812172817b14384@mail.gmail.com>
	 <1123893158.12680.70.camel@mindpipe> <42FD4593.9030702@mvista.com>
	 <20050814021258.GA25877@elte.hu> <20050815062934.GA5915@elte.hu>
	 <430127CC.5080102@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 16 Aug 2005 06:36:35 +0000
Message-Id: <1124174195.23647.121.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 16:39 -0700, George Anzinger wrote:
> I haven't looked at this new code all that closely as yet.  One thing I 
> did notice is that there is an assumption that the "timer being 
> delivered flag" can be shared between LR timers and HR timers.  I 
> suspect this is wrong as the delivery code is in seperate threads (I 
> assume).  This could lead to del_timer_async missing a timer.

You're right, I found this yesterday night. Silly me.

This happened when I moved the hr timers into the tvec_t_base_s
structure due to Olegs  changes to the timer_list and the deletion code.

tglx


