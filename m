Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266158AbRGLQPO>; Thu, 12 Jul 2001 12:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266166AbRGLQPE>; Thu, 12 Jul 2001 12:15:04 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48274 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266164AbRGLQO6>;
	Thu, 12 Jul 2001 12:14:58 -0400
Message-ID: <3B4DCCF8.16B27789@mandrakesoft.com>
Date: Thu, 12 Jul 2001 12:14:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave J Woolley <david.woolley@bts.co.uk>, andrew.grover@intel.com,
        linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com> <m1zoaa6sy0.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> > On Wed, 4 Jul 2001, Alan Cox wrote:
> > We migth want to just make initrd a built-in thing in the kernel,
> > something that you simply cannot avoid. A lot of these things (ie dhcp for
> > NFS root etc) are right now done in kernel space, simply because we don't
> > want to depend on initrd, and people want to use old loaders.
> 
> That and the linux tools for making small binaries are relatively
> immature.

I am rapidly discovering that :(

I wouldn't mind, for example, having a linker that is smart enough to
eliminate dead code inside code sections, and can rewrite function
prologues to more optimized forms once it knows the entire scope of said
functions.  (ie. an optimizing linker)


> > I don't like the current initrd very much myself, I have to admit. I'm not
> > going to accept a "you have to have a ramdisk" approach - I think the
> > ramdisks are really broken.
> >
> > But I've seen a "populate ramfs from a tar-file built into 'bzImage'"
> > patch somewhere, and that would be a whole lot more palatable to me.
> 
> To some extent I'd prefer to build the tar-file into vmlinux as that
> makes it a multi architecture solution.  I don't like the fact that
> rdev only works on x86.

IMHO rdev -should- work on other platforms.  There -should- be a way to
set flags inside an already-built kernel image.  That concept is not
inherently x86.

That is why I favor

	cat bzImage ramfs.tar.gz > vmlinuz
	rdev vmlinuz i-have-a-ramfs

It's -much- more flexible than actually building the initramfs into the
kernel.

Admittedly I'm biased but IMHO the only reason why people want to lose
flexibility by avoiding this approach is to avoid coming up with an rdev
concept that works on alpha, sparc, ...  :)


> - The version of ``preinit'' cannot use glibc, there is too much
>   bloat.  uclibc is o.k. but a little immature.  We can probably use
>   the infrastructure we have in linux/unistd.h for doing system calls
>   from the kernel to remove any dependieces on other packages.  But
>   using kernel headers from user space has been outlawed...

There should be no need to use linux/unistd.h infrastructure.  dietlibc
is just as small (smaller than uClibc in the cases I've tried), and has
already done this.  They even have dynamic linking going for x86, arm,
sparc, and maybe others.  http://www.fefe.de/dietlibc/


> - We must be architecture netural.  Do this only for x86 is
>   unacceptable.

obviously


> - The _init stuff that allows us to throw code after device
>   initialization would need to be disabled to some extent because it
>   would now depends on code in user space.

I don't see this at all, can you elaborate?


> Irq tables.  A corrected system memory map.  Builtin ISA devices.
> Long term we need is an interface to feed a pre intialized
> ``struct device'' (the renamed struct pci_device) tree into the kernel.

ie. come up with our own firmware->kernel information passing interface
:)

Let's make it better than ACPI this time, shall we?  :)

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
