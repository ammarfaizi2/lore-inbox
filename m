Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130235AbRAOKnN>; Mon, 15 Jan 2001 05:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130400AbRAOKnD>; Mon, 15 Jan 2001 05:43:03 -0500
Received: from shaker.worfie.net ([203.8.161.33]:53000 "HELO mail.worfie.net")
	by vger.kernel.org with SMTP id <S130235AbRAOKmn>;
	Mon, 15 Jan 2001 05:42:43 -0500
Date: Mon, 15 Jan 2001 18:42:40 +0800 (WST)
From: "J.Brown (Ender/Amigo)" <ender@enderboi.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0 kernel oops from apt-get (dcache.h)
Message-ID: <Pine.LNX.4.30.0101151836360.12306-100000@shaker.worfie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After manually deleting the apt-get cache in Debian Linux (2.2), apt-get
consistantly causes a kernel Oops/BUG when installing new packages.

This happens in 2.4.0 (With a few basic patches to fix compilation errors)
and also with the latest PPC bitkeeper tree based off 2.4.1pre1. Dump
below is with the newer kernel, because it's totally stable at the moment
(whereas 2.4.0 final still suffers from other unrelated crashes and
instabilities).

Transcript:

sharky:~# apt-get install libqt2-dev
Reading Package Lists... Done
Building Dependency Tree... Done
The following NEW packages will be installed:
  libqt2-dev
0 packages upgraded, 1 newly installed, 0 to remove and 39 not upgraded.
1 packages not fully installed or removed.
Need to get 3228kB of archives. After unpacking 10.2MB will be used.
Err ftp://mirror.aarnet.edu.au potato/main libqt2-dev 1:2.0.2-1.1
  Something wicked happend resolving 'mirror.aarnet.edu.au/ftp'
Get:1 ftp://mirror.aarnet.edu.au testing/main libqt2-dev 1:2.0.2-1.1 [3228kB]
99% [1 libqt2-dev 3211264/3228kB 99%]                                                                               52.7kB/s 0s
kernel BUG at /usr/src/linuxppc_2_4/include/linux/dcache.h:237!
Oops: Exception in kernel mode, sig: 4
NIP: C007D930 XER: 00000000 LR: C007D930 SP: C12D1D40 REGS: c12d1c90 TRAP: 0700
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c12d0000[274] 'apt-get' Last syscall: 38
last math c12d0000 last altivec 00000000
GPR00: C007D930 C12D1D40 C12D0000 00000040 00001032 00000001 FFFFFFFF 00000000
GPR08: 00000000 C01E0000 0000001F C12D1C80 22224442 10035E5C 00000001 00000000
GPR16: 00000000 10030000 10030000 00000000 00000000 C0A91E00 00000000 C0A91820
GPR24: C0A91A00 C1948E20 C0A91A2C C100C9A0 C01A0000 C1948DA0 C0A91A24 C0A8BE40
Call backtrace:
C007D930 C004B38C C004B468 C004B6D0 C000417C 00000000 0FFA5180
0FFAA928 0FFADC6C 0FF97BFC 0FF97DC4 100090F4 1000DCE0 0FF61C8C
10016130 0FD22BC8 00000000
Illegal instruction
sharky:~#


I now have a zombie apt-get process I can't even kill -9..

Also if I try and ls in the /var/cache/apt/archives directory, ls freezes
likewise (no error message, just an unkillable console-attached zombie).

I'm not sure if this is a filesystem or memory management issue - but FYI
anyway, and hoping someone else has encounted a similar problem.



Regards,
	 Ender
 _________________________ ______________________________
|   James 'Ender' Brown   | "Where are we going, and why |
| http://www.enderboi.com |  am I in this handbasket?!?" |
+-------------------------+------------------------------+


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
