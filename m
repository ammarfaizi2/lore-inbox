Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUCKVyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUCKVyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:54:19 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:46318 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261745AbUCKVyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:54:13 -0500
Message-ID: <4050E000.4030802@mvista.com>
Date: Thu, 11 Mar 2004 13:54:08 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Abhishek Rai <abba@fsl.cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: rtc_gettimeofday VS. do_gettimeofday
References: <Pine.LNX.4.44.0403061024150.15658-100000@filer.fsl.cs.sunysb.edu>
In-Reply-To: <Pine.LNX.4.44.0403061024150.15658-100000@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abhishek Rai wrote:
> Hi,
> I need a mechanism to get accurate timeofday from inside the kernel. 
> Though rtc_gettimeofday() and do_gettimeofday() both look appropriate, is 
> there a reason to prefer one over the other ?

Well, gettimeofday is corrected by ntp, if that matters.  It also has a 
resolution down to the micro second.

The rtc, on the other hand, is an I/O device (i.e. slower) and only goes to the 
second.

If all you need is second resolution the faster way is to use the seconds part 
of xtime.  This is available as CURRENT_TIME which is defined in 
include/linux/sched.h.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

