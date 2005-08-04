Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVHDLnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVHDLnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVHDLnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:43:43 -0400
Received: from mail.isurf.ca ([66.154.97.68]:30381 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S262485AbVHDLnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 07:43:42 -0400
Message-ID: <42F1FF89.5030903@staticwave.ca>
Date: Thu, 04 Aug 2005 07:44:09 -0400
From: Gabriel Devenyi <ace@staticwave.ca>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ck] [ANNOUNCE] Interbench 0.27
References: <200508031758.31246.kernel@kolivas.org>	<200508040925.57577.kernel@kolivas.org>	<200508040934.19498.kernel@kolivas.org> <200508041004.46675.kernel@kolivas.org>
In-Reply-To: <200508041004.46675.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

You must hate me by now...

The "Gaming" benchmark has the same issue with nan coming out of the 
STDEV calculations, probably requires the same fix as before.

Secondly, the benchmarking of loops_per_ms is running forever, and I 
managed to determine where its happening.

In calibrate loops you run a while loop and iterate to get 1000 for 
run_time, then you calculate it one more time to ensure it was right 
*however* you put a sleep(1) before that. It seems to seriously skew the 
results, as it consistently adds ~500 to run_time, as run_time is now 
1500, it jumps back up to redo because of the goto statement, and runs 
the while loop again, continue ad nausium. I added some simple debugging 
output which prints run time at the end of each while loop, and right 
before the goto if statement, this is the output.

--cut--
loops_per_ms unknown; benchmarking...
while: 224
while: 649
while: 993
while: 1025
while: 976
while: 1001
while: 1000
1494
while: 671
while: 997
while: 1000
1496
--cut--

The solution I used is of course to simply comment out the sleep 
statement, then everything works nicely, however your comments appear to 
indicate that the sleep is there to make the system settle a little, 
perhaps another method needs to be used. Thanks for your time!

--
Gabriel Devenyi
ace@staticwave.ca

Con Kolivas wrote:
> Interbench is a benchmark application is designed to benchmark interactivity 
> in Linux.
> 
> Direct download link:
> http://ck.kolivas.org/apps/interbench/interbench-0.27.tar.bz2
> 
> Web page:
> http://interbench.kolivas.org
> 
> Changes:
> Standard deviation and average latency calculation was corrected. Gaming 
> standard deviation was implemented.
> 
> Cheers,
> Con
> _______________________________________________
> ck@vds.kolivas.org
> ck mailing list. Please reply-to-all when posting.
> If replying to an email please reply below the original message.
> http://bhhdoa.org.au/mailman/listinfo/ck
> 
