Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160044-215>; Tue, 16 Mar 1999 20:58:02 -0500
Received: by vger.rutgers.edu id <160001-215>; Tue, 16 Mar 1999 20:41:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6994 "EHLO penguin.e-mind.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160681-212>; Tue, 16 Mar 1999 20:16:12 -0500
Date: Wed, 17 Mar 1999 02:13:39 +0100 (CET)
From: Andrea Arcangeli <andrea@e-mind.com>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: [patch] recover losed timer interrupt using the TSC [Re: [patch] kstat change to see how much Linux SMP really scale well]
In-Reply-To: <DB1CD925F4F@rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.05.9903170210000.10010-100000@laser.random>
X-Public-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, 16 Mar 1999, Ulrich Windl wrote:

>[...]
>
>> +	register unsigned long delta_usec;
>> +
>> +	__asm__("mull %2"
>> +		:"=a" (delta_cycles), "=d" (delta_usec)
>> +		:"g" (fast_gettimeoffset_quotient), "0" (delta_cycles));
>> +	delta_usec -= delay_usec;
>> +	delta_usec /= 1000000/HZ;
>
>Your delta_usec is in fact a lost_ticks. The name is confusing when 
>you add microseconds to jiffies. (IMHO)

Ok, agreed. It was not a problem right now but removing the `_usec' could
be a better choice. Thanks.

>> -long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */
>> +long tick = 1000000 / HZ;	/* timer interrupt period */
>
>This way the system time will be more behind than before if
>"(1000000 % HZ) >= HZ/2". IMHO the line is correct. After all we are 
>not saying "(1000000 + HZ - 1) / HZ".

;). Agreed. I also needed such trick that to make the recover of the lost
ticks completly relialable. I just removed such changes from my second
patch. But thanks for commenting about that. I wanted to hear if I was
missing something of more serious or it was only an attempt to decrease
the error in integer divisions.

Andrea Arcangeli


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
