Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUJRE4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUJRE4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 00:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUJRE4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 00:56:55 -0400
Received: from fmr06.intel.com ([134.134.136.7]:37585 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265207AbUJRE4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 00:56:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpufreq_ondemand
Date: Sun, 17 Oct 2004 21:56:35 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60031DA073@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpufreq_ondemand
Thread-Index: AcS0ma4f+0zCUJRZSJuFK8PwPp2oSAAM3Lmg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Con Kolivas" <kernel@kolivas.org>,
       "Alexander Clouter" <alex-kernel@digriz.org.uk>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2004 04:56:39.0151 (UTC) FILETIME=[DA4627F0:01C4B4CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Con Kolivas [mailto:kernel@kolivas.org] 
>Sent: Sunday, October 17, 2004 3:36 PM
>To: Alexander Clouter
>Cc: Pallipadi, Venkatesh; cpufreq@www.linux.org.uk; 
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] cpufreq_ondemand
>
>Alexander Clouter wrote:
>>> 3. (major) the scaling up and down of the cpufreq is now 
>smoother.  I found 
>> 	it really nasty that if it tripped < 20% idle time that 
>the freq was 
>> 	set to 100%.  This code smoothly increases the cpufreq 
>as well as 
>> 	doing a better job of decreasing it too
>
>I'd much prefer it shot up to 100% or else every time the cpu 
>usage went 
>up there'd be an obvious lag till the machine ran at it's 
>capable speed. 
>  I very much doubt the small amount of time it spent at 100% 
>speed with 
>the default design would decrease the battery life 
>significantly as well.
>

True. The current ondemand behaviour is by design. When CPU 
is at the lowest freq, and there is a sudden surge in load, 
we want it to go to max freq immediately, rather than wait 
for some more polling intervals. If max freq is too high, 
it will naturally lower to some intermediate freq later. 

We can never accurately predict freq for some future load. 
Say a CPU capable of 600, 800, 1000, 1200 and 1400 KHz, is 
running at 600 and we have sudden 100% CPU utilization, then 
we cannot precisely say which should be the next freq. It 
can be any of the higher possible freqs. And we felt performance 
should get a higher priority whenever there is some 
tradeoffs like this.

Thanks,
Venki
