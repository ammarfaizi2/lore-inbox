Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVATGed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVATGed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 01:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVATGed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 01:34:33 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:8629 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262062AbVATGea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 01:34:30 -0500
Message-ID: <41EF5122.2000605@kolivas.org>
Date: Thu, 20 Jan 2005 17:35:14 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: "Jack O'Quin" <joq@io.com>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org> <87oefkd7ew.fsf@sulphur.joq.us> <41EF48BA.50709@kolivas.org>
In-Reply-To: <41EF48BA.50709@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Jack O'Quin wrote:
>> I was misreading the x-axis.  They're actually every 20 sec.  My
>> system isn't doing that.
> 
> 
> Possibly reiserfs journal related. That has larger non-preemptible code 
> sections.
> 
>> You're really getting hammered with those periodic 6 msec delays,
>> though.  The basic audio cycle is only 1.45 msec.
> 
> 
> As you've already pointed out, though, they occur even with SCHED_FIFO 
> so I'm certain it's an artefact unrelated to cpu scheduling.

Ok to try and answer my own possibility I remounted reiserfs with the 
nolog option and tested with SCHED_ISO

*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     0
Delay Count (>spare time) . . :     1
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :  6750   usecs
Cycle Maximum . . . . . . . . :   717   usecs
Average DSP Load. . . . . . . :    30.7 %
Average CPU System Load . . . :     5.7 %
Average CPU User Load . . . . :    23.2 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     0.6 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1683.8 /sec
Average Context-Switch Rate . : 20015.8 /sec
*********************************************


You'll see on
http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/jack_test3-iso2-40c-nolog.png

That the 20s periodic thing delay has all but gone. Just one towards the 
end (no idea what that was).

Cheers,
Con
