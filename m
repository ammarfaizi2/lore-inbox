Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSLNTbS>; Sat, 14 Dec 2002 14:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbSLNTbS>; Sat, 14 Dec 2002 14:31:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26235 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265843AbSLNTbR>; Sat, 14 Dec 2002 14:31:17 -0500
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec for 2.5.51....
References: <200212141215.49449.tomlins@cam.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Dec 2002 12:37:27 -0700
In-Reply-To: <200212141215.49449.tomlins@cam.org>
Message-ID: <m14r9gv1c8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> writes:

> Eric W. Biederman wrote:
> 
> > Linus,
> > 
> > My apologies for not resending this earlier I've been terribly
> > busy with other things..
> > 
> > No changes are included since the last time I sent this except
> > the diff now patches cleanly onto 2.5.51.  If there is some problem
> > holler and I will see about fixing it.
> > 
> > When I bypass the BIOS in booting clients my only current failure
> > report is on an IBM NUMAQ and that almost worked.
> 
> I applied this to a 2.5.51 kernel with usb and fbcon updated via bk pulls.
> Then after rebooting into the new kernel I tried
> 
> kexec -l /vmlinux.25 --append="console=tty0 console=ttyS0,38400
> video=matrox:mem:32 idebus=33 profile=1"
> 
> kexec -ed
> 
> This rebooted but hangs at:
> 
> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
> 

Hurray! a bug report :)

> One other datum.  Without the --append line a kernel booted with kexec hangs
> when
> 
> tring to mount the real root - it cannot find the device.

I suspect you want to specify --append="root=/dev/xyz" when calling kexec.


> Am I using kexec correctly?  What else can I try?  Is there any debug
> info I can gather?

Generally you want to put kexec -e your shutdown scripts just before
the call to reboot.  And then you can just say: kexec ...
and the you get a clean system shutdown.  Dropping to run level 1
before calling kexec tends to get most of the user space shutdown
called as well.  It is definitely a good idea to be certain X is
shutdown before calling kexec. 

With respect to USB it is quite possible something in the USB drivers
does not shutdown correctly on a reboot, and the driver then has trouble
reinitializing the device.

Since you got to the point of mounting root earlier when you did not
specify anything I wonder if you some of your command line arguments
made the situation worse.  

Which kernel are you booting with kexec anyway?

This is actually an expected failure mode, but one I have not seen
much of yet.  The new kernel not coming up because the old drivers
left the hardware in a state the new drivers cannot handle.

Eric

