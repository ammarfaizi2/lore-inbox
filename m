Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSAaCqX>; Wed, 30 Jan 2002 21:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290845AbSAaCqK>; Wed, 30 Jan 2002 21:46:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46900 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S290843AbSAaCpy>; Wed, 30 Jan 2002 21:45:54 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2002 19:42:14 -0700
In-Reply-To: <3C586355.A396525B@zip.com.au>
Message-ID: <m1zo2vb5rt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> On uniprocessor, you can type `sudo monte /boot/bzImage'
> and get to `decompressing linux' in two seconds flat. (Having
> journalling filesystems rather helps with this trick). It's
> lovely.

Hmm.  That sounds a little slow to me.  That is about what I get
with LinuxBIOS from when I flip the power switch, and network boot..
But that is enough enjoyment of speed.

> > The biggest issue I have had is
> > with the kernel not properly shutting down devices.
> 
> Monte just disables all busmastering on the PCI devices...

That might be a useful addition, as it will probably work for most
devices.  However it doesn't handle non-PCI devices.  And it doesn't
handle strange devices that need a different shutdown.  

With module_exit() I am quiet certain the linux driver can find the
device and set it up again, because otherwise you couldn't insert,
remove, and reinsert the code as a module.

> module_exit() routines for statically-linked drivers often
> don't exist - they're in .text.exit.  I guess you can just
> move .text.exit out of the /DISCARD/ section in vmlinux.lds.
> Also, take a look at user-mode-linux's do_exitcalls()
> implementation - there's no clear reason why that shouldn't
> be mainstreamed.

I like the other suggestion of extending the Hot-plug infrastructure.
In that case I just need to figure out how to logically Hot-unplug all
the devices in the system.  That may be better than a
do_exitcalls()...  As it automatically gets the discrimination right. 

> It would be convenient to be able to directly boot a bzImage,
> but I guess elf is workable.

Well that is directly booting vmlinux, and it doesn't lock you into
booting the linux kernel which is very important to me. 

> Great work, and thanks!  I look forward to 2-second SMP
> reboots.

I'll love to hear how it goes.

Eric
