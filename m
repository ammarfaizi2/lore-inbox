Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268474AbRGYEO6>; Wed, 25 Jul 2001 00:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268469AbRGYEOs>; Wed, 25 Jul 2001 00:14:48 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:30170 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S266519AbRGYEOl>; Wed, 25 Jul 2001 00:14:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Richard B. Johnson" <root@chaos.analogic.com>,
        Damien TOURAINE <damien.touraine@limsi.fr>
Subject: Re: Call to the scheduler...
Date: Tue, 24 Jul 2001 15:12:19 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010724134717.32263A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010724134717.32263A-100000@chaos.analogic.com>
MIME-Version: 1.0
Message-Id: <01072415121901.00631@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 13:54, Richard B. Johnson wrote:

> Try sched_yield(). Accounting may still be messed up so the process
> may be 'charged' for CPU time that it gave up. Also, usleep(n) works
> very well with accounting working.
>
> This works, does not seem to load the system, but `top` shows
> 99+ CPU time usage:
>
> main()
> {
>     for(;;) sched_yield();
>
> }

This may not be an accounting problem.  If the system has nothing else to do, 
it'll just re-schedule your yielding thread.

How much of that 99% cpu usage is user and how much of it is system?  
Basically what the above does is beat the scheduler to death...

> This works and `top` shows nothing being used:
>
> main()
> {
>
>     for(;;) usleep(1);
>
> }

And here you DO block for a bit without getting called back immediately.

I don't think that's an accounting thing, I think it's different behavior.  
(Could be wrong, as always...)

>
> Cheers,
> Dick Johnson

Rob
