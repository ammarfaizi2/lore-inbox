Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVATAwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVATAwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVATAwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:52:13 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:31675 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262011AbVATAwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:52:06 -0500
Message-ID: <41EF00ED.4070908@kolivas.org>
Date: Thu, 20 Jan 2005 11:53:01 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: joq@io.com
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <41EEE1B1.9080909@kolivas.org>
In-Reply-To: <41EEE1B1.9080909@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> This is version 2 of the SCHED_ISO patch with the yield bug fixed and 
> code cleanups.

...answering on this thread to consolidate the two branches of the email 
thread.

Here are my results with SCHED_ISO v2 on a pentium-M 1.7Ghz (all 
powersaving features off):

SCHED_NORMAL:
awk: ./jack_test3_summary.awk:67: (FILENAME=- FNR=862) fatal: division 
by zero attempted
Well we wont bother looking at those results then. there were 38 XRUNS 
that did make it on the parsed output.


SCHED_FIFO:
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     4
Delay Count (>spare time) . . :    18
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :  6595   usecs
Cycle Maximum . . . . . . . . :   368   usecs
Average DSP Load. . . . . . . :    17.9 %
Average CPU System Load . . . :     3.4 %
Average CPU User Load . . . . :    13.7 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     1.4 %
Average CPU IRQ Load  . . . . :     0.6 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1697.0 /sec
Average Context-Switch Rate . : 13334.1 /sec
*********************************************


SCHED_ISO (iso_cpu 70):
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     5
Delay Count (>spare time) . . :    18
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :  6489   usecs
Cycle Maximum . . . . . . . . :   405   usecs
Average DSP Load. . . . . . . :    18.0 %
Average CPU System Load . . . :     3.3 %
Average CPU User Load . . . . :    13.7 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     0.6 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1700.2 /sec
Average Context-Switch Rate . : 12457.2 /sec
*********************************************


Increasing iso_cpu did not change the results.

At least in my testing on my hardware, v2 is working as advertised. I 
need results from more hardware configurations to know if priority 
support is worth adding or not.

Cheers,
Con
