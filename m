Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRJZT5Q>; Fri, 26 Oct 2001 15:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279131AbRJZT5G>; Fri, 26 Oct 2001 15:57:06 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:31397 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S279105AbRJZT4x>; Fri, 26 Oct 2001 15:56:53 -0400
Date: Fri, 26 Oct 2001 21:59:39 +0200
From: Thierry Laronde <tlaronde@polynum.com>
To: linux-kernel@vger.kernel.org
Subject: Virtual(?) kernel root
Message-ID: <20011026215939.A13222@polynum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on possible replies. Thanks.]

As I was working with/on GRUB, and playing with initrd, pivot_root and
so on, numerous drawbacks seemed to lead to one possible theorical
solution, that could be applied to others "kernels" too ;)

If this has been already discussed, sorry and please give me some
pointers to the previous threads.

Short story.

GRUB, as a bootloader, can access data in block list, or can use file
system to access given files. Before selecting a "root" device, the GRUB
can be used via a shell interface.

Since more and more informations are retrieved from the machine, and can
be of some use for the OS loaded, a logical solution to publish these
dynamically acquired data is a virtual fs (a kind of /proc).

Since we try to detect the possible devices from which one can try to
load a kernel or a rootfs from, a kind of /dev to publish the present
devices is a logical solution too.

But, since the "core" GRUB "kernel" is meant to allow the bootstrapping
of major OSes, one can see the builtin functions to carry this out as
the major services, that could be accessed via a script language and so,
publishing them under a, say, `/kbin' (pseudo fs allowing the use of
kernel internals via scripting) could be a solution, while the "user
space" functions could be put out of GRUB kernel, supplementary
resources being mounted at need/will.

The key point is in fact that there is the idea of a virtual kernel
root, with some pseudo fs already set:

/
|
--/dev
|
--/kbin
|
--/proc

The "kernel" can be used via an interface that could be, for example, a
simple interface for debugging purpose, or a simple interface to change
the boot parameters.

Supplementary resources can be mounted on the kernel root (what is
called "root fs") with the difference that the kernel root virtual fs
stays always _on top_ : non kernel root fs don't mask the only root (the
kernel one), they just add resources to the root directory.

The advantages? 

There is no more root problem for kernel threads, since
kernel threads run with the reference of the inchanged kernel root, the
common "root fs" being simply mounted or unmounted. No more "sliding
carpet" problem.

One can test or question the kernel via a simple interface for debugging
purposes. Not mounting supplementary resources doesn't create a panic,
but leave a bare bones kernel, giving for example the choice to the user
to give boot parameters.

The /dev (this is already the case with devfs) doesn't prevent from
mounting the "root" ro (for example when syslog tries to access a device
file created at run time).

Has an equivalent scheme being already discussed?

Cheers,
-- 
Thierry Laronde (Alceste) <tlaronde@polynum.org>
Key fingerprint = 0FF7 E906 FBAF FE95 FD89  250D 52B1 AE95 6006 F40C
