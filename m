Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284244AbRLPFbZ>; Sun, 16 Dec 2001 00:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284248AbRLPFbP>; Sun, 16 Dec 2001 00:31:15 -0500
Received: from ns01.netrox.net ([64.118.231.130]:11663 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S284246AbRLPFbB>;
	Sun, 16 Dec 2001 00:31:01 -0500
Subject: Re: use shmfs
From: Robert Love <rml@tech9.net>
To: Hua Zhong <hzhong@cisco.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <00c801c185c8$466ebb60$5900a8c0@cisco.com>
In-Reply-To: <00c801c185c8$466ebb60$5900a8c0@cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.10.08.57 (Preview Release)
Date: 16 Dec 2001 00:31:25 -0500
Message-Id: <1008480693.4514.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-15 at 19:26, Hua Zhong wrote:

> Currently I'm using shmfs as a volatile storage. I am using Monta Vista's
> kernel (2.4.2). I added the following line in /etc/fstab:
> 
> tmpfs                   /dev/shm                shm     defaults        0 0
> <snip>
> I cannot write to the filesystem. write returns EINVAL. I can create an
> empty file, however.

It is confusing: tmpfs is used both for abstracting POSIX shared memory
(shm) and for a page-cache-based dynamic RAM disk.  The line above, that
you are adding, is for the shm support.  You need to add another line to
create the tmpfs filesystem at a given mount point.  Example:

tmpfs		/var/cheese	tmpfs	defaults,size=4m	0 0

Would create a tmpfs at /var/cheese.  The (optional) size parameter
specifies a maximum fs size of 4MB.

See Documentation/filesystems/tmpfs.txt for more information.

	Robert Love

