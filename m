Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTDKM4b (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 08:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264341AbTDKM4b (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 08:56:31 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:20413 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S264339AbTDKM4a convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 08:56:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [BUG] settimeofday(2) succeeds for microsecond value more than USEC_PER_SEC and for negative value
Date: Fri, 11 Apr 2003 18:37:56 +0530
Message-ID: <94F20261551DC141B6B559DC491086723E1028@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] settimeofday(2) succeeds for microsecond value more than USEC_PER_SEC and for negative value
Thread-Index: AcL/81iSZH7IbBr0S266U7VbrhKkSwAN5ehA
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: "george anzinger" <george@mvista.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Chandrashekhar RS" <chandra.smurthy@wipro.com>
X-OriginalArrivalTime: 11 Apr 2003 13:07:55.0936 (UTC) FILETIME=[5E219A00:01C3002B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even then, I think, we can modify the settimeofday  code to check -1 and USEC_PER_SEC
Conditions, can't we?


|-----Original Message-----
|From: george anzinger [mailto:george@mvista.com] 
|Sent: Friday, April 11, 2003 11:56 AM
|To: Aniruddha M Marathe
|Cc: linux-kernel@vger.kernel.org; Chandrashekhar RS
|Subject: Re: [BUG] settimeofday(2) succeeds for microsecond 
|value more than USEC_PER_SEC and for negative value
|
|
|Aniruddha M Marathe wrote:
|> Settimeofday(2) should return EINVAL in case where 
|tv.tv_usec parameter is more than 
|> USEC_PER_SEC (more than 10^6 ) or for negative values of tv.tv_usec. 
|> It returns 0 (success) instead.
|> 
|> Clock_settimeofday(2) (kernel/posix-timers.c) also uses 
|do_sys_settimeofday() and faces the
|> Same problem.
|> 
|> I think this is a bug. If you confirm, I will send a patch.
|
|Yes, it is a known problem, turned up by some the posix timers tests. 
|  I suppose it is too much to ask, but it would be nice if 
|do_sys_settimeofday() took a timespec instead of a timeval.  Of course 
|this changes the interface for all the archs, but it would allow the 
|clock_settimeofday to send in the nsec value.
|
|-g
|
|> 
|> Regards,
|> Aniruddha Marathe
|> WIPRO Technologies, India
|> -
|> To unsubscribe from this list: send the line "unsubscribe 
|linux-kernel" in
|> the body of a message to majordomo@vger.kernel.org
|> More majordomo info at  http://vger.kernel.org/majordomo-info.html
|> Please read the FAQ at  http://www.tux.org/lkml/
|> 
|
|-- 
|George Anzinger   george@mvista.com
|High-res-timers:  http://sourceforge.net/projects/high-res-timers/
|Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
|
|
