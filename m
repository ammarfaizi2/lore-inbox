Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVIBRfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVIBRfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVIBRfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:35:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54993 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750720AbVIBRfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:35:18 -0400
Date: Fri, 2 Sep 2005 23:04:32 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, s0348365@sms.ed.ac.uk, tytso@mit.edu,
       cfriesen@nortel.com, rlrevell@joe-job.com, trenn@suse.de,
       george@mvista.com, johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: Updated dynamic tick patches
Message-ID: <20050902173432.GA5029@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <200509011523.13994.kernel@kolivas.org> <20050901130721.GB10677@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901130721.GB10677@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:07:22PM +0300, Tony Lindgren wrote:
> Srivatsa, could you try the dyntick-test.c on your system after booting
> to init=/bin/sh to make the system as idle as possible?

Tony,
	I get this o/p when I run your test on my SMP system with
2.6.13-mm1 + Con's latest patches (including the most recent
lost tick calculation patch that I posted after that).

Testing sub-second select and usleep
  Test: select    0ms time:  0.000012s latency:  0.000012s status: OK
  Test: usleep    0ms time:  0.000013s latency:  0.000013s status: OK
  Test: select  100ms time:  0.099386s latency: -0.000614s status: OK
  Test: usleep  100ms time:  0.104019s latency:  0.004019s status: OK
  Test: select  200ms time:  0.200013s latency:  0.000013s status: OK
  Test: usleep  200ms time:  0.204016s latency:  0.004016s status: OK
  Test: select  300ms time:  0.300043s latency:  0.000043s status: OK
  Test: usleep  300ms time:  0.304056s latency:  0.004056s status: OK
  Test: select  400ms time:  0.400010s latency:  0.000010s status: OK
  Test: usleep  400ms time:  0.404098s latency:  0.004098s status: OK
  Test: select  500ms time:  0.499992s latency: -0.000008s status: OK
  Test: usleep  500ms time:  0.504000s latency:  0.004000s status: OK
  Test: select  600ms time:  0.600050s latency:  0.000050s status: OK
  Test: usleep  600ms time:  0.603959s latency:  0.003959s status: OK
  Test: select  700ms time:  0.699969s latency: -0.000031s status: OK
  Test: usleep  700ms time:  0.704037s latency:  0.004037s status: OK
  Test: select  800ms time:  0.800026s latency:  0.000026s status: OK
  Test: usleep  800ms time:  0.803978s latency:  0.003978s status: OK
  Test: select  900ms time:  0.900046s latency:  0.000046s status: OK
  Test: usleep  900ms time:  0.904003s latency:  0.004003s status: OK
Testing multi-second select and sleep
  Test: select    0ms time:  0.000005s latency:  0.000005s status: OK
  Test:  sleep    0ms time:  0.000006s latency:  0.000006s status: OK
  Test: select 1000ms time:  1.000062s latency:  0.000062s status: OK
  Test:  sleep 1000ms time:  1.004069s latency:  0.004069s status: OK
  Test: select 2000ms time:  2.000727s latency:  0.000727s status: OK
  Test:  sleep 2000ms time:  2.004141s latency:  0.004141s status: OK
  Test: select 3000ms time:  3.000127s latency:  0.000127s status: OK
  Test:  sleep 3000ms time:  3.004048s latency:  0.004048s status: OK
  Test: select 4000ms time:  4.000032s latency:  0.000032s status: OK
  Test:  sleep 4000ms time:  4.004827s latency:  0.004827s status: OK
  Test: select 5000ms time:  5.000118s latency:  0.000118s status: OK
  Test:  sleep 5000ms time:  5.004131s latency:  0.004131s status: OK
  Test: select 6000ms time:  5.997241s latency: -0.002759s status: OK
  Test:  sleep 6000ms time:  6.008025s latency:  0.008025s status: OK
  Test: select 7000ms time:  6.997195s latency: -0.002805s status: OK
  Test:  sleep 7000ms time:  7.004180s latency:  0.004180s status: OK
  Test: select 8000ms time:  8.000512s latency:  0.000512s status: OK
  Test:  sleep 8000ms time:  8.008116s latency:  0.008116s status: OK
  Test: select 9000ms time:  8.996997s latency: -0.003003s status: OK
  Test:  sleep 9000ms time:  9.004279s latency:  0.004279s status: OK


Don't see any ERROR status. The negative latencies doesn't seem to sound
good. Do you see them too? I ran your test on my RH9 based T30 and
find several negative latencies there too.



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
