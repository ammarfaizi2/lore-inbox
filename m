Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSCSTAf>; Tue, 19 Mar 2002 14:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291169AbSCSTAZ>; Tue, 19 Mar 2002 14:00:25 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43758
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291102AbSCSTAT>; Tue, 19 Mar 2002 14:00:19 -0500
Date: Tue, 19 Mar 2002 11:01:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac2
Message-ID: <20020319190137.GU2254@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0203191938530.3932-100000@mimas.fachschaften.tu-muenchen.de> <E16nOpi-0008SY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 06:59:42PM +0000, Alan Cox wrote:
> > gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -DKBUILD_BASENAME=shm  -c -o shm.o shm.c
> > shm.c: In function `sys_shmdt':
> > shm.c:682: too few arguments to function `do_munmap'
> 
> Whoops - stick a ,1 on it

Then this patch should do it then...

--- ipc/shm.c.orig	Tue Mar 19 10:58:06 2002
+++ ipc/shm.c	Tue Mar 19 10:59:57 2002
@@ -679,7 +679,7 @@
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
 		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
-			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
+			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start, 1);
 			retval = 0;
 		}
 	}
