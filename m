Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277261AbRJNSK5>; Sun, 14 Oct 2001 14:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277263AbRJNSKr>; Sun, 14 Oct 2001 14:10:47 -0400
Received: from bitmover.com ([192.132.92.2]:32152 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S277261AbRJNSKb>;
	Sun, 14 Oct 2001 14:10:31 -0400
From: Larry McVoy <lm@bitmover.com>
Date: Sun, 14 Oct 2001 11:11:04 -0700
Message-Id: <200110141811.f9EIB4823631@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: NFS file locking?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, the open(2) man page says:

       O_EXCL When  used with O_CREAT, if the file already exists
              it is an error and the open will fail.   O_EXCL  is
              broken  on NFS file systems, programs which rely on
              it for performing locking tasks will contain a race
              condition.  The solution for performing atomic file
              locking using a lockfile is to create a unique file
              on  the  same  fs (e.g., incorporating hostname and
              pid), use link(2) to make a link to  the  lockfile.
              If  link() returns 0, the lock is successful.  Oth­
              erwise, use stat(2) on the unique file to check  if
              its  link  count  has increased to 2, in which case
              the lock is also successful.

I coded this up and tried it here on a cluster of different operating
systems (Linux 2.4.5 server, linux, freebsd, solaris, aix, hpux, irix
clients) and it doesn't work.

2 questions:

a) is it the belief of folks here that this should work?

b) if performance isn't a big issue, is there any portable way to do
   locking over NFS with just files?

