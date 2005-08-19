Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbVHSBXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVHSBXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 21:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVHSBXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 21:23:18 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:6877 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964793AbVHSBXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 21:23:17 -0400
Subject: Re: Latency with Real-Time Preemption with 2.6.12
From: Steven Rostedt <rostedt@goodmis.org>
To: Sundar Narayanaswamy <sundar007@yahoo.com>
Cc: george@mvista.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20050819002336.74150.qmail@web54405.mail.yahoo.com>
References: <20050819002336.74150.qmail@web54405.mail.yahoo.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 21:22:49 -0400
Message-Id: <1124414569.5186.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 17:23 -0700, Sundar Narayanaswamy wrote:

> The SBC has two serial ports, ttyS0 and ttyS1 that are connected by the
> serial port cable. A program writes characters on ttyS0 while another
> program (with RealTime priority thread) reads the char from ttyS1 and
> echoes it back immediately). The first program then measures the time it
> takes for it to get back the written char. Without any system load, 
> I noticed that this time is about 4ms, which I think is fine. However,
> as the system load (primarly disk I/O) increases, the time increases to about 
> 30-40 ms and this increase (with moderate system load) surprises me. With
> realtime preemption patch, I was hoping this time would remain about 4ms.

I'm assuming that your config is using full RT preemption.  Also, you
need to raise the priority of the interrupt thread of the serial, so
that both the program reading the serial and the serial interrupt are
higher than all else running on the system.  This should keep the
timings down.
> 
> My initial guess was that the driver (IDE controller, due to disk I/O load) 
> has non-preemptible sections that is causing the additional delay, and 
> that was why I tried the nanosleep test program. 

There shouldn't be any drivers that are showing long latencies.  Again,
make sure your program and the serial interrupt are above all else.

> 
> Now, I am not sure if  I am not setting up something right, or if I 
> am missing something. I appreciate your time and feedback. Please let me know 
> if there is something obvious that I should look into, or a setup (config) 
> I might be missing. I'll look into George's suggestion to try timers 
> tomorrow.

If you want, you can send a compressed version of your config.

-- Steve


