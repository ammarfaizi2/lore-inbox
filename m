Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbUBXCg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 21:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbUBXCg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 21:36:58 -0500
Received: from everest.2mbit.com ([24.123.221.2]:17882 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S262097AbUBXCgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 21:36:52 -0500
Message-ID: <403AB897.8070002@greatcn.org>
Date: Tue, 24 Feb 2004 10:36:07 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: Philippe Elie <phil.el@wanadoo.fr>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <c16rdh$gtk$1@terminus.zytor.com> <4039D599.7060001@greatcn.org> <20040223151815.GA403@zaniah>
In-Reply-To: <20040223151815.GA403@zaniah>
X-Scan-Signature: a726be06c385139e599d1e3213de9f7b
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: Does Flushing the Queue after PG REALLY a Necessity?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Elie wrote:

> On Mon, 23 Feb 2004 at 18:27 +0000, Coywolf Qi Hunt wrote:
> 
> 
>>H. Peter Anvin wrote:
>>
>>
>>>Anyone happen to know of any legitimate reason not to reload %cs in
>>>head.S?  I think the following would be a lot cleaner, as well as a
>>>lot safer (the jump and indirect branch aren't guaranteed to have the
>>>proper effects, although technically neither should be required due to
>>>the %cr0 write):
> 
> 
> jump is sufficent when setting PG and required with cpu where cr0 write
> does not serialize.

The problem is there's two jumps in the kernel. Intel's manual only asks 
for "Execute a near JMP instruction".

> 
> 
>>Anyone happen to know of any legitimate reason to flush the prefetch
>>queue after enabling paging?
>>
>>I've read the intel manual volume 3 thoroughly. It only says that after
>>entering protected mode, flushing is required, but never says
>>specifically about whether to do flushing after enabling paging.
>>
>>Furthermore the intel example code enables protected mode and paging at
>>the same time. So does FreeBSD. There's really no more references to check.
>>
>> From the cpu's internal view, flushing for PE is to flush the prefetch
>>queue as well as re-load the %cs, since the protected mode is just about
>>to begin. But no reason to flushing for PG, since linux maps the
>>addresses *identically*.
>>
>>If no any reason, please remove the after paging flushing queue code,
>>two near jump.
> 
> 
> See IA32 vol 3  7.4 and 18.27.3
> 
> Anyway this code is known to work on dozen of intel/non intel processor,
> how can you know if changing this code will not break an obscure clone ?

Right, I also think removing the flush code is risky. Thanks very much, 
chapter 18 is what i was looking for. I recalled in an old intel 
booklet, named like something 386 system guide, says JMP after PG as 
well as PE. But I didn't have that book at hand and didn't find any e-doc.

However, in 18.27.3, "The sequence bounded by the MOV and JMP 
instructions should be identity" implies no JMP is also viable 
practically. But we needn't to be that pedantic.

If no any reason for the two jumps, the code should be fixed to remains 
only ONE near jump.


	Coywolf


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org
