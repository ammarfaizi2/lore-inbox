Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbSKFAQe>; Tue, 5 Nov 2002 19:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265421AbSKFAQT>; Tue, 5 Nov 2002 19:16:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265400AbSKFAOc>;
	Tue, 5 Nov 2002 19:14:32 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
From: Andy Pfiffer <andyp@osdl.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <20021105161902.I1408@almesberger.net>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
	<3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net>
	<20021105171230.A11443@in.ibm.com> <20021105150048.H1408@almesberger.net>
	<1036521360.5012.116.camel@irongate.swansea.linux.org.uk> 
	<20021105161902.I1408@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Nov 2002 16:21:44 -0800
Message-Id: <1036542104.2749.197.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 11:19, Werner Almesberger wrote:
> Alan Cox wrote:
> > Let me ask the same dumb question - what does kexec need that a dumper
> > doesn't.
> 
> kexec needs:
>  - a system call to set it up
>  - a way to silence devices <snip>
<snip>
>  - a bit of glue <snip>
>  - device drivers that can bring silent devices back to life
<snip>

> > In other words given reboot/trap hooks can kexec happily live
> > as a standalone module ?

You could probably skip the system call to set it up.  Example: I could
imagine a bizarre set of pseudo-devices:

	# insmod kexec
	# cat bzImage > /proc/kexec/next-image
	# echo "root=805" > /proc/kexec/next-cmndline
	# echo 1 > /proc/kexec/reboot

and hide away that dirty little sequence with a nice kexec(3) library
routine.

The Two Kernel Monte trick (that rewrote when insmod'ed the kernel's
function pointers for sys_reboot) was also effective, but that
apparently isn't an option any longer.


> What kexec needs now is more exposure, so that the BIOS
> compatibility issues get noticed and fixed, it is ported to other
> architectures, and that more people can start figuring out how to
> use it, and how to build a boot environment.

I'll 2nd that sentiment, and add another big one: fixing (apparent)
problems with drivers and chipset-munging code, so that devices can be
reliably re-probed/re-inited/etc. after the reboot.

Long term, I think it would be advantageous to be able to avoid SCSI and
other time consuming device probes for the common and simple reboot case
of 1) the currently running kernel is being rebooted, and 2) no changes
to the device configuration have occured.  Shouldn't we be able to "save
away" what is in sysfs, and then re-inject that state after a fast
reboot?

Andy


