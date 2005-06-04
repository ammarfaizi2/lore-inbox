Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFDVsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFDVsi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 17:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFDVsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 17:48:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29674 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261261AbVFDVsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 17:48:36 -0400
Subject: Re: Accessing monotonic clock from modules
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Robert Love <rml@novell.com>,
       Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <429F15DA.8030205@nortel.com>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
	 <1117697423.6458.18.camel@laptopd505.fenrus.org>
	 <1117698045.6833.16.camel@jenny.boston.ximian.com>
	 <1117698518.6458.21.camel@laptopd505.fenrus.org>
	 <1117698764.6833.26.camel@jenny.boston.ximian.com>
	 <1117698978.6458.23.camel@laptopd505.fenrus.org>
	 <429F0DA7.40006@nortel.com>
	 <1117720095.6458.41.camel@laptopd505.fenrus.org>
	 <429F15DA.8030205@nortel.com>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 17:48:23 -0400
Message-Id: <1117921703.15168.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 08:21 -0600, Chris Friesen wrote:
> Arjan van de Ven wrote:
> > On Thu, 2005-06-02 at 07:46 -0600, Chris Friesen wrote:
> 
> >>For ourselves we implemented an clock interface for a limited subset of 
> >>architectures that provides a fast timestamp in kernel and userspace.
> >>
> >>Basically it has one call to return a 64-bit timestamp, and another call 
> >>to tell you how fast the clock is ticking.
> > 
> > 
> > hmm this is tricky if cpufreq actually varies cpu speeds... you would
> > need to not cache the "how fast it ticks" for too long.
> 
> Luckily we didn't need to deal with that.
> 
> In order to use the fast versions with varying frequency you'd need some 
> kind of notification to all users when the frequency changes.
> 
> Alternately, on architectures where clock_gettime doesn't require the 
> overhead of a syscall, you could just use that.

JACK does this too.  Much of the code was just copied from the 2.4
kernel headers.

http://cvs.sourceforge.net/viewcvs.py/jackit/jack/config/cpu/

We have to do this because gettimeofday() is ~50 times slower than rdtsc
on x86.

In lieu of making gettimeofday() faster, the kernel events layer could
be used to notify userspace when the CPU speed changes.

Lee

