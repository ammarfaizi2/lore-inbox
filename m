Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278271AbRJSCxu>; Thu, 18 Oct 2001 22:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278278AbRJSCxl>; Thu, 18 Oct 2001 22:53:41 -0400
Received: from bacon.van.m-l.org ([208.223.154.200]:64641 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S278271AbRJSCxZ>; Thu, 18 Oct 2001 22:53:25 -0400
Date: Thu, 18 Oct 2001 22:53:44 -0400 (EDT)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
cc: Leo Mauro <lmauro@usb.ve>, <linux-kernel@vger.kernel.org>
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
In-Reply-To: <200110182223.f9IMNAW24982@mailg.telia.com>
Message-ID: <Pine.LNX.4.33.0110182252050.13061-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Roger Larsson wrote:

>On Thursday 18 October 2001 04:01, Leo Mauro wrote:
>> Small fix to Linus's sample code
>>
>>  	unsigned int so_far = 0;
>>  	for (;;) {
>>  		int bytes = read(in, buf+so_far, BUFSIZE-so_far);
>>  		if (bytes <= 0)
>>  			break;
>>  		so_far += bytes;
>>  		if (so_far < BUFSIZE)
>>  			continue;
>>  		write(out, buf, BUFSIZE);
>> - 		so_far = 0;
>> +		so_far -= BUFSIZE;
>>  	}
>>  	if (so_far)
>>  		write(out, buf, so_far);
>>
>> to avoid losing data.
>
>I was close to press the send button but noticed the "BUFSIZE-so_far"
>in the read call, just in time(TM).
>
>If it had not been there you would have needed to copy data from the
>end of buf (from above BUFSIZE) to the beginning of buf too...
>(the required size of buf would have been 2*BUFSIZE)

Since you only ever have BUFSIZE bytes when you write, aren't:

  so_far -= BUFSIZE;

and

  so_far = 0;

identical? I'd say the assignment to 0 would be faster.

-- 
George Greer, greerga@m-l.org
http://www.m-l.org/~greerga/

