Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbQJ2S2B>; Sun, 29 Oct 2000 13:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130260AbQJ2S1v>; Sun, 29 Oct 2000 13:27:51 -0500
Received: from lolita.speakeasy.net ([216.254.0.13]:21320 "HELO
	lolita.speakeasy.net") by vger.kernel.org with SMTP
	id <S130216AbQJ2S1m>; Sun, 29 Oct 2000 13:27:42 -0500
Message-ID: <39FC78BF.90607@speakeasy.org>
Date: Sun, 29 Oct 2000 11:21:35 -0800
From: Miles Lane <miles@speakeasy.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10 i686; en-US; m18) Gecko/20001025
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Rui Sousa <rsousa@grad.physics.sunysb.edu>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
In-Reply-To: <20001027134603.A513@suse.de> <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain> <20001027202710.A825@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Sat, Oct 28 2000, Rui Sousa wrote:
> 
>> After adding
>> 
>> #define ELEVATOR_HOLE_MERGE     3
>> 
>> to linux/include/linux/elevator.h it compiled ok.
> 
> 
> Oops sorry, I'm on the road so the patch was extracted
> from my packet writing tree (and not my regular tree).
> 
> 
>> There were still some stalls but they only lasted a couple of
>> seconds. The patch did make a difference and for the better.
> 
> 
> Ok, still needs a bit of work. Thanks for the feedback.

Have you resolved this problem completely, now?

I am testing the USB Storage support with my ORB backup
drive.  When I run:

	dd if=/dev/zero of=/dev/sda bs=1k count=2G

The drive gets data quickly for about thirty seconds.
Then the throughput drops off to about ten percent
of its previous transfer rate.  This dropoff appears to
be due to conflict over accessing filesystems.  Specifically,
I have USB_STORAGE_DEBUG enabled, which shoots a ton of
debugging output into my kernel log.  When the throughput
to the ORB drive falls off, all writing to the syslog
ceases.  At least, that's what "tail -f" shows.

I would be happy to test any patches you have for this
problem.

I hope this helps,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
