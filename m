Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132411AbQKSNz6>; Sun, 19 Nov 2000 08:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbQKSNzt>; Sun, 19 Nov 2000 08:55:49 -0500
Received: from einhorn.colt.in-berlin.de ([213.61.118.8]:37895 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id <S131139AbQKSNzf>; Sun, 19 Nov 2000 08:55:35 -0500
To: linux-kernel@vger.kernel.org
Path: kraxel
From: kraxel@bytesex.org (Gerd Knorr)
Newsgroups: lists.linux.kernel
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
Date: 19 Nov 2000 12:56:17 GMT
Organization: Strusel 007
Message-ID: <slrn91fjfh.dta.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <20001117013157.A21329@almesberger.net> <slrn91b42n.fs.kraxel@bogomips.masq.in-berlin.de> <20001118141426.B23033@almesberger.net> <slrn91f3hr.jt.kraxel@bogomips.masq.in-berlin.de> <3A17AF88.F1319C2C@linux.com>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
X-Trace: goldbach.masq.in-berlin.de 974638577 11812 192.168.69.77 (19 Nov 2000 12:56:17 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 19 Nov 2000 12:56:17 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why?  What is the point in compiling bttv statically into the kernel?
> > Unlike filesystems/ide/scsi/... you don't need it to get the box up.
> > No problem to compile the driver as module and configure it with
> > /etc/modules.conf ...
> 
> Huh?
> 
> Some systems are built without module support for numerous reasons.  I don't
> need 50% of the entire kernel to get the box up, but I surely use it and I
> don't want 100 modules loaded.

Why not?  /me has nearly everything compiled as modules.

> There is an introduced security weakness by using kernels.

???  Guess you mean "by using modules"?  Which weakness?  Other than
bugs?  I don't see bugs like the recent modprobe oops as major problem.
They happen (everythere), they get fixed.

> So..what is the point in making it modular?

It's much more flexible.

You can reconfigure/update the driver without recompiling the kernel
and without rebooting.  If the driver needs some tweaks to make it
work with your hardware you can update /etc/modules.conf and reload
the modules with the new options.  If you have found a working
configuration, you can simply leave it as is.


Distributions ship with modularized kernels.  Most external drivers
can't be compiled into the kernel (alsa, lirc, vmware, ...).  Sometimes
I find it very useful to be able to switch drivers on the fly:

 * rmmod ide-cd; modprobe ide-scsi; modprobe sr_mod (for burning CD's)
 * /etc/rc.d/init.d/network stop; rmmod de4x5; modprobe tulip;
   /etc/rc.d/init.d/network start (tulip manages it to drive the card
   full-duplex, de4x5 doesn't).


And I don't like fact that I have to add one more function for every
cmd line option (looks like this from Werner's patch, hav'nt checked).

Some generic way to make module args available as kernel args too
would be nice.  Or at least some simple one-liner I could put next to
the MODULE_PARM() macro...

> --------------E48A413646B728A179A7D2FC
> Content-Type: text/x-vcard; charset=us-ascii;
>  name="david.vcf"

Please turn this off.

  Gerd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
