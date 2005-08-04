Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVHDMEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVHDMEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVHDMEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:04:46 -0400
Received: from mail.isurf.ca ([66.154.97.68]:37284 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S262490AbVHDMEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:04:45 -0400
Message-ID: <42F2047A.1050906@staticwave.ca>
Date: Thu, 04 Aug 2005 08:05:14 -0400
From: Gabriel Devenyi <ace@staticwave.ca>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ck] [ANNOUNCE] Interbench 0.27
References: <200508031758.31246.kernel@kolivas.org> <200508041004.46675.kernel@kolivas.org> <42F1FF89.5030903@staticwave.ca> <200508042146.13710.kernel@kolivas.org>
In-Reply-To: <200508042146.13710.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thu, 4 Aug 2005 21:44, Gabriel Devenyi wrote:
> 
>>Hi Con,
>>
>>You must hate me by now...
> 
> 
> No. A bug report is a bug report. I hate the fact that I coded up 2000 lines 
> of code and am still suffering from a problem in the same 10 lines that I did 
> in version .01. PEBKAC. 
I guess we all have our weaknesses, mine is off-by-one errors, which are 
a bad thing when writing code for a statistics class at school ;)

> 
> 
>>The "Gaming" benchmark has the same issue with nan coming out of the
>>STDEV calculations, probably requires the same fix as before.
> 
> 
> Anyway Peter Williams has promised to fix it for me (yay!).
> 
> 
>>Secondly, the benchmarking of loops_per_ms is running forever, and I
>>managed to determine where its happening.
>>
>>In calibrate loops you run a while loop and iterate to get 1000 for
>>run_time, then you calculate it one more time to ensure it was right
>>*however* you put a sleep(1) before that. It seems to seriously skew the
>>results, as it consistently adds ~500 to run_time, as run_time is now
>>1500, it jumps back up to redo because of the goto statement, and runs
>>the while loop again, continue ad nausium. I added some simple debugging
>>output which prints run time at the end of each while loop, and right
>>before the goto if statement, this is the output.
> 
> 
>>The solution I used is of course to simply comment out the sleep
>>statement, then everything works nicely, however your comments appear to
>>indicate that the sleep is there to make the system settle a little,
>>perhaps another method needs to be used. Thanks for your time!
> 
> 
> I have to think about it. This seems a problem only on one type of cpu for 
> some strange reason (lemme guess; athlon?) and indeed leaving out the sleep 1 
> followed by the check made results far less reliable. This way with the sleep 
> 1 I have not had spurious results returned by the calibration. I'm open to 
> suggestions if anyone's got one.
Yeah, thats right, it spins forever on both my athlon-tbird and my 
athlon64 (in x86_64 mode). I'll take another look at the code tonight, 
to see if I can figure out why its causing this, or another way of 
incurring the delay you're looking for.

> 
> Cheers,
> Con
> 

--
Gabriel Devenyi
ace@staticwave.ca
