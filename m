Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRC0EAw>; Mon, 26 Mar 2001 23:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRC0EAn>; Mon, 26 Mar 2001 23:00:43 -0500
Received: from dial-09-109-apx-01.btvt.together.net ([209.91.2.109]:5767 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S130457AbRC0EAd>; Mon, 26 Mar 2001 23:00:33 -0500
Date: Mon, 26 Mar 2001 22:59:20 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: Jason Madden <jmadden@spock.shacknet.nu>,
        "David E. Weekly" <dweekly@legato.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
        William Stearns <wstearns@ists.dartmouth.edu>,
        Jens Axboe <axboe@suse.de>
Subject: Re: "mount -o loop" lockup issue
In-Reply-To: <Pine.LNX.4.21.0103262125400.8769-100000@spock.shacknet.nu>
Message-ID: <Pine.LNX.4.30.0103262254500.13254-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,

On Mon, 26 Mar 2001, Jason Madden wrote:

> On Mon, 26 Mar 2001, David E. Weekly wrote:
>
> > On Linux 2.4.2, running a "mount -o loop" on a file properly created with
> > "dd if=/dev/zero of=/path/to/my/file.img count=1024" seems to decide to
> > freeze up my shell (not my system). An strace showed the lockup happening at
> > the actual system "mount()" call, which never returns.
> >
> > Since mount() is in glibc, it might be relevant to note that I'm running
> > Mandrake's glibc 2.1.3-16mdk. I compiled the kernel with a gcc of 2.95.3
> > [1991030] (although oddly enough this binary seems to have come with the
> > gcc-2.95.2 RPM and installed itself as /usr/bin/gcc-2.95.2) and binutils
> > 2.10.0.24-4mdk.
> I also experience this problem (using a floppy disk image created by
> dd if=/dev/fd0 of=floppy.img bs=1024, and then mount -o loop
> floppy.img /mnt/floppy ) with a different version
> of glibc (RedHat's 2.1.92-5 rpm) and binutils (binutils-2.10.0.18-1). Loop
> is compiled into the kernel.
>
> Once the mount command was executed, my load average shot up to a steady
> 1.0 on an idle system, and remained there until I rebooted. top
> et. al. showed no cpu utilization by the frozen mount.

	Jens Axboe, along with a number of other people, has put in a lot
of time coming up with a fix for the loop mount lockups.  You can either
get his patch directly from
ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/
	or simply use the most recent 2.4.2-ac patch (from
ftp://ftp.kernel.org/pub/linux/kernel/people/alan/
	) to get this updated loop device code.  I'm certain Jens would
like to hear from you if you find any problems with the updated code.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	The day Microsoft makes something that doesn't suck is
probably the day they start making vacuum cleaners.
	--  Ernst Jan Plugge
(Courtesy of Christian Vogel <chris-inet@obelix.bene.baynet.de>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

