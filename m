Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWAXAAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWAXAAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWAXAAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:00:38 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:40801 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932430AbWAXAAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:00:37 -0500
Message-ID: <43D56E22.80500@bigpond.net.au>
Date: Tue, 24 Jan 2006 11:00:34 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and 2.6.16-rc1-mm1
References: <43D00887.6010409@bigpond.net.au>	<20060121114616.4a906b4f@localhost>	<43D2BE83.1020200@bigpond.net.au>	<43D40B96.3060705@bigpond.net.au>	<43D4281D.10009@bigpond.net.au> <20060123212158.3fba71d5@localhost>
In-Reply-To: <20060123212158.3fba71d5@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 24 Jan 2006 00:00:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Mon, 23 Jan 2006 11:49:33 +1100
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>>However, in spite of the above, the fairness mechanism should have been 
>>>able to generate enough bonus points to get dd's priority back to less 
>>>than 34.  I'm still investigating why this didn't happen.
>>
>>Problem solved.  It was a scaling issue during the calculation of 
>>expected delay.  The attached patch should fix both the CPU hog problem 
>>and the fairness problem.  Could you give it a try?
>>
> 
> 
> Mmmm... it doesn't work:
> 
>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5516 paolo     34   0  115m  18m 2432 S 87.5  3.7   0:23.72 transcode
>  5530 paolo     34   0 51000 4472 1872 S  8.0  0.9   0:02.29 tcdecode
>  5523 paolo     34   0 19840 1088  880 R  2.0  0.2   0:00.21 tcdemux
>  5522 paolo     34   0 22156 1204  972 R  0.7  0.2   0:00.02 tccat
>  5539 paolo     34   0  4952 1468  372 D  0.7  0.3   0:00.04 dd
>  5350 root      28   0  167m  16m 3228 S  0.3  3.4   0:03.64 X
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5456 paolo     34   0  115m  18m 2432 D 63.9  3.7   0:48.21 transcode
>  5470 paolo     37   0 50996 4472 1872 R  6.2  0.9   0:05.20 tcdecode
>  5493 paolo     34   0  4952 1472  372 R  1.5  0.3   0:00.22 dd
>  5441 paolo     28   0 86656  21m  15m S  0.2  4.4   0:00.77 konsole
>  5468 paolo     34   0 19840 1088  880 S  0.2  0.2   0:00.23 tcdemux
> 

Bummer.  At least it didn't classify dd as CPU intensive but the 
fairness bonus doesn't seem to have kicked in.  It's currently awarded 
as a "one of" bonus each time a delay is too long and I think that it 
needs to be a bit more persistent over time.

Thanks for testing
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
