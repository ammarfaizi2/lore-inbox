Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284174AbRLPAsL>; Sat, 15 Dec 2001 19:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284175AbRLPAsB>; Sat, 15 Dec 2001 19:48:01 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:28413 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S284174AbRLPArr>;
	Sat, 15 Dec 2001 19:47:47 -0500
Date: Sat, 15 Dec 2001 19:47:46 -0500 (EST)
From: Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: O_DIRECT wierd behavior..
Message-ID: <Pine.GSO.4.02A.10112151947010.14453-100000@aramis.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried this small piece of code from an old post in the archive:

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define O_DIRECT	 040000	/* direct disk access hint */

int main()
{
	char buf[16384];
	int fd;
	char *p;

	p = (char *)((((unsigned long)buf) + 8191) & ~8191L);
	fd = open("/tmp/blah", O_CREAT | O_RDWR | O_DIRECT);

	printf("write returns %i\n", write(fd, buf, 8192));
	printf("write returns %i\n", write(fd, p, 1));

	return 0;
}

Output is:

write returns -1
Filesize limit exceeded (core dumped)

$ ls -l /tmp/blah
----------    1 gsuresh  users    4294967274 Dec 15 19:15 /tmp/blah

The kernel is 2.4.16 and /tmp is ext2. (It runs fine on 2.4.2).

Any idea why this happens and how to fix this?

Thanks
--suresh

