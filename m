Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbQKLXD1>; Sun, 12 Nov 2000 18:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131016AbQKLXDQ>; Sun, 12 Nov 2000 18:03:16 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:6150 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131142AbQKLXC7>; Sun, 12 Nov 2000 18:02:59 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Mon, 13 Nov 2000 10:02:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14863.8573.827836.127665@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
        Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0.11.3: sysctl.h fixes
In-Reply-To: message from Jeff Garzik on Sunday November 12
In-Reply-To: <200011121430.JAA22978@havoc.gtf.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 12, jgarzik@mandrakesoft.com wrote:
> Rasmus Andersen wrote:
> > I tried to include <linux/types.h> in md.c and had to include 
> > <linux/blkdev.h> also. Otherwise I got the following:
> 
> Here is the solution I prefer...  md builds fine with this, core kernel builds fine with this, and
> I'm about 3/4 of the way through a "build everything" build with this.
> 
> I tried to avoid including fs.h, but I do prefer updating sysctl.h, because it fixes potential
> breakage similar to md's as well.
> 
> 	Jeff
> 

The declaration of:

  struct file;

in sysctl.h is a bit counter intuitive isn't it?

I avoided the problem with:

--- md.c	2000/11/12 23:00:49	1.1
+++ md.c	2000/11/12 23:00:53
@@ -30,8 +30,8 @@
 
 #include <linux/module.h>
 #include <linux/config.h>
-#include <linux/sysctl.h>
 #include <linux/raid/md.h>
+#include <linux/sysctl.h>
 #include <linux/raid/xor.h>
 #include <linux/devfs_fs_kernel.h>
 

It is certainly arguable that a better fix is to add some extra
includes to sysctl.h, but the "struct file;" bothers me.

NeilBrown


> 
> 
> 
> Index: include/linux/sysctl.h
> ===================================================================
> RCS file: /cvsroot/gkernel/linux_2_4/include/linux/sysctl.h,v
> retrieving revision 1.1.1.8
> diff -u -r1.1.1.8 sysctl.h
> --- include/linux/sysctl.h	2000/10/31 21:19:40	1.1.1.8
> +++ include/linux/sysctl.h	2000/11/12 14:28:04
> @@ -24,7 +24,11 @@
>  #ifndef _LINUX_SYSCTL_H
>  #define _LINUX_SYSCTL_H
>  
> +#include <linux/kernel.h>
> +#include <linux/types.h>
>  #include <linux/list.h>
> +
> +struct file;
>  
>  #define CTL_MAXNAME 10
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
