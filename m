Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUHNN4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUHNN4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 09:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUHNN4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 09:56:09 -0400
Received: from [195.23.16.24] ([195.23.16.24]:64924 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262418AbUHNNz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 09:55:58 -0400
Message-ID: <411E148B.8000509@grupopie.com>
Date: Sat, 14 Aug 2004 14:32:59 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it> <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it> <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org> <20040813121502.GA18860@elte.hu> <20040813121800.GA68967@muc.de> <20040813135109.GA20638@elte.hu> <411D9A2A.1000202@grupopie.com> <20040814071546.GB4355@elte.hu>
In-Reply-To: <20040814071546.GB4355@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.10; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Paulo Marques <pmarques@grupopie.com> wrote:
> 
> 
>>>yeah. Maybe someone will find the time to improve the algorithm. But
>>>it's not a highprio thing.
>>
>>Well, I found some time and decided to give it a go :)
> 
> 
> great, your patch is looking really good!

Thanks :)

> 
>>The original algorithm took, on average, 1340us per lookup on my P4
>>2.8GHz. The compile settings for the test are not the same on the
>>kernel, so this can be only compared against other results from the
>>same setup.
> 
> 
> ouch. I consider fixing this a quality of implementation issue.
> 
> 
>>With the attached patch it takes 14us per lookup. This is almost a
>>100x improvement.
> 
> 
> wow! I have tried your patch and /proc/latency_trace now produces
> instantaneous output.

Good to ear

>...
> 
> your patch doesnt add all that much of code. It adds 288 bytes to .text
> and 64 bytes to .data. A typical .config generates 180K of compressed
> kallsyms data (with !KALLSYMS_ALL), so your patch increases the kallsyms
> overhead by a mere 0.2%. So it's really not an issue - especially since
> kallsyms can be disabled in .config. 

The 64 bytes of data can be further tuned using the KALLSYMS_STEM_MARKS 
define.

Setting it to 16 instead of 8 will speed up the algorithm by _almost_ 
twice the speed. As the number grows higher, the speed up is less 
noticeable.

>...
> 
> the standard way is to add the extra initializers. The gcc folks feel
> that those rare cases where gcc gets it wrong justify the benefit of
> catching lots of real bugs. I've added the extra initialization to -O8.

Ok, now that I know how it should be done, next time I'll add them myself :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
