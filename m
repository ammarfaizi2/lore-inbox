Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267914AbUHKDb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267914AbUHKDb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267915AbUHKDb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:31:27 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:14285 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267914AbUHKDbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:31:25 -0400
References: <20040811010116.GL11200@holomorphy.com> <20040811022143.4892.qmail@web13910.mail.yahoo.com> <20040811022345.GN11200@holomorphy.com> <41198859.7050807@bigpond.net.au> <411988DF.9010308@bigpond.net.au> <41199129.9080809@bigpond.net.au>
Message-ID: <cone.1092195076.205601.25569.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: spaminos-ker@yahoo.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
         others)
Date: Wed, 11 Aug 2004 13:31:16 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams writes:

> Peter Williams wrote:
>> Peter Williams wrote:
>> 
>>> William Lee Irwin III wrote:
>>>
>>>> On Tue, Aug 10, 2004 at 07:21:43PM -0700, spaminos-ker@yahoo.com wrote:
>>>>
>>>>> I am not very familiar with all the parameters, so I just kept the 
>>>>> defaults
>>>>> Anything else I could try?
>>>>> Nicolas
>>>>
>>>>
>>>>
>>>>
>>>> No. It appeared that the SPA bits had sufficient fairness in them to
>>>> pass this test but apparently not quite enough.
>>>>
>>>
>>> The interactive bonus may interfere with fairness (the throughput 
>>> bonus should actually help it for tasks with equal nice) so you could 
>>> try setting max_ia_bonus to zero (and possibly increasing 
>>> max_tpt_bonus). With "eb" mode this should still give good interactive 
>>> response but expect interactive response to suffer a little in "pb" 
>>> mode however renicing the X server to a negative value should help.
>> 
>> 
>> I should also have mentioned that fiddling with the promotion interval 
>> may help.
> 
> Having reread your original e-mail I think that this problem is probably 
>   being caused by the interactive bonus mechanism classifying the httpd 
> server threads as "interactive" threads and giving them a bonus.  But 
> for some reason the daemon is not identified as "interactive" meaning 
> that it gets given a lower priority.  In this situation if there's a 
> large number of httpd threads (even with promotion) it could take quite 
> a while for the daemon to get a look in.  Without promotion total 
> starvation is even a possibility.
> 
> Peter
> PS For both "eb" and "pb" modes, max_io_bonus should be set to zero on 
> servers (where interactive responsiveness isn't an issue).
> PPS For "sc" mode, try setting "interactive" to zero and "compute" to 1.

No, compute should not be set to 1 for a server. It is reserved only for 
computational nodes, not regular servers. "Compute"  will increase latency 
which is undersirable.

Cheers,
Con

