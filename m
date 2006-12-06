Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933606AbWLFPH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbWLFPH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933843AbWLFPH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:07:57 -0500
Received: from mout2.freenet.de ([194.97.50.155]:47382 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933835AbWLFPH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:07:56 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH -rt 0/3] Make trace_freerunning work; Take 2
Date: Wed, 6 Dec 2006 16:08:24 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061205220257.1AECF3E2420@elvis.elte.hu> <20061205221046.GB20587@elte.hu>
In-Reply-To: <20061205221046.GB20587@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061608.24556.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. Dezember 2006 23:10 schrieb Ingo Molnar:
> 
> freerunning should behave the same way with regard to latency 
> measurement. I.e. report_latency() is still needed, and the kernel will 
> thus do a maximum search over all traces triggered via start/stop.
> 
> the difference is in the recording of the last-largest-latency:
> 
> - with !freerunning, the tracer stops recording after MAX_TRACE entries, 
>   i.e. the "head" of the trace is preserved in the trace buffer.
> 
> - with freerunning, the tracer never stops, it 'wraps around' after 
>   MAX_TRACE entries and starts overwriting the oldest entries. I.e. the  
>   "tail" of the trace is preserved in the trace buffer.
> 
> depending on the situation, freerunning or !freerunning might be the 
> more useful mode.
> 
> but there should be no difference in measurement.

Following 3 patches try to implement the above.

Tested on a UP only after this incantation:
	echo 0 > /proc/sys/kernel/wakeup_timing
	echo 1 > /proc/sys/kernel/trace_enabled
	echo 1 > /proc/sys/kernel/trace_user_triggered

and for half of tests:
	echo 1 > /proc/sys/kernel/trace_freerunning
or
	echo 0 > /proc/sys/kernel/trace_freerunning
.

      Karsten
