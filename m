Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280361AbRKSR3Q>; Mon, 19 Nov 2001 12:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280365AbRKSR3G>; Mon, 19 Nov 2001 12:29:06 -0500
Received: from 59dyn119.com21.casema.net ([213.17.63.119]:38554 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S280361AbRKSR27>; Mon, 19 Nov 2001 12:28:59 -0500
Message-Id: <200111191728.SAA05962@cave.bitwizard.nl>
Subject: Re: DD-ing from device to device.
In-Reply-To: <20011119101340.I1308@lynx.no> from Andreas Dilger at "Nov 19, 2001
 10:13:40 am"
To: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 19 Nov 2001 18:28:55 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Nov 18, 2001  14:26 +0100, Rogier Wolff wrote:
> > I should NOT get a "file too large" error when copying from a device
> > to a device, right?
> > 
> > I should NOT get a "file too large" if the files are openeed using
> > the "O_LARGEFILE" option, right?
> > 
> > read(4, ""..., 1048576) = 1048576
> > write(5, ""..., 1048576) = 1048576
> > read(4, ""..., 1048576) = 1048576
> > write(5, ""..., 1048576) = 1048575
> > write(5, ".", 1)                     = -1 EFBIG (File too large)
> > 
> > 
> > 
> > This is on 2.2.14. I Could swear we made a working copy of a disk 30
> > minutes earlier....
> 
> Hmm, you mean 2.4.14 I take it?  

Typo. Yes. 

> There is another report saying 2.4.14
> also "Creating partitions under 2.4.14", and I have read several more
> recently but am unsure of the exact kernel version.  What fs are you
> using, just in case it matters?

ext2. 

It first worked on one machine, then we moved the harddisk to another
machine and it suddenly stopped working as described above.

We since then moved back to the first machine, and it worked again. 
Then we moved to the second machine, which now works great too. 

In short: Cannot reproduce anymore....

> I know for sure that 2.4.13+ext3 is working mostly OK, as I have been
> playing with multi-TB file sizes (sparse of course) although there is
> a minor bug in the case where you hit the fs size maximum.  I'm glad
> my patch isn't in yet, or I would be getting flak over this I'm sure.

> The only problem is that I can't see anything in the 2.4.14 patch which
> would cause this problem.  All the previous reports had to do with
> ulimit, caused by su'ing to root instead of logging into root, but I'm
> not sure exactly where the problem lies.

Gotcha!!!! 

The "wouldn't work" case was tested by me, logged in as wolff, su-ing
to root, and the "works just fine" cases were tested by a guy who logs
in to the machine on the console (as root).


Now, can someone tell me why "unlimited" is interpreted somehow as 2G
or something thereabouts? :

 /home/wolff> limit
cputime         unlimited
filesize        unlimited
datasize        unlimited
stacksize       unlimited
coredumpsize    unlimited
memoryuse       unlimited
descriptors     1024 
memorylocked    unlimited
maxproc         4095 
openfiles       1024 
 /home/wolff> su
Password: 
 /home/wolff# limit
cputime         unlimited
filesize        unlimited
datasize        unlimited
stacksize       unlimited
coredumpsize    unlimited
memoryuse       unlimited
descriptors     1024 
memorylocked    unlimited
maxproc         4095 
openfiles       1024 
 /home/wolff# cat /proc/version
Linux version 2.4.9 (wolff@machine) (gcc version 2.95.2 19991024 (release)) #3 SMP
 Mon Sep 10 09:17:17 BST 2001
 /home/wolff# 

(The machine was downgraded due to other problems. )

			Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
