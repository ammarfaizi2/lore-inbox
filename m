Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130223AbRCCBts>; Fri, 2 Mar 2001 20:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130224AbRCCBtj>; Fri, 2 Mar 2001 20:49:39 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:15502 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130223AbRCCBt1>; Fri, 2 Mar 2001 20:49:27 -0500
Message-ID: <3AA04C97.11C88837@coplanar.net>
Date: Fri, 02 Mar 2001 20:44:56 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Neelam Saboo <neelam_saboo@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: [Re: paging behavior in Linux]
In-Reply-To: <20010302194303.14346.qmail@www0a.netaddress.usa.net> <3AA00143.47E8368E@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> Neelam Saboo wrote:
> >
> > hi,
> >
> > After I installed a newer version of Kernel (2.4.2) and enable DMA option in

Ah hah!  There's a huge difference in performance (in my experience) with
DMA.  also, using hdparm utility, *most* drives work fine with dma,
irq unmasking, multisector transfers, and 32bit access.
hdparm -i /dev/hda or such will tell you maximum multisector supported.
the only reason these aren't enabled AFAIK is that SOME drives don't,
and when there's a problem it could cause data loss.

The worker thread may just have been overtaking the prefetcher
because dma was off and disk was slow.

>
> > hardware configuration, the behavior changes.
> > I can see performance improvements when another thread is used. Also, i can
> > see timing overlaps between two threads. i.e. when one thread is blocked on a
> > page fault, other thread keeps working.
> > Now, how can this behavior be explained , given the earlier argument.
> > Is it that, a newer version of kernel has fixed the problem of the semaphore
> > ?
> >
> No, that change won't happen until 2.5
>
> I can only guess:
> the other thread keeps working until it causes a page fault - with both
> 2.4.1 and 2.4.2.
>
> I haven't followed the threads about the mm changes closely, but I
> assume that the swapout behaviour changed, and that your worker thread
> now runs without causing page faults.

