Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbTCHB4z>; Fri, 7 Mar 2003 20:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbTCHB4y>; Fri, 7 Mar 2003 20:56:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4149 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261988AbTCHB4x>; Fri, 7 Mar 2003 20:56:53 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
	<20030307233916.Q17492@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Mar 2003 19:06:42 -0700
In-Reply-To: <20030307233916.Q17492@flint.arm.linux.org.uk>
Message-ID: <m1d6l2lih9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Fri, Mar 07, 2003 at 03:05:32PM -0800, Linus Torvalds wrote:
> > However, I also have to say that klibc is pretty late in the game, and as 
> > long as it doesn't add any direct value to the kernel build the whole 
> > thing ends up being pretty moot right now. It might be different if we 
> > actually had code that needed it (ie ACPI in user space or whatever).
> 
> Alan was recently trying to convince people that ipconfig.c should be
> deleted from the 2.5 kernel today.  That was until I pointed out that
> people do download kernels via xmodem to embedded boards (because that's
> what the boot loader supports) and they want to be able to use root-NFS.
> I think Alan is reasonably happy for it to stay now, although I haven't
> had any hard positive confirmation of that fact.

There is another reason ipconfig.c should die.   Except in simple setups
it does the wrong thing.  I have had it get a DHCP reply off of the wrong 
NIC.  Having the wrong policy in the kernel is a problem.  Especially
when people think about fixing it...

> As long as we don't have equivalent functionality present which replaces
> ipconfig.c and nfsroot.c without adding stupidly sized initrd images to
> the kernel, I will continue to resist the removal of both of these
> features.

I agree ipconfig.c works well for development.  Last time I played with
something like this it should not be hard to get the entire initrd
binary down to 30K-40K.   I think you can probably do it in 16K but...

As far as equivalent functionality there is already a dhcp client and
a mount client in busybox.  So in the worst case someone it will
take just a bit of glue to put these things together.

> klibc provided a way, but if that isn't going to be merged and this stuff
> made to work for 2.6, then I think we must keep ipconfig.c and
> nfsroot.c.

Either klibc or alternative user space implementation.  There is no
reason that magic has to happen in the kernel.  The only thing has
to be implemented is a way to smush a kernel and an initrd together.

Eric
