Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVHZTwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVHZTwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVHZTwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:52:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65017 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1030243AbVHZTwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:52:40 -0400
Message-ID: <430F72CE.8080702@mvista.com>
Date: Fri, 26 Aug 2005 12:51:42 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Alex Williamson <alex.williamson@hp.com>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Need better is_better_time_interpolator() algorithm
References: <1124988269.5331.49.camel@tdi>  <1124991406.20820.188.camel@cog.beaverton.ibm.com>  <1124995405.5331.90.camel@tdi>  <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com>  <1125073089.5182.30.camel@tdi>  <430F6A7E.203@mvista.com> <1125084417.5182.58.camel@tdi> <Pine.LNX.4.62.0508261231440.16138@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0508261231440.16138@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Fri, 26 Aug 2005, Alex Williamson wrote:
> 
> 
>>   Would we ever want to favor a frequency shifting timer over anything
>>else in the system?  If it was noticeable perhaps we'd just need a
>>callback to re-evaluate the frequency and rescan for the best timer.  If
>>it happens without notice, a flag that statically assigns it the lowest
>>priority will due.  Or maybe if the driver factored the frequency
>>shifting into the drift it would make the timer undesirable without
>>resorting to flags.  Thanks,
> 
> 
> Timers are usually constant. AFAIK Frequency shifts only occur through 
> power management. In that case we usually have some notifiers running 
> before the change. These notifiers need to switch to a different time 
> source if the timer frequency will be shifting or the timer will become 
> unavailable.
> 
If there is a notifier, I presume we can track it.  We might want to 
refine things so as to not hit too big a bump when the shift occures, 
but I think it is doable.  The desirability of doing it, I think, 
depends on the availablity of something better.  The access time of the 
TSC is "really" enticing.  Even so, I think a _good_ clock would not 
depend on long term accuracy of something as fast as the TSC.  Vendors 
are even modulating these to reduce RFI, but still, because of its 
speed, it makes the best interpolator for the jiffie to jiffie times.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
