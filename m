Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155920AbPKWXAu>; Tue, 23 Nov 1999 18:00:50 -0500
Received: by vger.rutgers.edu id <S155908AbPKWXAk>; Tue, 23 Nov 1999 18:00:40 -0500
Received: from shaft.engin.umich.edu ([141.213.33.85]:4076 "EHLO shaft.engin.umich.edu") by vger.rutgers.edu with ESMTP id <S155906AbPKWXAb>; Tue, 23 Nov 1999 18:00:31 -0500
Date: Tue, 23 Nov 1999 18:00:30 -0500 (EST)
From: Chris Wing <wingc@engin.umich.edu>
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] 32-bit UID support for 2.3.29pre3 (updated)
Message-ID: <Pine.LNX.4.10.9911231719340.16755-100000@shaft.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hi. I have another update for the Linux 32-bit UID support patches. These
patches are against the latest development kernel version.
(pre-patch-2.3.29-3)

This patch includes more IPC changes, and a "final" proposal for new
msqid_ds, semid_ds, and shmid_ds structures. Now there is padding space
available on all platforms for:
	32-bit pid_t
	64-bit time_t
	32-bit mode_t
	32-bit 'seq' in ipc_perm
	32-bit or 64-bit message sizes for message queues

The ipc_perm structure is now also broken out architecture-by-architecture
into include/asm-[arch]/ipc.h, along with the msqid_ds, semid_ds, and
shmid_ds structures.


The patches are available at:

http://www.engin.umich.edu/caen/systems/Linux/code/misc/2.3/19991123b/


Changes in this version:
	- struct ipc_perm is now broken out on an architecture-by-
	  architecture basis, pad space is now included for a 32-bit
	  mode_t and seq on all architectures.

	- include/asm-m68k/shm.h file was clobbered by previous patch;
	  now fixed

	- sem_perm.seq field now copied properly by semctl() and
	  IPC_OLDSTAT, SEM_OLDSTAT


As always, the patches are tested and working on i386.

In order to use 32-bit UIDs you need the following patches from the above
URL:
	linux-acct.patch
	linux-arch-independ.patch
	linux-ext2.patch
	linux-ipc.patch
	linux-filesystems.patch

as well as a patch for your particular architecture:

	linux-alpha.patch
	linux-arm.patch
	linux-i386.patch
	linux-m68k.patch
	linux-mips.patch
	linux-ppc.patch
	linux-sh.patch
	linux-sparc.patch
	linux-sparc64.patch


Still broken with these patches:
	- sparc64 architecture.


Thanks,

Chris Wing
wingc@engin.umich.edu


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
