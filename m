Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVCBFes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVCBFes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 00:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVCBFer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 00:34:47 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:22953 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262186AbVCBFeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 00:34:31 -0500
Date: Tue, 1 Mar 2005 21:34:25 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: O_DIRECT on 2.4 ext3
Message-ID: <Pine.GSO.4.44.0503012129410.2361-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I tried to read from a regular ext3 file opened as O_DIRECT, but got the
"Invalid argument" error.  Running the same test program on a block device
succeeded.

uname -a shows
Linux ******* 2.4.27-2-686-smp #1 SMP Thu Jan 20 11:02:39 JST 2005 i686
GNU/Linux

My test case is
#include <sys/types.h>
#include <sys/stat.h>
#include <asm/fcntl.h>
#include <stdio.h>
#include <assert.h>

#define BLK (4096U)
main()
{
	char buf[BLK * 2];
	char *p = (char*)((((unsigned)buf) + (BLK-1)) & ~(BLK-1));
	int fd, l;

	fprintf(stderr, "buf = %p, p = %p\n", buf, p);
	if((fd=open("sbd0", O_RDONLY|O_DIRECT)) < 0) {
		perror("open");
		assert(0);
	}
	if((l=pread(fd, p, BLK, 0)) < 0) {
		perror("pread");
		assert(0);
	}
	fprintf(stderr, "pread returns %d\n", l);
	close (fd);
}

Does anyone know what's going on?

Thanks,
-Junfeng

