Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314273AbSDVQpZ>; Mon, 22 Apr 2002 12:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314274AbSDVQpY>; Mon, 22 Apr 2002 12:45:24 -0400
Received: from air-2.osdl.org ([65.201.151.6]:30730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314273AbSDVQpY>;
	Mon, 22 Apr 2002 12:45:24 -0400
Date: Mon, 22 Apr 2002 09:40:33 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: user/system/nice accounting (SMP): need help understanding the
 code
In-Reply-To: <200204221312.g3MDCCX11604@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33L2.0204220935500.507-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002, Denis Vlasenko wrote:

| As you see below, in SMP case update_one_process() is not called
| in do_timer().
| OTOH, global grep over entire tree (*.[chsS]) for 'per_cpu_utime'
| and 'per_cpu_user' did not turn out SMP accounting code.
| Or maybe I am stupid.
|
| Anybody with cluebat?

Sure... ;)

| ...
| void do_timer(struct pt_regs *regs)
| {
|         (*(unsigned long *)&jiffies)++;
| #ifndef CONFIG_SMP
|         /* SMP process accounting uses the local APIC timer */
|
|         update_process_times(user_mode(regs));
| #endif
|         mark_bh(TIMER_BH);
|         if (TQ_ACTIVE(tq_timer))
|                 mark_bh(TQUEUE_BH);
| }
| --

For CONFIG_SMP, each arch/cpu/kernel/*.c calls update_process_times().

-- 
~Randy

