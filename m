Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280203AbRKIVyr>; Fri, 9 Nov 2001 16:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280200AbRKIVyb>; Fri, 9 Nov 2001 16:54:31 -0500
Received: from oe36.law11.hotmail.com ([64.4.16.93]:7433 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S280195AbRKIVyV>;
	Fri, 9 Nov 2001 16:54:21 -0500
X-Originating-IP: [66.108.21.174]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: "J Sloan" <jjs@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <F5uLCTaogxLDp7mvjkO00000742@hotmail.com> <3BEB5149.B0B7990F@pobox.com>
Subject: Re: CPQARRAY driver horribly broken in 2.4.14
Date: Fri, 9 Nov 2001 16:51:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE36joYAPNXRPmcarcR0001ece1@hotmail.com>
X-OriginalArrivalTime: 09 Nov 2001 21:54:14.0754 (UTC) FILETIME=[12985420:01C16969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Thanks a lot for the help.  Any particular reason to use the new driver
now or should I just wait until 2.4.15 is release?

    Guess I didn't need to do all that debugging.  Bug may have already been
caught.  8-)

    However I did notice something.  The patch you've included below covers
the cciss.c file?  My system is using the cpqarray driver.  And I fixed the
problem by replacing the cpqarray.[ch], ida_cmd.h, and ida_ioctl.h files.  I
don't think the patch below would have done anything for me as I'm pretty
sure the cciss.c file isn't used by the cpqarray driver and since I didn't
change out the cciss.c file in my now working kernel source tree (linux
2.4.14-lkd1 8-D).

----- Original Message -----
From: "J Sloan" <jjs@pobox.com>
To: "Linux Kernel Developer" <linux_developer@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, November 08, 2001 10:45 PM
Subject: Re: CPQARRAY driver horribly broken in 2.4.14


> Linux Kernel Developer wrote:
>
> > Hi all,
> >
> >      I'm using the cpqarray driver for a Compaq Smart Arrat 3100ES
> > controller on a Compaq Proliant 7000.  Today I tried upgrading the
kernel to
> > 2.4.14.  Soon after the upgrade I though about making a small change in
the
> > kernel however as soon as I tried doing a "make dep" the system oopsed
and
> > froze.
>
> Been there, done that, bought the t-shirt.
>
> The attached patch courtesy of Jens Axboe
> fixed my Compaq 6500 which was giving me
> fits - basically in 2.4.14 it had a nasty habit of
> scribbling on the disk and then locking up,
> requiring a power cycle, manual fsck and
> file restoration to get it running again.
>
> With this patch 2.4.14 has been solid.
>
> cu
>
> jjs
>
>
>


----------------------------------------------------------------------------
----


> --- linux/drivers/block/cciss.c~ Thu Nov  8 11:36:24 2001
> +++ linux/drivers/block/cciss.c Thu Nov  8 11:37:03 2001
> @@ -1307,6 +1307,8 @@
>   if (( c = cmd_alloc(h, 1)) == NULL)
>   goto startio;
>
> + blkdev_dequeue_request(creq);
> +
>   spin_unlock_irq(&io_request_lock);
>
>   c->cmd_type = CMD_RWREQ;
> @@ -1386,12 +1388,6 @@
>
>   spin_lock_irq(&io_request_lock);
>
> - blkdev_dequeue_request(creq);
> -
> -        /*
> -         * ehh, we can't really end the request here since it's not
> -         * even started yet. for now it shouldn't hurt though
> -         */
>   addQ(&(h->reqQ),c);
>   h->Qdepth++;
>   if(h->Qdepth > h->maxQsinceinit)
>
