Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268759AbUI2Rrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268759AbUI2Rrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268698AbUI2Rrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:47:47 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:58603 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S268755AbUI2Rr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:47:28 -0400
Message-ID: <415AF4C3.1040808@mvista.com>
Date: Wed, 29 Sep 2004 10:45:39 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant CLOCK_PROCESS/THREAD_CPUTIME_ID V4
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com> <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com> <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> George asked for a test program so I wrote one and debugged the patch.
> The test program uses syscall to bypass glibc processing. I have been
> working on a patch for glibc but that gets a bit complicated
> because backwards compatibility has to be kept. Maybe tomorrow.
> Found also that glibc allows the setting of these clocks so I also
> implemented that and used it in the test program.  Setting these
> clocks modifies stime and utime directly, which may not be such a good
> idea. Do we really need to be able to set these clocks?

Another way of doing this is to save these values in the task structure.  If 
null, use the direct value of stime, utime, if not, adjust by the saved value 
(i.e. saved value would represent time zero).
> 
> So it actually works now. Test output, test program and revised patch:

Please, when sending patches, attach them.  This avoids problems with mailers, 
on both ends, messing with white space.  They still appear in line, at least in 
some mailers (mozilla in my case).

As to the test program, what happens when you attempt to set up a timer on these 
clocks?  (No, I don't think it should work, but we DO want to properly error 
out.  And the test should verify that this happens.)  By the way, if you use the 
support package from sourceforge, you will find a lot of test harness stuff.


~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

