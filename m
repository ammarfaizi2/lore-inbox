Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSBHTYE>; Fri, 8 Feb 2002 14:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291754AbSBHTXz>; Fri, 8 Feb 2002 14:23:55 -0500
Received: from f250.law11.hotmail.com ([64.4.16.75]:3592 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291753AbSBHTXt>;
	Fri, 8 Feb 2002 14:23:49 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: tigran@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] larger kernel stack (8k->16k) per task (fwd)
Date: Fri, 08 Feb 2002 11:23:43 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F2500h9N7AeVRZ24Qri0000fd95@hotmail.com>
X-OriginalArrivalTime: 08 Feb 2002 19:23:43.0424 (UTC) FILETIME=[1F17FC00:01C1B0D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tigran,

>From: Tigran Aivazian <tigran@veritas.com>
>To: Balbir Singh <balbir_soni@hotmail.com>
>CC: <linux-kernel@vger.kernel.org>
>Subject: Re: [patch] larger kernel stack (8k->16k) per task (fwd)
>Date: Fri, 8 Feb 2002 19:01:06 +0000 (GMT)
>
>Hi Balbir,
>
>On Fri, 8 Feb 2002, Balbir Singh wrote:
> > 2. I think you missed getuser.S in arch/i386/kernel/lib.
> >    All the __get_user_x should change to
>
>no, I didn't miss them. If you read the patch again you will see them.
>
> >
> > 3. I verified that the instance of GET_CURRENT in hw-irq.h
> >    is not being used by anybody and can safely be removed.
>
>yes, I also verified and came to the same conclusion but left the change
>in the patch on purpose (so if anyone does start using it, it is already
>correct)
>
> >
> > __get_user_1:
> >         movl %esp,%edx
> >         andl $~(THREAD_SIZE - 1),%edx
> >         cmpl addr_limit(%edx),%eax
> >
> > I have a patch that lets the user select any stack size
> > from 8K to 64K, it can be configured. And yes, it works
> > on my system.
> >
> > I do not have the /proc entry that u have though in
> > my patch.
> >
> > Would you like to merge both the patches or would you
> > like me to do it and send out a new version.
> >
> >
> > The patch is attached along with this email. It
> > is againt 2.4.17
>
>The serious problem with your patch is that you missed quite a few places
>(e.g.  smpboot.c and traps.c). Most importantly, you missed the alignment
>in vmlinux.lds so I guess your machine boots by pure luck :) In the early
>stages (first hours of writing it) I missed that one too and was puzzled
>by random panics on boot...
>

I can explain the vmlinux.lds with the fact that
I think we should not change the size of init_task
in sched.h. It would affect all the architectures.
As I mentioned, I followed the PARISC model.

Yes, I did miss out changes in traps.c and smpboot.c
Thanks for pointing them out.


>Actually, the patch I sent is only part of the "complete piece", the other
>part being changes to kdb to work correctly with large stack. I can
>separate those from kdb patch that I use and send out if there was enough
>interest.
>
>Regards,
>Tigran
>




_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

