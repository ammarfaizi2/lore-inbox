Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262603AbTCRX34>; Tue, 18 Mar 2003 18:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbTCRX34>; Tue, 18 Mar 2003 18:29:56 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:62617 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262603AbTCRX3z>;
	Tue, 18 Mar 2003 18:29:55 -0500
Message-Id: <200303182340.h2INeE4r098586@northrelay04.pok.ibm.com>
From: john stultz <johnstul@us.ibm.com>
Subject: Re: seqlock/unlock(&xtime_lock) problems cause keyboard, time skew problems
To: Jerry Cooperstein <coop@axian.com>, linux-kernel@vger.kernel.org
Mail-Copies-To: johnstul@us.ibm.com
Date: Tue, 18 Mar 2003 15:34:32 -0800
References: <20030318190557.GA14447@p3.attbi.com> <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net> <20030318205907.GB4081@p3.attbi.com>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jerry Cooperstein wrote:

>> Does this notebook vary the clock rate? If so then using TSC for
>> time of day clock is probably a problem.  Try booting with notsc.
> 
> I tried booting with notsc, the results were:
> 
> for kernels through 2.5.63:  kernel panic on boot, message saying pentium+
> requires tsc
> 
> for 2.5.64, 2.5.65:  no failure, but no help.

Check the boot msgs. You're kernel is compiled w/ CONFIG_X86_TSC, so it
should print a warning as such stating it is ignoring the notsc option.

Try compiling the kernel for i386 and the kernel then boot w/ notsc. Do be
warned, if you're running w/ an i686 compiled glibc your box will hang
after the "Freeing unused kernel memory: " msg. 

Another thing to check is if the lost-tick compensation code is biting you.
Try commenting out the "detect_lost_tick()" call from timer_interrupt() in
arch/i386/kernel/time.c

Let me know if that changes anything.

thanks
-john


