Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVEXNem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVEXNem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEXNek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:34:40 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:55743 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261314AbVEXNbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:31:08 -0400
Message-ID: <42932CD2.3040204@tmr.com>
Date: Tue, 24 May 2005 09:32:02 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       davem@davemloft.net, jmorris@redhat.com
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()
References: <200505232300.j4NN07lE012726@hera.kernel.org>	<20050523162806.0e70ae4f.akpm@osdl.org>	<20050524022106.GA29081@gondor.apana.org.au> <20050523193116.62844826.akpm@osdl.org>
In-Reply-To: <20050523193116.62844826.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
>>Perhaps we should code this into the crypto API instead? For instance,
>> we can have a tfm flag that says whether we can sleep or not.
> 
> 
> Are you sure it's actually needed? Have significant scheduling latencies
> actually been observed?
> 
> Bear in mind that anyone who cares a lot about latency will be running
> CONFIG_PREEMPT kernels, in which case the whole thing is redundant anyway. 
> I generally take the position that if we're going to put a scheduling point
> into a non-premept kernel then it'd better be for a pretty bad latency
> point - more than 10 milliseconds, say.
> 
People do run crypto on old slow machines, and also laptops configured 
to use as little power as possible. I wouldn't be surprised if latencies 
got in the >10ms range pretty regularly on some systems which are pretty 
mainstream.

Just my read on it, if a flag will prevent deadlock without relying on 
callers doing the right thing, that's probably a desirable change WRT 
future stability.
