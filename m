Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131115AbQKNQpo>; Tue, 14 Nov 2000 11:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130408AbQKNQpe>; Tue, 14 Nov 2000 11:45:34 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:18438 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129602AbQKNQpW>; Tue, 14 Nov 2000 11:45:22 -0500
Message-ID: <3A117311.8DC02909@holly-springs.nc.us>
Date: Tue, 14 Nov 2000 12:14:57 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One historically significant "Enterprise" OS is Multics. It had nine
major goals. Perhaps we should think about how Linux measures up to
these 1965 goals for "Enterprise Computing."

1) Convenient remote terminal use. 

Telnet, ssh, X windows, rsh, vnc, "screen," ethernet, serial, etc. I
think we have this one.


2) Continuous operation analogous to power & telephone services. 

No way. Multics could have a whole bank of memory fail and keep running.
You could add CPUs, memory and IO devices while it was running without
interrupting users' work. Of course, a lot of this cannot be
accomplished due to the brain-dead hardware designs (especially PC)
prevalent today. However, Linux does not have any support for this type
of facility. I recently saw a patch to let Linux use partially bad
memory. This is a step in the right direction. The ability to scale the
system while on-line is extremely valuable.
    
3) A wide range of system configurations, changeable without system or
user program reorganization. 

See comments in #2. Plus, the recent two-kernel-monte, linux-from-linux
type stuff would be especially excellent if it will allow the kernel to
be upgraded on the fly. If it could save state and have the new kernel
take over, that would rock. On a smaller scale, allowing this for
modules would be good. This would allow the upgrade of nic drivers, etc.
The GKHI would also be invaluable if it would allow the
replacement/augmentation of certain other subsystems on the fly -- such
as the scheduler, VFS, etc.
                               
4) A high reliability internal file system. 

Ext2 + bdflush + kupdated? Not likely.  To quote the Be Filesystems
book, Ext2 throws safety to the wind to achieve speed. This also ties
into Linux' convoluted VM system, and is shot in the foot by NFS. We
would need minimally a journaled filesystem and a clean VM design,
probably with a unified cache (no separate buffer, directory entry and
page caches). The Tux2 Phase Trees look to be a good step in the
direction as well, in terms of FS reliability. The filesystem would have
to do checksums on every block. Some type of mirroring/clustering would
be good. And the ability to grow filesystems online, and replace disks
online, would be key. If your disks are getting old, you may want to
pre-emptively replace them with faster, newer, larger ones with more
MTBF left.

5) Support for selective information sharing. 

Linux has a rather poor security model -- the Unix one. It needs ACLs no
only on filesystem objects, but on other OS features as well; such as
the ability to use network interfaces, packet types, display ACLs,
console ACLs, etc. If there's a function, it probably needs an ACL.

6) Hierarchical structures of information for system administration and
decentralization of user activities. 

See #5. Linux really does not support delgation of authority well.
There's one user who can reconfigure/admin the system: root. Tools like
sudo only make you root for a moment, and don't inherently limit you to
that one activity. ACLs on most if not all system attributes and objects
would go a long way towards decentralized but safe administration.

7) Support for a wide range of applications. 

Well... anything wih source or compiled for the Linux ABI. A
microkernel-type architecture with servers would provide a lot more of
this. See QNX, NT, Mach.

8) Support for multiple programming environments & human interfaces. 

Many languages are supported by Linux. This is good. Linux has two
humnan interfaces: CLI and X Windows guis. I'm not sure what could be
added, except for voice input.

9) The ability to evolve the system with changes in technology and in
user aspirations.

Ties ties into #2 and #3and #5. Otherwise, rewrites of the Linux kernel
and userspace accomplish this. Unfortunately, that requires taking the
system, or minimally its applications, down.

Just some thoughts from 35 years ago. Please add your $0.02.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
