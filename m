Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRHCW3w>; Fri, 3 Aug 2001 18:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269643AbRHCW3n>; Fri, 3 Aug 2001 18:29:43 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:52145 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S269641AbRHCW3Z>; Fri, 3 Aug 2001 18:29:25 -0400
Message-Id: <5.1.0.14.2.20010803232810.0415b840@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 03 Aug 2001 23:29:29 +0100
To: Chris Wedgwood <cw@f00f.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync
  semantic change patch)
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
In-Reply-To: <20010804100143.A17774@weta.f00f.org>
In-Reply-To: <9keqr6$egl$1@penguin.transmeta.com>
 <01080315090600.01827@starship>
 <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu>
 <9keqr6$egl$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch down()s a semaphore without calling up() in the error code path...

Best regards,

Anton

At 23:01 03/08/2001, Chris Wedgwood wrote:
>On Fri, Aug 03, 2001 at 06:34:14PM +0000, Linus Torvalds wrote:
>
>         fsync(int fd)
>         {
>                 dentry = fdget(fd);
>                 do_fsync(dentry);
>                 for (;;) {
>                         tmp = dentry;
>                         dentry = dentry->d_parent;
>                         if (dentry == tmp)
>                                 break;
>                         do_fdatasync(dentry);
>                 }
>         }
>
>I really like this idea. Can people please try out the attached patch?
>
>Please note, it contains a couple of things that need not be there in
>the final version.
>
>Note, there is also a reiserfs fix in here because we can call
>f_op->fsync on a directory and without this fix it will BUG!  Chris,
>perhaps you can suggest a better fix?
>
>
>Linus, one more thing --- the first argument to ->fsync is struct file*
>and nothing uses it, I'd like to blow it away or would you prefer we
>wait to 2.5.x as its essentially and API change and will break XFS,
>JFS, etc.
>
>
>
>    --cw

-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

