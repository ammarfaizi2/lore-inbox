Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUDAQrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUDAQrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:47:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4998 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262238AbUDAQrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:47:46 -0500
Date: Thu, 1 Apr 2004 11:50:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Arjan van de Ven <arjanv@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Peter Williams <peterw@aurema.com>,
       ak@muc.de, Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
In-Reply-To: <20040401163047.GD25502@mail.shareable.org>
Message-ID: <Pine.LNX.4.53.0404011146490.21282@chaos>
References: <1079453698.2255.661.camel@cube> <20040320095627.GC2803@devserv.devel.redhat.com>
 <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com>
 <20040331134009.76ca3b6d.rddunlap@osdl.org> <1080776817.2233.2326.camel@cube>
 <20040401155420.GB25502@mail.shareable.org> <20040401160132.GB13294@devserv.devel.redhat.com>
 <20040401163047.GD25502@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Jamie Lokier wrote:

> Arjan van de Ven wrote:
> > HZ doesn't mean nothing, esp when we go to a tickless kernel...
>
> As explained several times in this thread, HZ is meaningful because it
> affects the rounding in select/poll/epoll/setitimer.  A few userspace
> programs with low jitter soft-RT timing requirements need to
> compensate for that rounding and/or deliberately synchronise
> themselves with the tick.
>
> Such programs can determine HZ experimentally and lock onto the tick
> in the manner of a PLL, but it would be nice to simply be able to
> have the value, to reduce the number of control variables.
>
> When we go to a tickless kernel and offer high-resolution timers to
> userspace, then it will be irrelevant.  Until then, or if the kernel
> goes tickless but limits the resolution of timers for efficiency, the
> value of HZ is still relevant.
>
> Not to get irritatingly back to the subject of this thread or
> anything, but...  is the value of HZ reported to userspace anywhere?
>
> Thanks :)
> -- Jamie

I may be naive, but what's the matter with:

#include <stdio.h>
#include <sys/param.h>   // Required to be here!
int main()
{
    printf("HZ=%d\n", HZ);
    return 0;
}
It works for me.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


