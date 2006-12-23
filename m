Return-Path: <linux-kernel-owner+w=401wt.eu-S1753060AbWLWPyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbWLWPyZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 10:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbWLWPyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 10:54:25 -0500
Received: from homer.mvista.com ([63.81.120.158]:38312 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbWLWPyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 10:54:24 -0500
Subject: Re: sched_clock() on i386
From: Daniel Walker <dwalker@mvista.com>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       suresh.b.siddha@intel.com, kenneth.w.chen@intel.com,
       tony.luck@intel.com
In-Reply-To: <20061222104306.GC1895@frankl.hpl.hp.com>
References: <20061222104306.GC1895@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Sat, 23 Dec 2006 07:53:47 -0800
Message-Id: <1166889227.14081.13.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-22 at 02:43 -0800, Stephane Eranian wrote:
> Hello,
> 
> 
> The perfmon subsystems needs to compute per-CPU duration. It is using
> sched_clock() to provide this information. However, it seems they are
> big variations in the way sched_clock() is implemented for each architectures,
> especially in the accuracy of the returned value (going from TSC to jiffies).
> 

The vast majority of architectures return a scaled jiffies value for
sched_clock(). MIPS, and ARM for instance are two, and i386 does
sometimes. The function isn't very predictable in terms or what you'll
get as output. 

The most reliable way to get timing is to use gettimeofday() which in
turn uses a lowlevel clock. I'm not sure exactly what your application
is, but sometimes gettimeofday() can be a little complicated to use.
Which is why I create the following clocksource changes,

ftp://source.mvista.com/pub/dwalker/clocksource/

the purpose of which is to allow generic access to suitable lowlevel
clocks. It just extends the mechanism already used by gettimeofday(). 

Daniel



