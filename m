Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUHAQSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUHAQSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 12:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUHAQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 12:18:12 -0400
Received: from pD9E0E790.dip.t-dialin.net ([217.224.231.144]:24197 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S265654AbUHAQSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 12:18:09 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, Scott Wood <scott@timesys.com>
In-Reply-To: <20040729222657.GA10449@elte.hu>
References: <40F3F0A0.9080100@vision.ee>
	 <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu>  <20040729222657.GA10449@elte.hu>
Content-Type: text/plain
Message-Id: <1091377000.5392.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 18:16:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> i've uploaded the latest version of the voluntary-preempt patch:
>  
>    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-M5
> 

This patch doesn't solve the latency spikes I see every ~8 seconds on my
system. They still appear in latencytest when the rtc interrupt is the
only non threaded interrupt on the system, and they still produce xruns
in jack in conjunction with the keyboard even if the the sound card's
interrupt is the only non threaded irq and jack's SCHED_FIFO priority is
higher than the irq threads. I suspected a clock issue and switched from
tsc to pmtmr without success. I now suspect a hardware issue (the
machine is a laptop with a PIII M 1GHz cpu) or a scheduler corner case.
Running jack at 96000Hz with 2 periods of 64 samples, I can see regular
bursts of cpu usage every 2 or 3 seconds. Oprofile reveals that schedule
is then the second most CPU intensive function on the system.

Thomas


