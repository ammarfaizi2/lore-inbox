Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312047AbSCQPER>; Sun, 17 Mar 2002 10:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312044AbSCQPEI>; Sun, 17 Mar 2002 10:04:08 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:56062 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S311218AbSCQPD4>;
	Sun, 17 Mar 2002 10:03:56 -0500
Message-Id: <5.1.0.14.2.20020317145521.00afa1e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 17 Mar 2002 15:00:18 +0000
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: fadvise syscall?
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203171505280.27987-100000@phobos>
In-Reply-To: <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:31 17/03/02, Simon Richter wrote:
>On Sun, 17 Mar 2002, Anton Altaparmakov wrote:
>
> > All of what you are asking for exists in Windows and all the semantics are
> > implemented through a very powerful open(2) equivalent. I don't see why we
> > shouldn't do the same. It makes more sense to me than inventing yet another
> > system call...
>
>It is easier for application writers to code:
>
>[...]
>#ifdef HAVE_FADVISE
>         (void)fadvise(fd, FADV_STREAMING);
>#endif
>[...]
>
>Than to have a forest of #ifdefs to determine which O_* flags are
>supported. After all, we still want our programs to run under Solaris. :-)

Ugh. Both of your suggestions look ugly. Using the O_* flags, you just need 
to have a compatibility header file which contains:

#ifndef HAVE_O_SEQUENTIAL
#       define O_SEQUENTIAL     0
#endif

Then in the code you just use O_SEQUENTIAL and if the system doesn't know 
about it it is optimised away at compile time.

Note how nicely this fits in with autoconf/automake where the ./configure 
script can test for O_SEQUENTIAL and if it is not there automatically 
define it to 0. That then means your code is completely free from these 
ugly #ifdefs.

Thanks for making your point as that is ANOTHER argument for using open(2) 
instead of fadvise() [1]. (-;

Cheers,

Anton

[1] Yeah, I know, one could also define fadvise() to nothing in the compat 
header file...


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

