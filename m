Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUBLK1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 05:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUBLK1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 05:27:50 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:54458 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264233AbUBLK1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 05:27:49 -0500
Message-ID: <402B5502.2010207@cyberone.com.au>
Date: Thu, 12 Feb 2004 21:27:14 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl
References: <XFMail.20040212104215.pochini@shiny.it>
In-Reply-To: <XFMail.20040212104215.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Giuliano Pochini wrote:

>On 12-Feb-2004 Andrea Arcangeli wrote:
>
>
>>the main difference is that 2.4 isn't in function of time, it's in
>>function of requests, no matter how long it takes to write a request,
>>so it's potentially optimizing slow devices when you don't care about
>>latency (deadline can be tuned for each dev via
>>/sys/block/*/queue/iosched/).
>>
>
>IMHO it's the opposite. Transfer speed * seek time of some
>slow devices is lower than fast devices. For example:
>
>Hard disk  raw speed= 40MB/s   seek time =  8ms
>MO/ZIP     raw speed=  3MB/s   seek time = 25ms
>
>

I like accounting by time better because its accurate
and fair for all types of devices, however I admit an
auto tuning feature would be nice.

Say you allow 16 128K requests before seeking:
The HD will run the requests for 50ms then seek (8ms).
So this gives you about 86% efficiency.
On your zip drive it takes 666ms, giving you 96%.

Now with AS, allowing 50ms of requests before a seek
gives you the same for an HD, but only 66% for the MO
drive. A CD-ROM will be much worse.

Auto tuning wouldn't be too hard. Just measure the time
it takes for your seeking requests to complete and you
can use the simple formula to allow users to specify a
efficiency vs latency %age.


