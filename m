Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131271AbQKNTFz>; Tue, 14 Nov 2000 14:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131262AbQKNTFp>; Tue, 14 Nov 2000 14:05:45 -0500
Received: from ns.caldera.de ([212.34.180.1]:37391 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130689AbQKNTFb>;
	Tue, 14 Nov 2000 14:05:31 -0500
Date: Tue, 14 Nov 2000 19:35:24 +0100
Message-Id: <200011141835.TAA02664@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
Cc: Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3A117311.8DC02909@holly-springs.nc.us>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A117311.8DC02909@holly-springs.nc.us> you wrote:
> 2) Continuous operation analogous to power & telephone services. 

> No way. Multics could have a whole bank of memory fail and keep running.
> You could add CPUs, memory and IO devices while it was running without
> interrupting users' work. Of course, a lot of this cannot be
> accomplished due to the brain-dead hardware designs (especially PC)
> prevalent today. However, Linux does not have any support for this type
> of facility. I recently saw a patch to let Linux use partially bad
> memory. This is a step in the right direction. The ability to scale the
> system while on-line is extremely valuable.

Motorola has announced Linux Systems with a Hot-Plug CPU - but this seems
to be more a hardware then a software feature.

> 4) A high reliability internal file system. 

> Ext2 + bdflush + kupdated? Not likely.  To quote the Be Filesystems
> book, Ext2 throws safety to the wind to achieve speed.

No.  Shure, you don't have all the nice features of log structured or
journaled filesystem, but ext2 is pretty reliable for a traditional fs.
(I'd like to see if the multics fs was better, do you have a pointer?)

> This also ties
> into Linux' convoluted VM system, and is shot in the foot by NFS. We
> would need minimally a journaled filesystem and a clean VM design,
> probably with a unified cache (no separate buffer, directory entry and
> page caches).

The dcache is not a disk cache.  It caches directory lookups, it is
neither something VM related nor does it inpact reliability.
The buffercache seems pretty dead in the near future - filesystems
are going towards putting metadata in the page cache.
(See Al Viro's ext2 patches)

> The Tux2 Phase Trees look to be a good step in the
> direction as well, in terms of FS reliability.

> The filesystem would have to do checksums on every block.

The filesystem?  This does not belong into the filesystem. An ecc 
personality for md might be a much better idea ...

> Some type of mirroring/clustering would be good.

Mirroring does _not_ belong into the fs layer, it belongs into LVM, software -,
or if you want a really reliable system, hardware raid.

> And the ability to grow filesystems online, and replace disks
> online, would be key. If your disks are getting old, you may want to
> pre-emptively replace them with faster, newer, larger ones with more
> MTBF left.

Why don't you use LVM?

> 5) Support for selective information sharing. 

> Linux has a rather poor security model -- the Unix one. It needs ACLs no
> only on filesystem objects, but on other OS features as well; such as
> the ability to use network interfaces, packet types, display ACLs,
> console ACLs, etc. If there's a function, it probably needs an ACL.

ACLs are not really interesting.  They are like good-old file rights with
some nice new features and much more complicated.  You want MACs and
Capabilities (the latter are implemented in Linux).

> 6) Hierarchical structures of information for system administration and
> decentralization of user activities. 

> See #5. Linux really does not support delgation of authority well.
> There's one user who can reconfigure/admin the system: root.

No, there is not.  There is a capability for each job (or a group of jobs).
The root user is just UNIX-Legacy. (ok, ok nearly every system has one -
but the Linux security model doesn't really need it).

> 7) Support for a wide range of applications. 

> Well... anything wih source or compiled for the Linux ABI. A
> microkernel-type architecture with servers would provide a lot more of
> this. See QNX, NT, Mach.

Shure. NT supports win32, win16, dos and recompiled UNIX binaries.
QNX supports QNX and now Linux binaries.
Thanks to the personality architecture I can (and do) run UnixWare,
OpenServer, etc binaries under Linux.  And I can use dosemu, wine, etc ...

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
