Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbRGQOrs>; Tue, 17 Jul 2001 10:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266550AbRGQOri>; Tue, 17 Jul 2001 10:47:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266546AbRGQOr0>; Tue, 17 Jul 2001 10:47:26 -0400
Date: Tue, 17 Jul 2001 10:46:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alex Ivchenko <aivchenko@ueidaq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 possible problem
In-Reply-To: <3B54454B.97AA34E6@ueidaq.com>
Message-ID: <Pine.LNX.3.95.1010717103652.1430A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001, Alex Ivchenko wrote:

> Guys,
> 
> does anybody use interruptible_sleep_on_timeout(&wqhead, jiffies);
> under 2.4.6 ?
> It seems that after this call sleeping process is never rescheduled again.
> Am I doing something wrong in my driver?
> 
> 
> <10716>
> Knowing that wait queue was reorganized in 2.4 I declared queue head as:
> 
> static DECLARE_WAIT_QUEUE_HEAD(wqhead);
> 
> and then in ioctl routine
  ^^^^^^^^^^^^^^^^^^^^^^^^^ Hmm. Don't decare it again.

funct()
{
    size_t ticks;
    wait_queue_head_t wqhead;
    init_waitqueue_head(&wqhead);

    ticks = 1 * HZ;        /* For 1 second */
    while((ticks = interruptible_sleep_on_timeout(&wqhead, ticks)) > 0)
                  ;
}

That'd oughtta do it. You can skip the loop if you can stand a short
timeout.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


