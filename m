Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbTIJTIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265498AbTIJTIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:08:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:9438 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265565AbTIJTGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:06:47 -0400
Message-ID: <3F5F7604.9040305@austin.ibm.com>
Date: Wed, 10 Sep 2003 14:05:40 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Cliff White <cliffw@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <200309092353.h89NrTN31627@mail.osdl.org> <3F5E8897.7040302@cyberone.com.au>
In-Reply-To: <3F5E8897.7040302@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>
> Cliff White wrote:
>
>>> Nick Piggin wrote:
>>>
>>> Con Kolivas wrote:
>>>
>>>
>>> Hi Con,
>>> Any chance you could give this
>>> http://www.kerneltrap.org/~npiggin/v14/sched-rollup-nopolicy-v14.gz
>>> a try? It should apply against test5.
>>>
>>>
>>>
>> I have some STP tests scheduled against this also (PLM 2117) Please 
>> let me know if you want other combinations tested - am just catching 
>> up on
>> this thread.
>> cliffw
>>
>
> Thanks Cliff that would be cool. If you could test  this: 
> http://www.kerneltrap.org/~npiggin/v14/sched-rollup-v14.gz
> as well would be good. The previous one is more important though. 


 I gave this a try on the same setup that I am using for the regression 
tests and the scheduler tests for Andrew.  What I got was the following 
oops:

CPU:    5
EIP:    0060:[<c011c577>]    Not tainted
EFLAGS: 00010003
EIP is at load_balance+0x257/0x3f0
eax: f6583998   ebx: c6099518   ecx: 00000000   edx: c60b9100
esi: c6099518   edi: c60994f8   ebp: f64bff44   esp: f64bff14
ds: 007b   es: 007b   ss: 0068
Process java (pid: 3482, threadinfo=f64be000 task=f6b13300)
Stack: c6099104 c6098bc0 c6099518 c6099100 00000000 00000005 00000080 
000000ff
       00000002 f6b13300 c60b9100 c60b8bc0 f64bff8c c011cef9 c60b8bc0 
00000001
       000000ff f64be000 c60b8bc0 c011ca9d f6b13300 00000000 00000002 
c60a8bc0
Call Trace:
 [<c011cef9>] schedule+0x4d9/0x550
 [<c011ca9d>] schedule+0x7d/0x550
 [<c010a08d>] sys_rt_sigsuspend+0xed/0x130
 [<c010b01f>] syscall_call+0x7/0xb

Code: 89 19 89 4b 04 8b 47 18 0f ab 42 04 ff 02 89 57 28 8b 55 08


Steve


