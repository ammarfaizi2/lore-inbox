Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbSI3BUf>; Sun, 29 Sep 2002 21:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbSI3BUf>; Sun, 29 Sep 2002 21:20:35 -0400
Received: from tomts21.bellnexxia.net ([209.226.175.183]:25244 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261892AbSI3BUd>; Sun, 29 Sep 2002 21:20:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.39-mm1
Date: Sun, 29 Sep 2002 21:24:12 -0400
User-Agent: KMail/1.4.3
Cc: Ingo Molnar <mingo@elte.hu>
References: <3D976206.B2C6A5B8@digeo.com>
In-Reply-To: <3D976206.B2C6A5B8@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209292124.12696.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 29, 2002 04:26 pm, Andrew Morton wrote:
> There is a reiserfs compilation problem at present.

make[2]: Entering directory `/poole/src/39-mm1/fs/reiserfs'
  gcc -Wp,-MD,./.bitmap.o.d -D__KERNEL__ -I/poole/src/39-mm1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -I/poole/src/39-mm1/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=bitmap   -c -o bitmap.o bitmap.c
In file included from bitmap.c:8:
/poole/src/39-mm1/include/linux/reiserfs_fs.h:1635: parse error before `reiserfs_commit_thread_tq'
/poole/src/39-mm1/include/linux/reiserfs_fs.h:1635: warning: type defaults to `int' in declaration of `reiserfs_commit_thread_tq'
/poole/src/39-mm1/include/linux/reiserfs_fs.h:1635: warning: data definition has no type or storage class
make[2]: *** [bitmap.o] Error 1
make[2]: Leaving directory `/poole/src/39-mm1/fs/reiserfs'
make[1]: *** [reiserfs] Error 2
make[1]: Leaving directory `/poole/src/39-mm1/fs'
make: *** [fs] Error 2

which is:

extern task_queue reiserfs_commit_thread_tq ;

from bk chanages:

ChangeSet@1.644, 2002-09-29 11:00:25-07:00, mingo@elte.hu
  [PATCH] smptimers, old BH removal, tq-cleanup

<omitted>

   - removed the ability to define your own task-queue, what can be done is
     to schedule_task() a given task to keventd, and to flush all pending
     tasks.

Ingo?

Ed Tomlinson
