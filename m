Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272829AbRISWnK>; Wed, 19 Sep 2001 18:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274238AbRISWm7>; Wed, 19 Sep 2001 18:42:59 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:11786 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S272829AbRISWmu>; Wed, 19 Sep 2001 18:42:50 -0400
Subject: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: ozone@algorithm.com.au, safemode@speakeasy.net, Dieter.Nuetzel@hamburg.de,
        iafilius@xs4all.nl, ilsensine@inwind.it, george@mvista.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.07.08 (Preview Release)
Date: 19 Sep 2001 18:44:09 -0400
Message-Id: <1000939458.3853.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at:
http://tech9.net/rml/linux/patch-rml-2.4.9-ac12-preempt-stats-1 and
http://tech9.net/rml/linux/patch-rml-2.4.10-pre12-preempt-stats-1
for 2.4.9-ac12 and 2.4.10-pre12, respectively.

This patch is provided thanks to MontaVista (http://mvista.com).

This patch enables a new kernel configure option, CONFIG_PREEMPT_TIMES,
which once enabled instructs the kernel preemption code to monitor
in-kernel latencies due to the various locking primitives and report the
20 worst recorded cases to /proc/latencytimes.

The patch obviously requires the preemption patch, available at
http://tech9.net/rml/linux

The patch won't start recording (I will change this...) until you read
from /proc/latencytimes once.  From then on, each read will return the
20 worst cases and reset the log.  Nonetheless, you don't want this in
the kernel if you don't plan to do use it, and I do _not_ want it
enabled during benchmarks.

The proc interface is fairly verbose.  It will give you a measurement of
the latency, what is causing the latency, the file line number and
filename where the lock (or whatever) began and the same for where it
ended.

The point is to track down long held locks and other problems that are
causing poor response.

Thus, most of you CC have noticed certain situations wherein even with
preemption you see high latencies (most of you with mp3 playback).  I
ask that, if you get the chance, to play with this patch and measuring
some latencies.  See where bad values lie.  Get a feeling for your
system... most of your latencies should be very small.  Right now, I
just read a sampling of my 8000 worst cases and the worst was 600us --
this is not bad.  Things over 5000us are interesting, especially if
consistent.

I appreciate any comments.  CC me and the list.  Enjoy.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

