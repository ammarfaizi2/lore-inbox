Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbUBCD5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 22:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUBCD5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 22:57:01 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:29132 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265797AbUBCD46
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 22:56:58 -0500
Message-ID: <401F1AF4.2040205@cyberone.com.au>
Date: Tue, 03 Feb 2004 14:52:20 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Martin <philip@codematters.co.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>	<20040201151111.4a6b64c3.akpm@osdl.org>	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk>	<401DDCD7.3010902@cyberone.com.au> <401E1131.6030608@cyberone.com.au>	<87d68xcoqi.fsf@codematters.co.uk> <401EDEF2.6090802@cyberone.com.au> <87n081vw55.fsf@codematters.co.uk>
In-Reply-To: <87n081vw55.fsf@codematters.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Philip Martin wrote:

>Nick Piggin <piggin@cyberone.com.au> writes:
>
>  
>
>>Philip Martin wrote:
>>
>>    
>>
>>>Nick Piggin <piggin@cyberone.com.au> writes:
>>>      
>>>
>>>>When the build finishes and there is no other activity, can you
>>>>try applying anonymous memory pressure until it starts swapping
>>>>to see if everything gets reclaimed properly?
>>>>        
>>>>
>>>How do I apply anonymous memory pressure?
>>>      
>>>
>>Well just run something that uses a lot of memory and doesn't
>>do much else. Run a few of these if you like:
>>
>>#include <stdlib.h>
>>#include <unistd.h>
>>#define MEMSZ (64 * 1024 * 1024)
>>int main(void)
>>{
>>    int i;
>>    char *mem = malloc(MEMSZ);
>>    for (i = 0; i < MEMSZ; i+=4096)
>>       mem[i] = i;
>>    sleep(60);
>>    return 0;
>>}
>>    
>>
>
>This is what free reports after the build
>
>             total       used       free     shared    buffers     cached
>Mem:        516396     215328     301068          0      85084      68364
>-/+ buffers/cache:      61880     454516
>Swap:      1156664      40280    1116384
>
>then after starting 10 instances of the above program
>
>             total       used       free     shared    buffers     cached
>Mem:        516396     513028       3368          0        596       5544
>-/+ buffers/cache:     506888       9508
>Swap:      1156664     320592     836072
>
>and then after those programs finish
>
>             total       used       free     shared    buffers     cached
>Mem:        516396      35848     480548          0        964       5720
>-/+ buffers/cache:      29164     487232
>Swap:      1156664      54356    1102308
>
>It looks OK to me.
>
>  
>

Yeah thats looks fine. It was a wild guess.

