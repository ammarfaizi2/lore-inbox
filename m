Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVFUGb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVFUGb6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVFUG30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:29:26 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:5287 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261961AbVFUG2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:28:19 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Lee Revell <rlrevell@joe-job.com>
Date: Tue, 21 Jun 2005 08:26:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Message-ID: <42B7CF30.29079.4F66E64@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1119291034.16180.9.camel@mindpipe>
References: <1119287354.9947.22.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.92.0+V=3.92+U=2.07.092+R=04 April 2005+T=103999@20050621.061518Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 2005 at 14:10, Lee Revell wrote:

> On Mon, 2005-06-20 at 10:09 -0700, john stultz wrote:
> > As for gettimefoday() syscall performance, I one had some numbers, but
> > I
> > would need to re-create them. I'll see if I can grab a slower box and
> > give you some hard numbers. 
> 
> I ran some tests lately that showed gettimeofday() to be 50x slower than
> rdtsc() on my 600Mhz machine.  Many userspace apps that need a cheap

Hello!

Isn't that a kind of absurd comparison: rdtsc is one or two instructions, while 
gettimeofday is a complete syscall with some many instructions: rdtsc will never 
give you the time of day besides of that. Are you voting for replacing 
gettimeofday with rdtsc?

> high res timer have to use rdtsc now due to the excessive overhead of
> gettimeofday().  It would be more correct if these apps could use

You can either have it accurate, or you can have it fast. Also gettimeofday works 
on any UNIX platform, rdtsc does not.

> gettimeofday() for various reasons (cpufreq and SMP issues).

Good point, but you don't get that higher reliability and accuracy for free.

> 
> So this patch is addressing a real problem.  I'd be interested to see if
> the performance is good enough to replace rdtsc in these cases.

In which applications (Java excepted maybe) do you really need to call 
gettimeofday more than a few thousand times per second? Most likely you are 
working around a different issue then.

Regards,
Ulrich

