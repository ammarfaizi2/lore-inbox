Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbTEAWSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbTEAWSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:18:54 -0400
Received: from sj-core-5.cisco.com ([171.71.177.238]:47544 "EHLO
	sj-core-5.cisco.com") by vger.kernel.org with ESMTP id S262728AbTEAWSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:18:11 -0400
From: "Hua Zhong" <hzhong@cisco.com>
To: "Lee, Shuyu" <SLee@cognex.com>, <linux-kernel@vger.kernel.org>
Cc: <root@chaos.analogic.com>, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: How to notify a user process from within a driver
Date: Thu, 1 May 2003 15:29:33 -0700
Message-ID: <CDEDIMAGFBEBKHDJPCLDIEKADNAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-reply-to: <6AF24836F3EB074BA5C922466F9E92E10791B532@prince.pc.cognex.com>
Importance: Normal
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4925.2800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You could have one fd for each line. Create multiple nodes in /dev with
different minor numbers. User space listens to the file(s) it is interested
in.

> Richard and Alan,
>
> Thank you for the info. Given the prototype for poll() is
> "int poll(struct pollfd *ufds, unsigned int nfds, int timeout);",
> and pollfd
> is struct pollfd {int fd; short events; short revents};, how do I
> communicate complex info to the driver?
>
> For example, assuming there are 8 input lines on my hardware, and the user
> wants to be notified in the following three cases:
> 1) input on Line 1 only,
> 2) input on either Line 2 or Line 3,
> 3) input on both Line 4 and Line 5,
> how do I pass that info to the driver? Also, other than POLLERR
> and POLLHUP,
> can I pass back to the user more descriptive error messages?
>
> Thanks,
> Shuyu
>
>
>  -----Original Message-----
> From: 	Richard B. Johnson [mailto:root@chaos.analogic.com]
> Sent:	Thursday, May 01, 2003 3:32 PM
> To:	Lee, Shuyu
> Cc:	linux-kernel@vger.kernel.org
> Subject:	Re: How to notify a user process from within a driver
>
> On Thu, 1 May 2003, Lee, Shuyu wrote:
>
> > Hello, All.
> >
> > I am working on a device driver. One of the features of the hardware is
> > multi-channel I/O control. In order for a user process to
> communicate with
> > the hardware, my design is for the user process to call the
> driver's ioctl
> > to register a semaphore for each I/O channel, then wait on
> them. When the
> > hardware detects an input, the ISR then BH will wake up the
> user process.
> > This sounds straightforward in principle. Because there are two types of
> > semaphores in Linux (one for kernel, and one for user), I am
> not sure how
> > this can be accomplished. Any help would be greatly appreciated.
> >
> > My development environment is:
> > 1) OS:  RedHat 7.2 (Linux 2.4.7),
> > 2) gcc: 3.2.1,
> > 3) PC:  one P-III (HP kayak) with 128Mbyte of memory,
> > 4) Bus: PCI.
> >
> > Shuyu
> >
>
> You normally use poll() or select() for this. It's called poll()
> inside the driver.
>
> The user-mode code sleeps in poll() or select(). When your
> driver ISR wants to wake up the process, it calls
> wake_up_interruptible() from within the ISR.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think about it.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

