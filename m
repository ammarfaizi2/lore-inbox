Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUEESGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUEESGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 14:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbUEESGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 14:06:09 -0400
Received: from p3EE0629D.dip0.t-ipconnect.de ([62.224.98.157]:63360 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S264798AbUEESGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 14:06:03 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Problem with nptl and uname
Date: Wed, 05 May 2004 20:05:41 +0200
Organization: privat
Message-ID: <c7badk$333$1@p3EE0629D.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040502
X-Accept-Language: de, en-us, en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've have a problem to get ntpl working on my machine:

I have a AMD Athlon XP and kernel 2.6.6-rc3 (2.6.6-rc3-mm1). I compiled 
glibc 2.3.3 with gcc 3.3.2, kernelheaders 2.6.5.1 and binutils 
2.15.90.0.3 with

configure --with-tls --prefix=/usr --enable-add-ons=nptl --enable-kernel=2.4.1

It doesn't matter, if --enable-kernel is given or not or if it is 2.6.x or 
2.2.99.

Compiling works fine until make check / tst-attr3 core dumps:

initial thread stack 0x80037000-0xc0000000 (0x3ffc9000)
/opt/cd/libc/compile/nptl/tst-attr3: pthread_create #1 failed: Cannot 
allocate memory
/opt/cd/libc/compile/nptl/tst-attr3: pthread_create #2 failed: Cannot 
allocate memory
/opt/cd/libc/compile/nptl/tst-attr3: pthread_create #3 failed: Cannot 
allocate memory

strace says:
11177 setrlimit(RLIMIT_CORE, {rlim_cur=0, rlim_max=0} <unfinished ...>
11177 <... setrlimit resumed> )         = 0
11177 getrlimit(RLIMIT_DATA,  <unfinished ...>
11177 <... getrlimit resumed> {rlim_cur=2147483647, rlim_max=2147483647}) = 0
11177 setrlimit(RLIMIT_DATA, {rlim_cur=65536*1024, rlim_max=2147483647}) = 0
11177 setpgid(0, 0)                     = 0
11177 brk(0)                            = 0x80016000
11177 brk(0x80037000)                   = 0x80037000
11177 brk(0)                            = 0x80037000
11177 open("/proc/self/maps", O_RDONLY) = 3
11177 getrlimit(RLIMIT_STACK, {rlim_cur=2147483647, rlim_max=2147483647}) = 0
11177 fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
11177 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x40125000
11177 read(3, "08048000-0804b000 r-xp 00000000 "..., 1024) = 910
11177 close(3)                          = 0
11177 munmap(0x40125000, 4096)          = 0
11177 sched_getaffinity(11177, 32,



There seems to be another problem wit uname:

Hardware platform:
uname -i
unknown

CPU:
uname -p
unknown


Is this normal for Athlon boards? What should it be, if it is not correct? 
What could be the reason for this wrong info?



Thank you very much for any hint,
kind regards,
Andreas Hartmann
