Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310217AbSCFWSs>; Wed, 6 Mar 2002 17:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310219AbSCFWSj>; Wed, 6 Mar 2002 17:18:39 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:48109 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S310217AbSCFWS3>;
	Wed, 6 Mar 2002 17:18:29 -0500
Date: Wed, 6 Mar 2002 22:22:41 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: <linux-kernel@vger.kernel.org>
Subject: chroot_fs_refs and pivot_root question
Message-ID: <Pine.LNX.4.33.0203062221030.2531-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Looking at (2.4.9's) sys_pivot_root() implementation I can see that it
moves all the processes' root/pwd references from the old root to the new
one.

However, somehow /sbin/init managed to survive the move and is keeping the
filesystem busy:

# lsof /sysroot
COMMAND PID     USER  FD   TYPE DEVICE    SIZE  NODE NAME
init      1        0 txt    REG  22,65   28220 11217 /sysroot/sbin/init
init      1        0 mem    REG  22,65  468849 10376
/sysroot/lib/ld-2.2.2.so
init      1        0 mem    REG  22,65 5636080 10370
/sysroot/lib/i686/libc-2.2.2.so

# cat /proc/1/maps
08048000-0804f000 r-xp 00000000 16:41 11217      /sysroot/sbin/init
0804f000-08050000 rw-p 00006000 16:41 11217      /sysroot/sbin/init
08050000-08054000 rwxp 00000000 00:00 0
15556000-1556c000 r-xp 00000000 16:41 10376      /sysroot/lib/ld-2.2.2.so
1556c000-1556d000 rw-p 00015000 16:41 10376      /sysroot/lib/ld-2.2.2.so
1556d000-1556e000 rw-p 00000000 00:00 0
15573000-15699000 r-xp 00000000 16:41 10370      /sysroot/lib/i686/libc-2.2.2.so
15699000-1569f000 rw-p 00125000 16:41 10370      /sysroot/lib/i686/libc-2.2.2.so
1569f000-156a3000 rw-p 00000000 00:00 0
3fffe000-40000000 rwxp fffff000 00:00 0

Any clues why and how to force it to exec a binary on the new root (or
get rid of it in any other way)?

Regards,
Tigran



