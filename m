Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132746AbRDDGrY>; Wed, 4 Apr 2001 02:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132752AbRDDGrP>; Wed, 4 Apr 2001 02:47:15 -0400
Received: from [202.54.26.202] ([202.54.26.202]:2719 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132746AbRDDGrF>;
	Wed, 4 Apr 2001 02:47:05 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Fabio Riccardi <fabio@chromium.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Message-ID: <65256A24.0023B110.00@sandesh.hss.hns.com>
Date: Wed, 4 Apr 2001 12:06:56 +0530
Subject: Re: a quest for a better scheduler
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If we are facing these problems for "normal case" then hope the Solaris is
handling it !!

Amol





Fabio Riccardi <fabio@chromium.com> on 04/04/2001 07:03:57 AM

To:   Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:   linux-kernel@vger.kernel.org (bcc: Amol Lad/HSS)

Subject:  Re: a quest for a better scheduler




Alan,

for the "normal case" performance see my other message.

I agree that a better threading model would surely help in a web server, but to
me this is not an excuse to live up with a broken scheduler.

The X15 server I'm working on now is a sort of user-space TUX, it uses only 8
threads per CPU and it achieves the same level of performance of the kernel
space TUX. Even in this case the performance advantage of the multiqueue
scheduler is remarkable, especially on a multi-CPU (> 2) architecture.

To achieve some decent disk/CPU/network overlapping with the current linux
blocking disk IO limitations there is no way to avoid a "bunch of server
threads". I've (experimentally) figured out that 8-16 threads per CPU can
assure some reasonable overlapping, depending on the memory size and disk
subsystem speed. On a 8-way machine this means 64-128 active tasks, a total
disaster with the current scheduler.

Unless we want to maintain the position tha the only way to achieve good
performance is to embed server applications in the kernel, some minimal help
should be provided to goodwilling user applications :)

TIA, ciao,

 - Fabio

Alan Cox wrote:

> > Is there any special reason why any of those patches didn't make it to
> > the mainstream kernel code?
>
> All of them are worse for the normal case. Also 1500 running apache's isnt
> a remotely useful situation, you are thrashing the cache even if you are now
> not thrashing the scheduler. Use an httpd designed for that situation. Then
> you can also downgrade to a cheap pentium class box for the task ;)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




