Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268653AbRGZU4L>; Thu, 26 Jul 2001 16:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268686AbRGZU4B>; Thu, 26 Jul 2001 16:56:01 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:52439 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268653AbRGZUzl>; Thu, 26 Jul 2001 16:55:41 -0400
Message-Id: <5.1.0.14.2.20010726214022.00b14920@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 26 Jul 2001 21:55:46 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ext3-2.4-0.9.4
Cc: Richard A Nelson <cowboy@vnet.ibm.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107261233000.1062-100000@penguin.transmeta.
 com>
In-Reply-To: <Pine.LNX.4.33.0107261429190.19887-100000@badlands.lexington.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

At 20:37 26/07/2001, Linus Torvalds wrote:
>On Thu, 26 Jul 2001, Richard A Nelson wrote:
> > In looking at the synchronous directory options, I'm unsure as to
> > the 'real' status wrt fsync() on a directory:
> >       1) Does fsync() of a directory work on most/all current FS?
>
>Modulo bugs, yes.
>
>Now, there's another issue, of course: if you have an important mail-spool
>on some of the less tested filesystems, I would consider you crazy
>regardless of fsync() working ;). I don't think anybody has ever verified
>that fsync() (or much anything else wrt writing) does the right thing on
>NTFS, for example.

NTFS doesn't even have an fsync() operation defined so calling fsync() 
system call won't do anything at all. A quick look at 
fs/buffer.c::sys_fsync() shows it will return -EINVAL straight away.

But considering the fsync, even if present may well trash the file or the 
whole partition's data, it's just as well it doesn't happen...

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

