Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSGQQit>; Wed, 17 Jul 2002 12:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSGQQis>; Wed, 17 Jul 2002 12:38:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65041 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315265AbSGQQis>;
	Wed, 17 Jul 2002 12:38:48 -0400
Message-ID: <3D35A024.1635E12E@zip.com.au>
Date: Wed, 17 Jul 2002 09:49:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/13] lseek speedup
References: <3D3598F0.FBBA9DB6@zip.com.au> <5.1.0.14.2.20020717171311.00b00380@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> >  Now, why are we taking i_sem for lseek/readdir
> >exclusion and not a per-file lock?
> 
> Because it also excludes against directory modifications, etc. Just imagine
> what "rm somefile" or "mv somefile otherfile" or "touch newfile" would do
> to the directory contents and what a concurrent readdir() would do... A
> very loud *BANG* is the only thing that springs to mind...

That's different.  i_size, contents of things, yes - i_sem for
those.

But protection of struct file should not be via any per-inode thing.

> btw. the directory modification locking rules are written up in
> Documentation/filesystems/directory-locking by our very own VFS maintainer
> Al Viro himself... (-;

Doesn't cover lseek...

-
