Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUHDLMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUHDLMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUHDLMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:12:05 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:41609 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264900AbUHDLL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:11:59 -0400
Message-ID: <4110BB88.3030400@yahoo.com.au>
Date: Wed, 04 Aug 2004 20:33:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <cone.1091614334.471559.9775.502@pc.kolivas.org>
In-Reply-To: <cone.1091614334.471559.9775.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Nick Piggin writes:

>> And child-runs-first in wake_up_new_task. Please don't.
> 
> 
> It does child runs first by design in staircase. You don't need any more.
> 

Oh ok. Well please don't remove the check anyway.

>> Also, basic interactivity in X is bad with the interactive sysctl set 
>> to 0
> 
> 
> Well duh... disable interactivity and interactivity is bad. What's the 
> problem? It's not meant to be used on a desktop in that way.
> 

Well why would you want to disable it then?

>> (is X supposed to be at nice 0?), however fairness is bad when 
>> interactive is 1.
>> I'm not sure if this is an acceptable tradeoff - are you planning to 
>> fix it?
> 
> 
> Why? A single user desktop is hardly needing extremely accurate cpu 
> distribution... we see that already in 2.6.
> 

No, I'm talking about one task getting *double* the amount of CPU as
another, when it should actually be getting a little bit less.

>> It has interactivity problems with "thud". Also the mouse can freeze 
>> for .5 to 1
>> second when moving between windows while there is disk IO going on in 
>> the background
>> (this is with interactive = 1). The test-starve problem is back.
> 
> 
> Hmm? a minor mouse freeze with a _test_ starvation program is not 
> starvation; nor is it an interactivity problem. Yours is the first 
> complaint about interactivity during i/o.

The mouse was often freezing for me when moving over windows with
IO running. That was an interactivity problem for me.

Thud itself isn't a problem I guess. Just thought you might like to know.

The test-starve problem actually is a problem though.

> 
>> Increasing priority (negative nice) doesn't have much impact. -20 CPU 
>> hog only gets
>> about double the CPU of a 0 priority CPU hog and only about 120% the 
>> CPU time of a
>> nice -10 hog.
> 
> 
> -20 is 40 rr intervals. 0 is 20 rr intervals. +19 is 1 rr interval. 
> Seems to me the cpu distribution is working our absolutely perfectly as 
> designed.
> 

Well maybe it should be re designed. If an admin wants a task to get a
decent amount of CPU, it is not reasonable to nice +19 everything else.

> Why is the only critic of this the person with a competing design? Does 
> anyone else object to these things? I certainly dont feel objective 
> enough to criticise yours.
> 

No need to get a bee in your bonet. I was pointing out some things that
you need to fix if you are serious about this. I'd rather not replace
the scheduler with a known broken one.

Oh, and I would very much like you to criticise mine :)
