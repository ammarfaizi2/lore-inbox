Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262051AbREPSxJ>; Wed, 16 May 2001 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262066AbREPSw7>; Wed, 16 May 2001 14:52:59 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:3811 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S262051AbREPSwt>; Wed, 16 May 2001 14:52:49 -0400
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <Pine.LNX.4.21.0105161055270.4738-100000@penguin.transmeta.com>
Organisation: SAP LinuxLab
Date: 16 May 2001 20:46:46 +0200
In-Reply-To: <Pine.LNX.4.21.0105161055270.4738-100000@penguin.transmeta.com>
Message-ID: <m3itj15dyh.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, 16 May 2001, Linus Torvalds wrote:
> 
> On 16 May 2001, Christoph Rohland wrote:
>> 
>> cr:/speicher/src/u4ac9 $ ls -l mm/shmem.o*
>> -rw-r--r--    1 cr       users      154652 Mai 16 19:27 mm/shmem.o-tmpfs
>> -rw-r--r--    1 cr       users      180764 Mai 16 19:24 mm/shmem.o+tmpfs
>> cr:/speicher/src/u4ac9 $ ls -l fs/ramfs/ramfs.o
>> -rw-r--r--    1 cr       users      141452 Mai 16 19:27 fs/ramfs/ramfs.o
>> 
>> So CONFIG_TMPFS adds 26k and ramfs 140k.
> 
> What the hell are you doing? Compiling with debugging or something?

Yep, sorry that was uml with debugging info.

> The ramfs inode.o file (the only file that ramfs contains) has 376
> bytes of data and 1612 bytes of code. BYTES. The whole final object
> file with all the relocation information is
> 
> 	-rw-r--r-- 1 torvalds eng 5734 May 16 10:58 ramfs.o
> 
> but out of that 5.5kB, only 2kB are actually linked into the kernel
> and are used to _run_.

-rw-r--r--    1 root     root         8656 May 16 20:27 fs/ramfs/ramfs.o
-rw-r--r--    1 root     root        11688 May 16 20:24 mm/shmem.o-tmpfs
-rw-r--r--    1 root     root        18592 May 16 20:20 mm/shmem.o+tmpfs

That's an -ac kernel, so ramfs does accounting and is a little bigger
than yours.

So the read/write support in tmpfs is about the same size as ramfs.

Greetings
		Christoph


