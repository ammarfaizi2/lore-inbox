Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbWASK06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWASK06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWASK06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:26:58 -0500
Received: from general.keba.co.at ([193.154.24.243]:19332 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1161198AbWASK05 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:26:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: My vote against eepro* removal
Date: Thu, 19 Jan 2006 11:26:51 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323322@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My vote against eepro* removal
Thread-Index: AcYcyXLu7ygelEPvQ1GAEXvAEf8NMQAFtQ5Q
From: "kus Kusche Klaus" <kus@keba.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lee Revell
> On Thu, 2006-01-19 at 08:19 +0100, kus Kusche Klaus wrote:
> > Last time I tested (around 2.6.12), eepro100 worked much better 
> > in -rt kernels w.r.t. latencies than e100:
> > 
> > e100 caused a periodic latency of about 500 microseconds
> > exactly every 2 seconds, no matter what the load on the interface
> > was (i.e. even on an idle interface).
> > 
> > eepro100 did not show any latencies that long, it worked much
> > smoother w.r.t. latencies.
> > 
> > Of course I would prefer to have e100 fixed over keeping eepro100
> > around forever, but the last time I checked, it still wasn't fixed.
> 
> Please provide latency traces to illustrate the problematic code path.

It's not a "latency": As far as I can tell, interrupts or preemption
are not disabled, the latency tracer doesn't show anything.

I just noticed that low-pri rt processes did not get scheduled for
about 500 microseconds when e100 was active (even if the net was
idle), and that there were no such breaks with eepro100.

I didn't analyze it in detail at that time, I believed that the e100
interrupt handler thread was running every 2 seconds for 500 
microseconds, because the interrupt count of eth0 incremented every
2 seconds, exactly when my rt processes paused.

This would be bad: That irq thread is at rt prio 47 on my system, 
above many importent things.

However, I checked more closely now, and found out that only a small
portion of the 500 microseconds is spent in the irq thread. Most of
it is spent in the timer thread, at rt prio 1, so the whole thing
is a much smaller problem than I originally believed.

Must be the function e100_watchdog.

> It sounds like you have known about this issue for a while, were you
> waiting for it to fix itself?

See my other reply: I didn't notice that eepro100 is to be removed,
and as long as eepro100 was there, it was no problem for me.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
 
