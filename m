Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVATCGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVATCGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVATCGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:06:09 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:2766 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261502AbVATCFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:05:52 -0500
Message-ID: <41EF123D.703@kolivas.org>
Date: Thu, 20 Jan 2005 13:06:53 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org> <873bwwga0w.fsf@sulphur.joq.us>
In-Reply-To: <873bwwga0w.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>Con Kolivas wrote:
>>
>>Here are my results with SCHED_ISO v2 on a pentium-M 1.7Ghz (all
>>powersaving features off):
>>
>>Increasing iso_cpu did not change the results.
>>
>>At least in my testing on my hardware, v2 is working as advertised. I
>>need results from more hardware configurations to know if priority
>>support is worth adding or not.
> 
> 
> Excellent.  Judging by the DSP Load, your machine seems to run almost
> twice as fast as my 1.5GHz Athlon (surprising).  You might want to try

Not really surprising; the 2Mb cache makes this a damn fine cpu, if not 
necessarily across the board :)

> pushing it a bit harder by running more clients (2nd parameter,
> default is 20).

Ask and ye shall receive.

> Are you getting fairly consistent results running SCHED_ISO
> repeatedly?  That worked better for me after I fixed that bug in JACK
> 0.99.47, but I think there is still more variance than with
> SCHED_FIFO.

Much more consistent, and I believe some bugs in the earlier 
implementation were probably biting.

40 clients:
SCHED_FIFO:
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     7
Delay Count (>spare time) . . :    20
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :  6739   usecs
Cycle Maximum . . . . . . . . :   746   usecs
Average DSP Load. . . . . . . :    30.4 %
Average CPU System Load . . . :     5.7 %
Average CPU User Load . . . . :    23.3 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     0.6 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1692.0 /sec
Average Context-Switch Rate . : 20907.7 /sec
*********************************************

SCHED_ISO:
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :    11
Delay Count (>spare time) . . :    19
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :  8723   usecs
Cycle Maximum . . . . . . . . :   714   usecs
Average DSP Load. . . . . . . :    31.1 %
Average CPU System Load . . . :     5.7 %
Average CPU User Load . . . . :    23.2 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     0.6 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1685.4 /sec
Average Context-Switch Rate . : 20496.9 /sec
*********************************************

Full results and pretty pictures available here:
http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/

Cheers,
Con
