Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUI1Kst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUI1Kst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUI1Kst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:48:49 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:45735 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266864AbUI1Ksh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:48:37 -0400
Message-ID: <41594180.3010906@yahoo.com.au>
Date: Tue, 28 Sep 2004 20:48:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, tytso@mit.edu
Subject: Re: Stack traces in 2.6.9-rc2-mm4
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net> <20040927085744.GA32407@elte.hu> <1096326753l.5222l.2l@werewolf.able.es> <20040928072123.GA15177@elte.hu> <4159177F.7030803@yahoo.com.au> <20040928102454.GA20271@elte.hu>
In-Reply-To: <20040928102454.GA20271@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>+	preempt_disable();
>>>	/* if over the trickle threshold, use only 1 in 4096 samples */
>>>	if ( random_state->entropy_count > trickle_thresh &&
>>>	     (__get_cpu_var(trickle_count)++ & 0xfff))
>>>-		return;
>>>+		goto out;
>>>
>>
>>It looks like upstream code *is* buggy because that is a non-atomic
>>RMW operation on the per-cpu var, no? Hence you must disable preempt.
> 
> 
> no, the upstream code (i.e. BK-curr) is not buggy, because there this
> code runs under the BKL, implicitly as part of vt_ioctl() - and the BKL 
> disables preemption in the upstream kernel.
> 
> Yes, the code is fragile, but it's not buggy. With the remove-bkl patch
> this fragility turned into an outright bug. (Fortunately the patch
> detects all such incidents.)
> 

Ahh yeah you're right, sorry.
