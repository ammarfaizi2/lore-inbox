Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136168AbRD0S55>; Fri, 27 Apr 2001 14:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136169AbRD0S5r>; Fri, 27 Apr 2001 14:57:47 -0400
Received: from mail1.bna.bellsouth.net ([205.152.150.13]:37559 "EHLO
	mail1.bna.bellsouth.net") by vger.kernel.org with ESMTP
	id <S136168AbRD0S5h>; Fri, 27 Apr 2001 14:57:37 -0400
From: volodya@mindspring.com
Date: Fri, 27 Apr 2001 14:57:30 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: johan verrept <johan.verrept@pandora.be>
cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Tony Hoyle <tmh@magenta-netlogic.com>
Subject: Re: [linux-usb-devel] Repeatable lockup on SMP w/usbprocfs
In-Reply-To: <3AC26865.8D034960@pandora.be>
Message-ID: <Pine.LNX.4.20.0104271453120.590-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Mar 2001, johan verrept wrote:

> Tony Hoyle wrote:
> > 
> > If an application calls the USBDEVFS_SUBMITURB ioctl to submit a read,
> > when the async completion routine is called, the kernel goes into a hard
> > deadlock (no response to ping, etc.).  I've narrowed it down to the
> > async_completed routine in usb.c.  That's the only place where spinlocks
> > are used.  I'm not familiar enough with them to see what the error is,
> > though.
> 
> It is async_completed in devio.c btw.
> I have looked at this too, but I am not sure whether this happens when the completion is called or
> when the program does a USBDEVFS_REAPURB(NDELAY).
> I have looked at the code, but I do not see anything obviously wrong.
> 
> One thing I considered weird is the "wake_up(&ps->wait);" in async_completed().
> This will wake up the program that has submitted the urb, whether is expects to be woken or not. I
> am not sure what the consequences of this are, but it seems harmless enough.
> 
> > The system runs fine until the packet is returned, then it just locks 
> > solid (On the alcatel USB modem I used for testing it will not respond 
> > until it gets sync, which may be several seconds).
> 
> I have also noticed this only with the Alcatel SpeedTouch USB driver. I am not aware of any other
> driver that uses this although I am writing one that will be using this. It is very possible the
> program does something wrong (For example the code mixes the async and the sync versions of the urb
> ioctl's...), but even then it is not supposed to be able to lock up the whole machine.
> 
> > Others have found that just compiling SMP into the kernel is enough to
> > break it, you don't actually need two processors.
> 
> Probably because when you turn SMP off, spinlocks are disabled so deadlocks are avoided.
> 

I have the similar problem (also with Alcatel modem).. Besides everything
else I, sometimes, get an oops in process 0 (swapper) - looks like some
memory corruption going on. I really hate it when the control app is
binary only. There are some obvious bugs in it (try running 'mgmt creset')
and alcatel supplied it as an object file (which might/is breaking glibc
compatibility) instead of a fully linked binary.

                        Vladimir Dergachev


> 	J.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

