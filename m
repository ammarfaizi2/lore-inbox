Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSLOUzq>; Sun, 15 Dec 2002 15:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSLOUzp>; Sun, 15 Dec 2002 15:55:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29564 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262646AbSLOUzo>; Sun, 15 Dec 2002 15:55:44 -0500
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] kexec for 2.5.51....
References: <200212141215.49449.tomlins@cam.org>
	<m14r9gv1c8.fsf@frodo.biederman.org>
	<200212141859.07191.tomlins@cam.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Dec 2002 14:03:17 -0700
In-Reply-To: <200212141859.07191.tomlins@cam.org>
Message-ID: <m11y4jatbe.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> writes:

> On December 14, 2002 02:37 pm, Eric W. Biederman wrote:
> >
> > Hurray! a bug report :)
> 
> Feels good huh.

Getting new and interesting feedback is good.  You can tell something
is happening if a bug report is submitted.

> > > One other datum.  Without the --append line a kernel booted with kexec
> > > hangs when
> > >
> > > tring to mount the real root - it cannot find the device.
> >
> > I suspect you want to specify --append="root=/dev/xyz" when calling kexec.
> 
> This helps - see below.
> 
> > > Am I using kexec correctly?  What else can I try?  Is there any debug
> > > info I can gather?
> >
> > Generally you want to put kexec -e your shutdown scripts just before
> > the call to reboot.  And then you can just say: kexec ...
> > and the you get a clean system shutdown.  Dropping to run level 1
> 
> Why not include this info in kexec -h ?  Bet it would prevent a few
> failure reports...

I will look, at that.
 
> Two more possible additions to the kexec command.  
> 
> 1. kexec -q which returns rc=1 and types the pending selection and 
>    its command/append string if one exists and returns rc=0 if nothing 
>    is pending.  

This would require effort to little purpose.  If you just call kexec
it loads the kernel and then calls shutdown -r now.  So the loaded kernel
should be a transient entity anyway.

> 2. kexec -c which clears any pending kernels.

This I can and should do.  The kernel side is already implemented.
 
> > With respect to USB it is quite possible something in the USB drivers
> > does not shutdown correctly on a reboot, and the driver then has trouble
> > reinitializing the device.
> 
> Very possible since I did not do an init 0/1/6 before the kexec -e.  Usb
> was probably being asked to do something very unexpected...

Ideally drivers should be able to cope with this.

> > Which kernel are you booting with kexec anyway?
> 
> 2.5.51 + fbcon(bk) + usb(bk) + kexec

Ah, the easy case kexec loading the same kernel that had the kexec support....


Eric
