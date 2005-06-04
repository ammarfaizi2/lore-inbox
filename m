Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVFDDc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVFDDc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 23:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFDDc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 23:32:26 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47531 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261166AbVFDDcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 23:32:21 -0400
Message-ID: <05df01c568b5$7d541980$0100a8c0@krustophenia>
From: "Lee Revell" <rlrevell@joe-job.com>
To: "Chris Friesen" <cfriesen@nortel.com>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: "Robert Love" <rml@novell.com>, "Mikael Starvik" <mikael.starvik@axis.com>,
       <linux-kernel@vger.kernel.org>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>	 <1117697423.6458.18.camel@laptopd505.fenrus.org>	 <1117698045.6833.16.camel@jenny.boston.ximian.com>	 <1117698518.6458.21.camel@laptopd505.fenrus.org>	 <1117698764.6833.26.camel@jenny.boston.ximian.com>	 <1117698978.6458.23.camel@laptopd505.fenrus.org>	 <429F0DA7.40006@nortel.com> <1117720095.6458.41.camel@laptopd505.fenrus.org> <429F15DA.8030205@nortel.com>
Subject: Re: Accessing monotonic clock from modules
Date: Fri, 3 Jun 2005 23:27:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Arjan van de Ven wrote:
>> On Thu, 2005-06-02 at 07:46 -0600, Chris Friesen wrote:
>
>>>For ourselves we implemented an clock interface for a limited subset of 
>>>architectures that provides a fast timestamp in kernel and userspace.
>>>
>>>Basically it has one call to return a 64-bit timestamp, and another call 
>>>to tell you how fast the clock is ticking.
>>
>>
>> hmm this is tricky if cpufreq actually varies cpu speeds... you would
>> need to not cache the "how fast it ticks" for too long.
>
> Luckily we didn't need to deal with that.
>
> In order to use the fast versions with varying frequency you'd need some 
> kind of notification to all users when the frequency changes.
>
> Alternately, on architectures where clock_gettime doesn't require the 
> overhead of a syscall, you could just use that.

JACK also implements a fast high-res timer for each supported arch.  We
can't use gettimeofday as it's about 50x slower than rdtsc (tested it just 
now).

I suggested using the kernel events mechanism to notify userspace when
the CPU speed changes a few months ago, for this exact reason.

Lee

