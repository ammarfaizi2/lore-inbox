Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286390AbRLJVPK>; Mon, 10 Dec 2001 16:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286396AbRLJVPA>; Mon, 10 Dec 2001 16:15:00 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:48831 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S286390AbRLJVOv>;
	Mon, 10 Dec 2001 16:14:51 -0500
Message-ID: <3C1525C7.1030408@candelatech.com>
Date: Mon, 10 Dec 2001 14:14:47 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: min-write-size for a UDP socket to be POLLOUT cannot be set. (proposed fixes)
In-Reply-To: <Pine.LNX.3.95.1011210153555.742A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

> On Mon, 10 Dec 2001, Ben Greear wrote:

>>I have 4M queue size.  I have 4M-2k bytes already in the
>>queue (2k free).  I have a 4k UDP buffer to write.  I call
>>select and it says the socket is writable.  However, in this
>>case I cannot actually write to the socket because I have only
>>2 of the 4k that I need...  Now, I can detect the failure to send
>>and re-transmit, but that basically gets me into a tight loop because
>>select keeps saying I can write, and I keep trying.  The tight loop
>>is doubly bad because the machine is already highly stressed or it's
>>buffers would never be so full....
>>
>>I want select to only say I can write when I'm at XX (say, 64k) bytes of
>>free buffer-queue space...
>>
>>Ben
>>
>>
> 
> If you have a 4M queue size, it appears as though you are trying to
> use UDP where TCP should have been used. Normally, what you call the
> queue size, is set to contain you largest packet you will ever want to
> send. With this in mind, you don't even know if a fragmented packet
> can be routed if it's more than 64k in length so you would never try
> to send something larger than that under UDP.


Assume that I actually want to do what I said I did! :)

I never try to send
a packet bigger than 64k, the protocol doesn't handle it.  But, I may try
to send 100000 60k UDP packets in very fast succession...which could fill up my
send queue.



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


