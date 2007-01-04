Return-Path: <linux-kernel-owner+w=401wt.eu-S964806AbXADSKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbXADSKy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbXADSKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:10:54 -0500
Received: from mail.tmr.com ([64.65.253.246]:35603 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964806AbXADSKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:10:53 -0500
Message-ID: <459D4335.2090500@tmr.com>
Date: Thu, 04 Jan 2007 13:11:01 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Peter Staubach <staubach@redhat.com>
CC: Hugh Dickins <hugh@veritas.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <459CEA93.4000704@tls.msk.ru> <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com> <459D290B.1040703@tmr.com> <Pine.LNX.4.64.0701041653250.12920@blonde.wat.veritas.com> <459D3F4A.5070904@redhat.com>
In-Reply-To: <459D3F4A.5070904@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach wrote:
> Hugh Dickins wrote:
>> On Thu, 4 Jan 2007, Bill Davidsen wrote:
>>  
>>> In many cases the use of O_DIRECT is purely to avoid impact on cache 
>>> used by
>>> other applications. An application which writes a large quantity of 
>>> data will
>>> have less impact on other applications by using O_DIRECT, assuming 
>>> that the
>>> data will not be read from cache due to application pattern or the 
>>> data being
>>> much larger than physical memory.
>>>     
>>
>> I see that as a good argument _not_ to allow O_DIRECT on tmpfs,
>> which inevitably impacts cache, even if O_DIRECT were requested.
>>
>> But I'd also expect any app requesting O_DIRECT in that way, as a caring
>> citizen, to fall back to going without O_DIRECT when it's not supported.
>
> I suppose that one could also argue that the backing store for tmpfs
> is the memory itself and thus, O_DIRECT could or should be supported. 

I suspect that many applications don't try to distinguish an open error 
beyond pass/fail. If the application actually tried to correct errors, 
like creating missing directories, it might, but if the error is going 
to be reported to the user and treated as fatal there's probably no 
logic to tell "can't do it" from "could if you asked the right way."

I always thought the difference between Linux and Windows was the "big 
brother" attitude. If someone wants to use O_DIRECT and tmpfs, and the 
system can allow it, why have code to block it because someone thinks 
they know better how the users should do things.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

