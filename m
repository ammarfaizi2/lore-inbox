Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290891AbSASAu5>; Fri, 18 Jan 2002 19:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290890AbSASAur>; Fri, 18 Jan 2002 19:50:47 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:10247 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S290889AbSASAu0>; Fri, 18 Jan 2002 19:50:26 -0500
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: rm-ing files with open file descriptors
Date: Sat, 19 Jan 2002 00:50:24 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <a2afsg$73g$2@ncc1701.cistron.net>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com>
X-Trace: ncc1701.cistron.net 1011401424 7280 195.64.65.67 (19 Jan 2002 00:50:24 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>This is a characteristic of a VFS (Virtual File System) on any
>Unix system. The file doesn't go away until it is closed by
>everybody that accesses it. However, you can remove or rename it
>even when it's open for write by other tasks. If a task has an
>open file-descriptor and keeps it open, it could 'fix' a possibly
>deleted file, by opening it again with
>
>         new_fd = open("filename", O_CREAT|O_RDWR, 0644);
>
>(without O_TRUNC) and it will remain in existance after all
>file descriptors are closed, because it was "created" again
>after it was deleted by another task.

Well no. new_fd will refer to a completely new, empty file
which has no relation to the old file at all.

There is no way to recreate a file with a nlink count of 0,
well that is until someone adds flink(fd, newpath) to the kernel.

You're a regular on this list, frankly I'm amazed that you
don't know this ?

Mike.

