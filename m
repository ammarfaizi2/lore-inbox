Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUJTRrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUJTRrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268771AbUJTRqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:46:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:47284 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268779AbUJTRmm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:42:42 -0400
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41767B60.4050409@mvista.com>
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
	 <1098216701.20778.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>
	 <1098233967.20778.93.camel@cog.beaverton.ibm.com>
	 <41767B60.4050409@mvista.com>
Content-Type: text/plain
Message-Id: <1098294178.20778.117.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 10:42:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 07:51, George Anzinger wrote:
> john stultz wrote:
> > I've begun to agree with you about this issue. It seems that until we
> > can catch every use of jiffies for time, doing one by one is going to
> > cause consistency problems.  So I'd support the full backout of the
> > do_posix_clock_monotonic_gettime changes to the proc interface. 
> > 
> > George, would you protest this?
> 
> It seems to me that if we do that we will stop making any changes at all.  I.e. 
> we will not see the rest of the "jiffies for time" code, as it will not "hurt" 
> any more.

Sorry, not sure I followed that. Could you explain further?

> Also, the orgional change was made for a reason...

Right, but I thought it was you who made the original change, and I
don't recall you answering what that reason was? I wouldn't want the
code ripped out if it was fixing an actual problem, so that's why I'm
asking.

At the moment, I'd like the idea I think Tim is suggesting. Where we fix
time so we have a stable base, then we decouple xtime and jiffies from
the timer interrupt and instead emulate them from the time code. 

So rather then every tick incrementing jiffies, instead jiffies is set
equal to (monotonic_clock()*HZ)/NSEC_PER_SEC. 

Thoughts?
-john






