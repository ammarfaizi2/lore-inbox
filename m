Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130267AbQLKXE0>; Mon, 11 Dec 2000 18:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130686AbQLKXEQ>; Mon, 11 Dec 2000 18:04:16 -0500
Received: from catbert.rellim.com ([204.17.205.1]:17425 "EHLO
	catbert.rellim.com") by vger.kernel.org with ESMTP
	id <S130267AbQLKXEJ>; Mon, 11 Dec 2000 18:04:09 -0500
Date: Mon, 11 Dec 2000 14:33:42 -0800 (PST)
From: "Gary E. Miller" <gem@rellim.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SMBFS does not compile on test12-pre8
Message-ID: <Pine.LNX.4.30.0012111352360.28287-100000@catbert.rellim.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo All!

I just tried to compile SMBFS in test12-pre8.  Here is the error
message I get:

make[3]: Entering directory `/u3/local/src/linux-2.4.0-test12-pre8/fs/smbfs'
gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686  -DSMBFS_PARANOIA  -c -o sock.o sock.c
sock.c: In function `smb_data_ready':
sock.c:166: structure has no member named `next'
make[3]: *** [sock.o] Error 1

This has worked in the recent past.

This is the failing line 166 in fs/smbfs/sock.c:
	job->cb.next = NULL;

It looks like tq_struct has been changed so that the tq_struct->next
member is now tq_struct->list.next.

So can we just delete line 166 in fs/smbfs/sock.c?

Or do we still need to initialize next by changing line 166 to:
	 job->cb.list.next = NULL.

Ideas?

RGDS
GARY
---------------------------------------------------------------------------
Gary E. Miller Rellim 20340 Empire Ave, Suite E-3, Bend, OR 97701
	gem@rellim.com  Tel:+1(541)382-8588 Fax: +1(541)382-8676

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
