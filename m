Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbUBBI7D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 03:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUBBI7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 03:59:03 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:43458 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265653AbUBBI67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 03:58:59 -0500
Message-ID: <401E1131.6030608@cyberone.com.au>
Date: Mon, 02 Feb 2004 19:58:25 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Martin <philip@codematters.co.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>	<20040201151111.4a6b64c3.akpm@osdl.org>	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk> <401DDCD7.3010902@cyberone.com.au>
In-Reply-To: <401DDCD7.3010902@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Philip Martin wrote:
>
>> Nick Piggin <piggin@cyberone.com.au> writes:
>>
>>
>>> Its got 512MB RAM though so its not swapping, is it?
>>>
>>
>> No, it's not swapping.
>>
>>
>>> Philip, can you please send about 30 seconds of vmstat 1
>>> output for 2.4 and 2.6 while the test is running. Thanks
>>>
>>
>> OK.  I rebooted, logged in, shutdown the network, ran find to fill the
>> memory, then did make clean, make -j4, make clean, make -j4.  The
>> vmstat numbers are for the middle of the second make -j4.  I'm using
>> Debian's procps 3.1.15-1.
>>
>>
>> 2.4.24
>>
>> procs -----------memory---------- ---swap-- -----io---- --system-- 
>> ----cpu----
>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>> sy id wa
>> 2  2      0  13848  95012 304080    0    0     0   976  263   811 84 
>> 16  0  0
>

snip

>> 2.6.1
>>
>> procs -----------memory---------- ---swap-- -----io---- --system-- 
>> ----cpu----
>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>> sy id wa
>> 5  0      0  25528 241032  44500    0    0     0     0 1020  1315 63 
>> 37  0  0
>>

snip

Another thing I just saw - you've got quite a lot of memory in
buffers which might be something going wrong.

When the build finishes and there is no other activity, can you
try applying anonymous memory pressure until it starts swapping
to see if everything gets reclaimed properly?

Was each kernel freshly booted and without background activity
before each compile?

Thanks

