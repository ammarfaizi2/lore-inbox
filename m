Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbREPSAr>; Wed, 16 May 2001 14:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbREPSAh>; Wed, 16 May 2001 14:00:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:6663 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262058AbREPSAY>; Wed, 16 May 2001 14:00:24 -0400
Date: Wed, 16 May 2001 11:00:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <m3ofst5gs5.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0105161055270.4738-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 May 2001, Christoph Rohland wrote:
> 
> cr:/speicher/src/u4ac9 $ ls -l mm/shmem.o*
> -rw-r--r--    1 cr       users      154652 Mai 16 19:27 mm/shmem.o-tmpfs
> -rw-r--r--    1 cr       users      180764 Mai 16 19:24 mm/shmem.o+tmpfs
> cr:/speicher/src/u4ac9 $ ls -l fs/ramfs/ramfs.o
> -rw-r--r--    1 cr       users      141452 Mai 16 19:27 fs/ramfs/ramfs.o
> 
> So CONFIG_TMPFS adds 26k and ramfs 140k.

What the hell are you doing? Compiling with debugging or something?

The ramfs inode.o file (the only file that ramfs contains) has 376 bytes
of data and 1612 bytes of code. BYTES. The whole final object file with
all the relocation information is

	-rw-r--r--    1 torvalds eng          5734 May 16 10:58 ramfs.o

but out of that 5.5kB, only 2kB are actually linked into the kernel and
are used to _run_.

How do you get it to 140kB? You're doing something _seriously_
wrong. You're off by a factor of 70.

		Linus

