Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSJVEYe>; Tue, 22 Oct 2002 00:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262129AbSJVEYe>; Tue, 22 Oct 2002 00:24:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8238 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262128AbSJVEYc>; Tue, 22 Oct 2002 00:24:32 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: mochel@osdl.org, eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210212056.NAA01321@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Oct 2002 22:28:37 -0600
In-Reply-To: <200210212056.NAA01321@adam.yggdrasil.com>
Message-ID: <m1wuobt7uy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> Eric Biederman writes:
> >My big concern is with getting the shutdown path setup in a manner
> >that works, and gets testing.
> 
> 	Rebooting without traversing the device tree seems to have
> essentially worked fine for 2.4.x.

Yes.  I expect that most of the shutdown routines will be made conditional
on something like, like CONFIG_HOTPLUG so you can disable the cleanly.
Or perhaps, device_shutdown will be made a compile time conditional.

But please note a number of 2.4.x drivers are starting to grow reboot
notifiers.  So it appears that some people have needed code to shut
down their driver at reboot time in 2.4.x
 
> >When booting linux from linux with
> >sys_kexec a lot of my problems come back to some device driver not
> >getting shutdown.
> 
> 	kmonte and sys_kexec skip the BIOS reset code and therefore
> may need to do more elaborate shutdown, but please do not saddle the
> normal reboot case with the reliability risk of calling code in each
> driver when a user might be rebooting a remote machine precisely
> because of a a confused device driver or the potential slow down
> (especially since you want an interface where the function that gets
> called before reboot may need to do blocking IO).  For
> kmonte/sys_kexec, this high cost might be necessary, but for the
> normal reboot the cost is not worth the benefit.

In general if a routine takes a long time, that is a bug.

> 	By way, given the ability to register reboot notifiers in the
> device tree, I would be happy to see one registered at the top of the
> PCI bus tree (so it would be called last) that would shut off the PCI
> bus before reboot, along the lines of what Richard B. Johnson posted.
> That would not involve walking a lot of data structures in many
> different device drivers and it would be just a few instrutions.

That code was chipset specific, so it may be a good thing for a host bridge
driver to do that but it is by no means generally possible.

Eric
