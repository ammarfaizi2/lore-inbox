Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUFPDTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUFPDTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUFPDTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:19:34 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:27810 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266105AbUFPDTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:19:20 -0400
Message-ID: <40CFBC1B.6000400@yahoo.com.au>
Date: Wed, 16 Jun 2004 13:18:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, mingo@elte.hu,
       kernel@kolivas.org, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, akpm@osdl.org, wli@holomorphy.com,
       markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
References: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au> <40CFB8FD.2010601@yahoo.com.au> <Pine.LNX.4.58.0406152009220.4142@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406152009220.4142@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 16 Jun 2004, Nick Piggin wrote:
> 
>>I think balance on clone probably needs to be turned off by default
>>presently.
>>
>>It slows down a simple thread creation test by a factor of 7(!) here,
>>and has quite a few not too difficult to imagine performance problems.
> 
> 
> I agree. However, I still think we should do my suggested
> "wake_up_new(p,clone_flags)" thing, and then have the logic on whether to 
> try to care about threading or not be in schedule.c, not in kernel/fork.c.
> 
> The fact is, fork.c shouldn't try to make scheduling decisions. But it 
> could inform the scheduler about the new process, and THAT can then make 
> the decisions.
> 

I agree, it is a fine suggestion. Would be a trivial change, and
would clean things up nicely.
