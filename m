Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbULJVfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbULJVfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbULJVea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:34:30 -0500
Received: from lax-gate3.raytheon.com ([199.46.200.232]:17725 "EHLO
	lax-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S261817AbULJVeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:34:10 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF3220A1AC.7E7F07CF-ON86256F66.00749EC3@raytheon.com>
From: Mark_H_Johnson@Raytheon.com
Date: Fri, 10 Dec 2004 15:31:50 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/10/2004 03:31:56 PM
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
>
>> [1] I still do not get traces where cpu_delay switches CPU's. I only
>> get trace output if it starts and ends on a single CPU. [...]
>
>lt001.18RT/lt.02 is such a trace. It starts on CPU#1:
>
> <unknown-3556  1...1    0µs : find_next_bit (user_trace_start)
>
>and ends on CPU#0:
>
> <unknown-3556  1...1  247µs : _raw_spin_lock_irqsave (user_trace_stop)
>
>the trace shows a typical migration of an RT task.

Hmm. Now I look at it more clearly like...
 # grep '^<unknown-3556' lt001.18RT/lt.02
I can see what you mean. Though this time it moved from one [22 usec]
to zero [189 usec] and back to one [238 usec] before it finally stopped
the trace at 248 usec. [the attempt to reschedule on CPU zero was
clearly ineffective]

This trace is also odd in that the duration of the trace in the header is
listed as 99 usec (and the application confirmed that) but the trace
ends at 248 usec.

Hmm. Now that I look at it, the duration in the header (99 usec) is the
duration of lt.01 (as reported by the script) but the total duration
of the trace (248 usec) is the duration from the script for lt.02.


--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

