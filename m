Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUHPVOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUHPVOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 17:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUHPVOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 17:14:36 -0400
Received: from ohm.divmod.com ([198.49.126.192]:33181 "HELO divmod.com")
	by vger.kernel.org with SMTP id S265544AbUHPVOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 17:14:21 -0400
Subject: Re: inconsistency in thread/signal interaction in 2.6.5 and
	previous vs. 2.6.6 and later (possibly a bug?)
From: Glyph Lefkowitz <glyph@divmod.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0408161247040.2666@dragon.hygekrogen.localhost>
References: <1092650465.3394.13.camel@localhost>
	<Pine.LNX.4.61.0408161247040.2666@dragon.hygekrogen.localhost>
Content-Type: text/plain
Organization: Divmod, LLC
Date: Mon, 16 Aug 2004 17:14:53 -0400
Message-Id: <1092690893.3394.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
x-divmod-processed: Mon, 16 Aug 2004 21:14:19 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 12:48 +0200, Jesper Juhl wrote:

> juhl@dragon:~$ gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
> Completed.
> juhl@dragon:~$ cat /proc/version
> Linux version 2.6.8.1 (juhl@dragon) (gcc version 3.4.1) #1 Sun Aug 15 22:01:56 CEST 2004
> 
> glibc is 2.3.2

Thanks for the feedback.  I will test with 2.6.8.1 myself, just to be
sure, but for those interested in the problem, I've included a few other
recordings of results I got on hosts with a variety of architectures and
kernel versions.

I could swear I tested this on a different host already, but I can't
find the results, so I will build a 2.6.8.1 without debian patches, just
to be sure.

glyph@trogdor:~% gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
Died.
glyph@trogdor:~% cat /proc/version
Linux version 2.6.7-1-686 (dilinger@toaster.hq.voxel.net) (gcc version 3.3.4 (Debian 1:3.3.4-2)) #1 Thu Jul 8 05:36:53 EDT 2004
glyph@trogdor:~% dpkg -l libc6 | tail -1
ii  libc6          2.3.2.ds1-16   GNU C Library: Shared libraries and Timezone

glyph@kazekage:~% gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
Died.
glyph@kazekage:~% cat /proc/version
Linux version 2.6.7-1-k7 (dilinger@toaster.hq.voxel.net) (gcc version 3.3.4 (Debian 1:3.3.4-2)) #1 Thu Jul 8 06:45:35 EDT 2004
glyph@kazekage:~% dpkg -l libc6 | tail -1
ii  libc6          2.3.2.ds1-16   GNU C Library: Shared libraries and Timezone

glyph@wolfwood:~$ gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
Completed.
glyph@wolfwood:~$ cat /proc/version
Linux version 2.4.25vm-1um (root@shared4.tummy.com) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #2 Fri Feb 20 14:03:26 MST 2004
glyph@wolfwood:~$ dpkg -l libc6 | tail -1
ii  libc6          2.3.1-16       GNU C Library: Shared libraries and Timezone

glyph@pyramid:~% gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
Completed.
glyph@pyramid:~% cat /proc/version
Linux version 2.4.18 (root@pyramid.twistedmatrix.com) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Wed Feb 25 14:26:24 MST 2004
glyph@pyramid:~% dpkg -l libc6 | tail -1
ii  libc6          2.2.5-11.5     GNU C Library: Shared libraries and Timezone

glyph@watt:~$ gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
Completed.
glyph@watt:~$ cat /proc/version
Linux version 2.4.25 (root@sparesolo20040319) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Apr 7 16:22:47 MDT 2004
glyph@watt:~$ dpkg -l libc6 | tail -1
ii  libc6          2.3.2.ds1-12   GNU C Library: Shared libraries and Timezone

glyph@erlang:~$ gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
Completed.
glyph@erlang:~$ cat /proc/version
Linux version 2.6.4 (root@erlang) (gcc version 3.3.3 (Debian 20040320)) #10 Mon Mar 22 20:01:54 EST 2004
glyph@erlang:~$ dpkg -l libc6 | tail -1
ii  libc6          2.3.2.ds1-10   GNU C Library: Shared libraries and Timezone


