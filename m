Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbSLNXvR>; Sat, 14 Dec 2002 18:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbSLNXvR>; Sat, 14 Dec 2002 18:51:17 -0500
Received: from services.cam.org ([198.73.180.252]:62615 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S266081AbSLNXvQ>;
	Sat, 14 Dec 2002 18:51:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec for 2.5.51....
Date: Sat, 14 Dec 2002 18:59:07 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <200212141215.49449.tomlins@cam.org> <m14r9gv1c8.fsf@frodo.biederman.org>
In-Reply-To: <m14r9gv1c8.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212141859.07191.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 14, 2002 02:37 pm, Eric W. Biederman wrote:
>
> Hurray! a bug report :)

Feels good huh.

> > One other datum.  Without the --append line a kernel booted with kexec
> > hangs when
> >
> > tring to mount the real root - it cannot find the device.
>
> I suspect you want to specify --append="root=/dev/xyz" when calling kexec.

This helps - see below.

> > Am I using kexec correctly?  What else can I try?  Is there any debug
> > info I can gather?
>
> Generally you want to put kexec -e your shutdown scripts just before
> the call to reboot.  And then you can just say: kexec ...
> and the you get a clean system shutdown.  Dropping to run level 1

Why not include this info in kexec -h ?  Bet it would prevent a few
failure reports...

> before calling kexec tends to get most of the user space shutdown
> called as well.  It is definitely a good idea to be certain X is
> shutdown before calling kexec.

droping to init 1, then calling kexec -e (with the root= and the rest
of the appended parms) works and boots 2.5.51 just fine.  <grin>

Two more possible additions to the kexec command.  

1. kexec -q which returns rc=1 and types the pending selection and 
   its command/append string if one exists and returns rc=0 if nothing 
   is pending.  

2. kexec -c which clears any pending kernels.

> With respect to USB it is quite possible something in the USB drivers
> does not shutdown correctly on a reboot, and the driver then has trouble
> reinitializing the device.

Very possible since I did not do an init 0/1/6 before the kexec -e.  Usb
was probably being asked to do something very unexpected...

> Since you got to the point of mounting root earlier when you did not
> specify anything I wonder if you some of your command line arguments
> made the situation worse.
>
> Which kernel are you booting with kexec anyway?

2.5.51 + fbcon(bk) + usb(bk) + kexec

> This is actually an expected failure mode, but one I have not seen
> much of yet.  The new kernel not coming up because the old drivers
> left the hardware in a state the new drivers cannot handle

> Greg kh asked:

>Could you enable CONFIG_USB_DEBUG to hopefully see more debugging
>messages from the uhci driver during boot, so we could narrow this down?

Done.  I will see if I get this to reoccur and will send you debug
output.

TIA,
Ed Tomlinson
