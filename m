Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVFVSF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVFVSF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVFVSEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:04:35 -0400
Received: from opersys.com ([64.40.108.71]:15118 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261797AbVFVSBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:01:24 -0400
Message-ID: <42B9AA00.7050301@opersys.com>
Date: Wed, 22 Jun 2005 14:12:16 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, paulmck@us.ibm.com,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622173449.GA22474@elte.hu> <20050622174009.GA26059@elte.hu>
In-Reply-To: <20050622174009.GA26059@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
>>you could try the LPPTEST kernel driver and testlpp utility i 
>>integrated into the -RT patchset. It avoids target-side latencies 
>>almost completely. Especially since you had problems with parallel 
>>interrupts you should give it a go and compare the results.
> 
> 
> correction: logger-side latencies are avoided.

Sorry, I don't see this. I've just looked at lpptest.c and it does
practically the same thing  LRTBF is doing, have a look for yourself
at the code in LRTBF.

In fact lpptest.c is probably running at a higher cost on the logger
since it executes a copy_to_user() for every single data point
collected. In the case of the LRTBF, we just buffer the results in a
preallocated buffer and then read them all at once after the testrun.

Unless I'm missing something, there is nothing done in lpptest that
we aren't already doing on either side, logger-side latencies
included.

As for the interrupt problems, they were pilot error. They
disappeared once the APIC was enabled. That's therefore a non-issue.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
