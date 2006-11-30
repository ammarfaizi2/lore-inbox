Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967869AbWK3S4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967869AbWK3S4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 13:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967871AbWK3S4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 13:56:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:51817 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S967869AbWK3S4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 13:56:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aFmfKeI1hED+N96Aqnlk+fh1wfSjH97a1ebO0b61hocB6pHolG4Fxk15Y1PhhGuMA99oA7yls41qnfRH7tu8G/x1mNz/xL+SvDkrB36kkZ2lwJOIXLtK1jW5EG4sDXHuJfq88RoVi1NzLjcZ/+cmxZZz8BMOy22WFptIDdZb2rc=
Message-ID: <1e62d1370611301056h155cd7bfydb437b8248d7844e@mail.gmail.com>
Date: Thu, 30 Nov 2006 23:56:46 +0500
From: "Fawad Lateef" <fawadlateef@gmail.com>
To: "Jon Ringle" <JRingle@vertical.com>
Subject: Re: Reserving a fixed physical address page of RAM.
Cc: "Dave Airlie" <airlied@gmail.com>, "Robert Hancock" <hancockr@shaw.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <22170ADB26112F478A4E293FF9D449F44D1066@secure.comdial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <22170ADB26112F478A4E293FF9D449F44D1066@secure.comdial.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/06, Jon Ringle <JRingle@vertical.com> wrote:
> Jon Ringle wrote:
> > Fawad Lateef wrote:
<snip>
> > > >
> > > > Index: linux/arch/arm/mm/init.c
> > > >
> > ===================================================================
> > > > --- linux.orig/arch/arm/mm/init.c       2006-11-30
> > > 11:03:00.000000000
> > > > -0500
> > > > +++ linux/arch/arm/mm/init.c    2006-11-30
> > 11:09:09.000000000 -0500
> > > > @@ -429,6 +429,10 @@
> > > >         unsigned long addr;
> > > >         void *vectors;
> > > >
> > > > +#ifdef CONFIG_MACH_VERTICAL_RSC4
> > > > +       reserve_bootmem (0x0ffff000, 0x1000); #endif
> > > > +
> > > >         /*
> > > >          * Allocate the vector page early.
> > > >          */
> > > >
> > > >
> > >
> > > I think you can do like this but can't say accurately
> > because I havn't
> > > worked on arm architecture and also you havn't mentioned your
> > > kernel-version or function (in file
> > > arch/arm/mm/init.c) which you are going to do call reserve_bootmem !
> >
> > Kernel version is 2.6.16.29 and the reserve_bootmem() call
> > above is at the top of the function devicemaps_init().
>
> Is there some way I can verify that the above works? I've tried the
> following to try to get info on the reservation:
>         # cat /proc/iomem
>         # cat /proc/meminfo
>         # cat /proc/slabinfo
>         # echo m > /proc/sysrq-trigger
>
> The only one that hints that this might have worked is the `echo m >
> /proc/sysrq-trigger` in that I see the reserved pages count one larger
> than using a kernel without this patch. Does this mean that the page I
> reserved won't get used by Linux for any purpose?
>

I havn't looked at " # echo m /proc/sysrq-trigger" till now but I am
almost sure that it will reserve/work because calling reserve_bootmem
internally sets the bit representing physical memory page (CMIIW).


-- 
Fawad Lateef
