Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbSJVIvH>; Tue, 22 Oct 2002 04:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSJVIvH>; Tue, 22 Oct 2002 04:51:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32558 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261886AbSJVIvG>; Tue, 22 Oct 2002 04:51:06 -0400
To: Werner Almesberger <wa@almesberger.net>
Cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<1035241872.24994.21.camel@andyp> <m13cqzumx3.fsf@frodo.biederman.org>
	<20021022053005.F1421@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Oct 2002 02:55:22 -0600
In-Reply-To: <20021022053005.F1421@almesberger.net>
Message-ID: <m1bs5mua2t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Eric W. Biederman wrote:
> > Oh, wait as I recall bootimg simply copies the BIOS results
> > from the current kernel to the freshly booted kernel, so it skips
> > the BIOS calls altogether.
> 
> Yes, I don't trust the BIOS very much under normal conditions,
> so I wouldn't even dream of running it with a largely undefined
> system state. I'm actually quite surprised that kexec has so
> few problems doing that :-)

Me too.  There are two advantages to tracking things down so the BIOS
calls work.  1) BIOS calls are always the best source for what the
capabilities of the machine are.  2) If enough glitches are shaken out
of the system I can put in a boot sector loader, and people can boot
windows.  And that is the really killer feature, because then you can
replace GRUB and lilo.

In my optimized setup I put on LinuxBIOS, which simply provides a
table of values to the kernel.  Which I can requery all day long
without problems.  And I suppose that has me spoiled :)

> In any case, since the kexec kernel code is more or less just a
> generic loader, this is something you can always decide to
> change in user space. 

Definitely that is where the policy is.

> The only thing bootimg did that kexec
> doesn't do is to explicitly mark BIOS-provided data tables
> (mainly SMP stuff) as reserved so that they won't be
> overwritten. But it seems that mpparse.c now reserves that
> already, so kexec should be fine.

Yep.  I checked up on that one, a few bug hunts ago...
Also the BIOS normally reserves that memory as well, and linux
honors the BIOS reservations as well.

What has me currently baffled is that I have an old 2.4.17 kernel,
that is dying in the decompressor.  But if I bypass the 32bit startup
code and substitute in my own, the kernel works.

I don't know yet if this is common or not.

I guess the next step is to work on a reliable means of skipping the
16bit kernel startup code.  I do that all of the time with mkelfImage,
so it should not be too bad.  

But getting good parameter values can be a challenge if the original
boot sector values are not saved.  At the same time all I really need
to preserve reliably is the memory size.  The kernels seems to work
o.k. without dummy values for everything else.

I guess those will be my next two steps, a debugging checksum, and 
the option of entering the kernel in 32bit mode.  I already have a
rough memory map that I check the kernel against to make certain it is
being loaded to a valid memory location anyway...

Eric
