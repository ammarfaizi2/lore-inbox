Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSBGEVt>; Wed, 6 Feb 2002 23:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291099AbSBGEVj>; Wed, 6 Feb 2002 23:21:39 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:9393 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S291102AbSBGEVZ>;
	Wed, 6 Feb 2002 23:21:25 -0500
Message-ID: <3C6200B5.5060704@candelatech.com>
Date: Wed, 06 Feb 2002 21:21:09 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <E16Ydys-0007D6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>>>That is correct UDP behaviour
>>>
>>This is totally untrue, unless the socket doing non-blocking I/O -- and
>>even then you get -1 and EAGAIN from sendto.
>>
> 
> Not the case.


Are you claiming that you will never see -1 and EAGAIN on a nonblocking
UDP socket with sendto?  If so, I'll bet you a kernel patch that you are not
correct (I get to write the patch and you include it :) )


> 
> 
>>there is no way to "lose" that data before it hits the wire, unless of
>>course the network driver is broken and doesn't plug the upper layers when
>>its TX queue is full.
>>
> 
> UDP is not flow controlled.


If it makes it through sendto, where can it be dropped before it
hits the wire?  I doubt the socket buffers are anthing other than FIFO,
and the same goes for the ethernet/device queue.  Since we (can) know
at sendto whether or not the PDU was enqueued for transmit, it seems
trivial to notify user space of success/failure of the local network
stack, and I believe this is what is done.

Now granted, it can be dropped anywhere outside of the machine, but
I can see no good reason to drop it inside the machine.

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


