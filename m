Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288277AbSAMXHU>; Sun, 13 Jan 2002 18:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288285AbSAMXG7>; Sun, 13 Jan 2002 18:06:59 -0500
Received: from sm13.texas.rr.com ([24.93.35.40]:15342 "EHLO sm13.texas.rr.com")
	by vger.kernel.org with ESMTP id <S288277AbSAMXGw>;
	Sun, 13 Jan 2002 18:06:52 -0500
Message-Id: <200201132309.g0DN9mma018052@sm13.texas.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Date: Sun, 13 Jan 2002 17:11:58 -0600
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020112125625.E1482@inspiron.school.suse.de> <Pine.LNX.4.21.0201121825200.1105-100000@localhost.localdomain> <a1sqd3$nc6$1@cesium.transmeta.com>
In-Reply-To: <a1sqd3$nc6$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 January 2002 02:24 pm, H. Peter Anvin wrote:
> By the way, expect user programs to fail due to lack of address space
> if you only give them 1 GB of userspace.  At 1 GB of userspace there
> is *no* address space which is compatible with the normal address
> space map available to the user process.


Actually, I think it will work for apps < `600MB since the mmap area is 
automatically adjusted to begin at PAGE_OFFSET/3.

cat /proc/1/maps

CONFIG_1GB
08048000-0804e000 r-xp 00000000 03:41 58716      /sbin/init
0804e000-08050000 rw-p 00005000 03:41 58716      /sbin/init
08050000-08054000 rwxp 00000000 00:00 0
40000000-40016000 r-xp 00000000 03:41 73822      /lib/ld-2.2.4.so
40016000-40017000 rw-p 00015000 03:41 73822      /lib/ld-2.2.4.so
40017000-40018000 rw-p 00000000 00:00 0
4002c000-4015e000 r-xp 00000000 03:41 73816      /lib/i686/libc-2.2.4.so
4015e000-40164000 rw-p 00131000 03:41 73816      /lib/i686/libc-2.2.4.so
40164000-40168000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0

CONFIG_3GB
08048000-0804e000 r-xp 00000000 03:41 58716      /sbin/init
0804e000-08050000 rw-p 00005000 03:41 58716      /sbin/init
08050000-08054000 rwxp 00000000 00:00 0
15556000-1556c000 r-xp 00000000 03:41 73822      /lib/ld-2.2.4.so
1556c000-1556d000 rw-p 00015000 03:41 73822      /lib/ld-2.2.4.so
1556d000-1556e000 rw-p 00000000 00:00 0
15582000-156b4000 r-xp 00000000 03:41 73816      /lib/i686/libc-2.2.4.so
156b4000-156ba000 rw-p 00131000 03:41 73816      /lib/i686/libc-2.2.4.so
156ba000-156be000 rw-p 00000000 00:00 0
3fffe000-40000000 rwxp fffff000 00:00 0

Then again, I agree the 3GB option doesn't make much sense for 99.99% of 
cases.

-Marvin
