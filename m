Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130348AbRAFEC6>; Fri, 5 Jan 2001 23:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbRAFECt>; Fri, 5 Jan 2001 23:02:49 -0500
Received: from gear.torque.net ([204.138.244.1]:1798 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S130348AbRAFECf>;
	Fri, 5 Jan 2001 23:02:35 -0500
Message-ID: <3A56948F.D4744CCF@torque.net>
Date: Fri, 05 Jan 2001 22:44:15 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Raphael Schmid <raphael.schmid@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with devfs (?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael wrote:

> I'm using ROCK Linux, which is built with devfs, originally Kernel
> 2.4.0-test9. This problem occurs, when I want to boot some Kernel after
> 2.4.0-test9, whereas building and installing the Kernel never is a problem.
>
> I enabled devfs support as well as the mounting of devfs at bootup in the
> configuration, just as it is with my "default"Kernel, next, I played around
> with lilo.conf (under normal circumstances a make bzlilo without any
> playing-around should do it, shouldn't it?)
> Then, as this also did show no success I tried passing root=/.....
> devfs=mount (<= don't nail me on this one, but I'm sure I did it the right
> way) at the LILO boot prompt.
> Whole story. Point. That's all. When trying to mount the root he hangs with
> "Kernel Panic: I have no root and I want to scream." Poor Kernel.
> Hope this helps anyone except me in any way (or perhaps I'm just too
> stupid).

I've been using kernels with devfs right through the test
series and now with lk 2.4.0 . The only hiccup was
when I upgraded to glibc 2.2 [RH 7.0 upgrade]. devfsd
seg faulted during bootup and I got a similar message
(because the kernel couldn't find /dev/sda3).

Don't know why but this line in /etc/devfsd.conf caused
devfsd to barf:
LOOKUP      ^cdrom$      CFUNCTION      GLOBAL    
       symlink ${mntpnt}/cdroms/cdrom0 $devpath

This line is almost straight out of Richard's doco.

You could try and identify your disk to lilo explicitly.
For example if it is normally at /dev/hda3 then try
something like this at the lilo prompt:
  linux root=/dev/ide/host0/bus0/target0/lun0/part3

If you can find the root partition that way, it will
probably fail later in the boot. To poke around with 
a statically linked shell trying adding to the above 
lilo prompt:
            init=/sbin/sash

Taking another tack, you could hope your root fs has a
normally populated /dev directory and try "devfs=nomount"
at the lilo prompt.

Doug Gilbert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
