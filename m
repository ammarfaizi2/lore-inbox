Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVAESDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVAESDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVAESDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:03:42 -0500
Received: from bos-gate3.raytheon.com ([199.46.198.232]:27371 "EHLO
	bos-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S262142AbVAESDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:03:39 -0500
To: "K.R. Foley" <kr@cybsft.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
From: Mark_H_Johnson@Raytheon.com
Subject: Re: Real-Time Preemption, comparison to 2.6.10-mm1
Date: Wed, 5 Jan 2005 11:52:06 -0600
Message-ID: <OF736AB5F1.DCE25423-ON86256F80.00622744-86256F80.0062278E@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/05/2005 11:56:40 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
>Mark_H_Johnson@raytheon.com wrote:
[snip - long explanation of how a nice application can starve a non
nice application for minutes at a time on an SMP system]

>> My point was that -mm definitely has the problem (though to a lesser
>> degree). The tests I ran showed it on both the disk read and disk copy
>> stress tests. I guess I should try a vanilla 2.6.10 run as well to see
>> if it is something introduced in the -mm series (it certainly is not a
>> recent change...).
>
>I'm curious if anyone is seeing this behavior on UP systems, or is it
>only happening on SMP?
The build of 2.6.10 vanilla just completed and I reran my tests with
SMP and with MAXCPUS=1 (UP w/ SMP kernel).

The vanilla 2.6.10 kernel has the non RT starvation problem as well
for both test runs. It looks like this is not something in -mm but a
change between 2.4 and 2.6.

I did notice the test results were a little inconsistent between the
two runs...
             2.6.10 SMP    2.6.10 UP (w/ SMP kernel)
disk write    starved          OK
disk copy        OK         starved
disk read     starved       starved
but in both cases, a non nice (non RT) disk application was
starved by a nice (non RT) cpu application for minutes.

I wonder who I should be talking to next (or submit a bug report?)
about this.

  --Mark

