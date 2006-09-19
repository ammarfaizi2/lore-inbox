Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWISQ4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWISQ4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWISQ4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:56:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53446 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751864AbWISQ4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:56:39 -0400
Subject: Re: [PATCH] Migration of Standard Timers
From: Lee Revell <rlrevell@joe-job.com>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Jes Sorensen <jes@sgi.com>, Eric Dumazet <dada1@cosmosbay.com>
In-Reply-To: <20060919164159.GC26863@sgi.com>
References: <20060919152942.GA26863@sgi.com>
	 <1158683617.11682.14.camel@mindpipe>  <20060919164159.GC26863@sgi.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 12:57:53 -0400
Message-Id: <1158685073.11682.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 11:41 -0500, Dimitri Sivanich wrote:
> On Tue, Sep 19, 2006 at 12:33:37PM -0400, Lee Revell wrote:
> > Which driver or subsystem is doing 100s of usecs of work in a timer?
> 
> The longest one I've captured so far results from:
> 
> rsp                rip                Function (args)
>  ======================= <nmi>
> 0xffff810257822fd8 0xffffffff803a0e94 rt_check_expire+0x8c
>  ======================= <interrupt>  
> 0xffff81025781fee8 0xffffffff803a0e08 rt_check_expire
> 0xffff81025781ff08 0xffffffff802386b3 run_timer_softirq+0x133
> 0xffff81025781ff38 0xffffffff80235262 __do_softirq+0x5e
> 0xffff81025781ff68 0xffffffff8020a958 call_softirq+0x1c
> 0xffff81025781ff80 0xffffffff8020bea7 do_softirq+0x2c
> 0xffff81025781ff90 0xffffffff80235142 irq_exit+0x48
> 

Ah, I remember that one.  Eric Dumazet had some suggestions to fix it
6-12 months ago which never went anywhere - the thread was called "RCU
latency regression in 2.6.16-rc1".

That one is especially annoying as there's no workaround (shrinking the
route cache or reducing the GC interval via net.ipv4.route.* sysctls has
no effect)

Lee

