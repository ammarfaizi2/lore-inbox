Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316833AbSFKFd5>; Tue, 11 Jun 2002 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSFKFd4>; Tue, 11 Jun 2002 01:33:56 -0400
Received: from zok.SGI.COM ([204.94.215.101]:9660 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316833AbSFKFdz>;
	Tue, 11 Jun 2002 01:33:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 no timestamp update on modified mmapped files
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 15:33:48 +1000
Message-ID: <10339.1023773628@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fd = open("foo", O_RDWR);
map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
... modify the mapped pages ...
munmap(map, size);
close(fd);

The timestamp on foo is not updated, even though the contents have
changed.  Adding msync(map, size, MS_[A]SYNC) before munmap makes no
difference.  2.4.19-pre10 has no obvious fixes for this problem.

I was tearing my hair out wondering why some files were not being
rsynced.  No change on size or timestamp tells rsync that the file is
"unchanged".  I had to add a dummy write(map, fd, 1) to force a
timestamp update.

