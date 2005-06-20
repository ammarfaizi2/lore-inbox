Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFTSHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFTSHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVFTSHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:07:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5052 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261253AbVFTSHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:07:02 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: Lee Revell <rlrevell@joe-job.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1119287354.9947.22.camel@cog.beaverton.ibm.com>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 14:10:33 -0400
Message-Id: <1119291034.16180.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 10:09 -0700, john stultz wrote:
> As for gettimefoday() syscall performance, I one had some numbers, but
> I
> would need to re-create them. I'll see if I can grab a slower box and
> give you some hard numbers. 

I ran some tests lately that showed gettimeofday() to be 50x slower than
rdtsc() on my 600Mhz machine.  Many userspace apps that need a cheap
high res timer have to use rdtsc now due to the excessive overhead of
gettimeofday().  It would be more correct if these apps could use
gettimeofday() for various reasons (cpufreq and SMP issues).

So this patch is addressing a real problem.  I'd be interested to see if
the performance is good enough to replace rdtsc in these cases.

Lee

