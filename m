Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSCRTMM>; Mon, 18 Mar 2002 14:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292289AbSCRTME>; Mon, 18 Mar 2002 14:12:04 -0500
Received: from smtp1.extremenetworks.com ([216.52.8.6]:38276 "HELO
	smtp1.extremenetworks.com") by vger.kernel.org with SMTP
	id <S292130AbSCRTLx>; Mon, 18 Mar 2002 14:11:53 -0500
Message-ID: <3C963BF2.C9D78479@extremenetworks.com>
Date: Mon, 18 Mar 2002 11:11:46 -0800
From: Jason Li <jli@extremenetworks.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL doesn't work
In-Reply-To: <2643.1016433275@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 17 Mar 2002 22:25:16 -0800,
> Jason Li <jli@extremenetworks.com> wrote:
> >int (*fdbIoSwitchHook)(
> >                           unsigned long arg0,
> >                           unsigned long arg1,
> >                           unsigned long arg2)=NULL;
> >EXPORT_SYMBOL(fdbIoSwitchHook);
> >gcc -D__KERNEL__ -I/home/jli/cvs2/exos/linux/include -Wall
> >-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> >-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> >-march=i686    -c -o br_ioctl.o br_ioctl.c
> >br_ioctl.c:26: warning: type defaults to `int' in declaration of
> >`EXPORT_SYMBOL'
> 
> #include <linux/module.h>
> 
> Also add br_ioctl.o to export-objs in Makefile.

Thanks alot. It works.

Now another problem with versioning. It seems even after I have the
following in my module c file the symbol generated is not versioned:

#define MODULE
#include <linux/modversions.h>
#include <linux/kernel.h>

When I do nm on the module, fdbIoSwitchHook is still a pure name without
the version info. Can you please tell me how to enable the versioning
for the symbol fdbIoSwitchHook?

Appreciate your help!

-Jason
