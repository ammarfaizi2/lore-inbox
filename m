Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVFVS45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVFVS45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFVSx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:53:56 -0400
Received: from opersys.com ([64.40.108.71]:51470 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261806AbVFVSxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:53:13 -0400
Message-ID: <42B9B62B.4070807@opersys.com>
Date: Wed, 22 Jun 2005 15:04:11 -0400
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
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622173449.GA22474@elte.hu> <20050622174009.GA26059@elte.hu> <42B9AA00.7050301@opersys.com> <20050622181449.GC28597@elte.hu>
In-Reply-To: <20050622181449.GC28597@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> you should take another look. The crutial difference is that AFAICS 
> lrtbf is using interrupts on _both_ the logger and the target side.  
> lpptest only uses interrupts on the target side (that is what we are 
> measuring), but uses polling _with all interrupts disabled_ on the 
> logger side. This makes things much more reliable, as it's not some 
> complex mix of two worst-case latencies, but a small constant overhead 
> on the logger side and the worst-case latency on the target side. This 
> also means i can run whatever lpptest version on the logger side, i dont 
> have to worry about its latencies because there are none that are 
> variable.

I see. Granted, this is different. We will redo a limited testset
with either lpptest or a modified version of LRTBF that does
exactly what you describe. Specifically, we will redo the testrun
that is the most painfull to vanilla Linux in terms of interrupt
latency, the HD test, for both preempt_rt and ipipe.

However, I have very serious doubts that this will make any
difference whatsoever. Granted the numbers will be slightly lowever,
but it won't invalidate the conclusions previously obtained and it
still won't allow any of us to isolate the exact hardware-
specific overhead of interrupt delivery. IOW, I want to make
sure that it is clear that we're not doing this because we doubt
our results. To the contrary, we're doing it to ensure that any
doubts regarding our results are dissipated.

> logger-side overhead does not matter at all, and the 8 bytes copy is not 
> measured in the overhead. (it is also insignificant.)

Maybe, but your user-space application does a printf on every data
point it gets ... Not the best that can be. The clean thing to do
here is to cumulate the stuff in a buffer and dump it all postmortem.

> well, LPPTEST works just fine with the i8259A PIC too. (which is much 
> more common in embedded setups than IO-APICs)

LRTBF doesn't have a problem with the i8259a, it's the hardware
we were using that didn't behave properly under high interrupt
load. This is a system-specific problem. I haven't run lpptest on
the actual target we used, but I have no reason to believe it
wouldn't behave the same types of problems we got with LRTBF.
There is no difference on the target-side between LRTBF and
lpptest.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
