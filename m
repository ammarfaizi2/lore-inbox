Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131150AbQKSK63>; Sun, 19 Nov 2000 05:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbQKSK6J>; Sun, 19 Nov 2000 05:58:09 -0500
Received: from slc154.modem.xmission.com ([166.70.9.154]:28170 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129705AbQKSK6H>; Sun, 19 Nov 2000 05:58:07 -0500
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap=<device> kernel commandline
In-Reply-To: <20001118141524.A15214@nic.fr> <Pine.LNX.4.21.0011181804360.9267-100000@duckman.distro.conectiva> <20001118223455.G23033@almesberger.net> <m11yw86byt.fsf@frodo.biederman.org> <20001119030345.F23030@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2000 00:30:55 -0700
In-Reply-To: Werner Almesberger's message of "Sun, 19 Nov 2000 03:03:45 +0100"
Message-ID: <m1snoo4dw0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <Werner.Almesberger@epfl.ch> writes:

> Eric W. Biederman wrote:
> > I have one that loads a second kernel over the network using dhcp 
> > to configure it's interface and tftp to fetch the image and boots
> > that is only 20kb uncompressed....
> 
> Neat ;-) My goal is actually not only size, but also to have a relatively
> normal build environment, e.g. my example is with shared newlib, regular
> ash, and - unfortunately rather wasteful - glibc's ld.so.
> 
> But a tftp loader in 20kB is rather good. Now the next challenge is the
> same thing with NFS. Then we can finally kill nfsroot ;-)

Hmm. What does it take to mount an NFS partition?

Anyway.  All I did was wrote a tiny libc that is just a bunch of
wrappers for syscalls, and some string functions.  Then I just wrote
a straight forward C program to do the job.  Except for my added
kexec call I can compile with glibc :)

Now if glibc wouldn't link in 200k of unused crap when you make a
trivial static binary I'd much prefer to use it...

Though I wish it was possible to have a ramfs preloader instead of
initrd.  An initramfs would allow me to not even compile in the block
device driver layer, and be more efficient.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
