Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRHYPY5>; Sat, 25 Aug 2001 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRHYPYr>; Sat, 25 Aug 2001 11:24:47 -0400
Received: from [212.172.122.16] ([212.172.122.16]:50440 "EHLO qmail.root.at")
	by vger.kernel.org with ESMTP id <S269413AbRHYPYe>;
	Sat, 25 Aug 2001 11:24:34 -0400
Message-ID: <3B87C2EB.6DD2593F@root.at>
Date: Sat, 25 Aug 2001 17:23:23 +0200
From: Clemens Kirchgatterer <clemens@root.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel maillinglist <linux-kernel@vger.kernel.org>
Subject: maybe OT: segfault on insmod
In-Reply-To: <Pine.LNX.4.33.0108201010150.3433-100000@fb07-calculator.math.uni-giessen.de>		<3B863DF5.B65F39EF@root.at>		<3B8676B1.ED0D2E93@root.at> <15238.34298.191647.559304@valen.metzler> <3B869A6B.A4D77841@root.at> <3B86A3B6.7030309@t-online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

this is probably the wrong maillinglist, but i'm quite shure, that you
guys at least know, what these errors mean and in which directions i
have to look further on.

FYI: saa7146_core.o and dvb.o are modules comeing with the dvb (digital
video broadcast) driver for linux>=2.4.3

insmod is not able to load the modules  correctly. they
show up when i do lsmod but have a (initializing) before the [used by].

this is the relevant part from my dmesg output. can anybody see what is
going on here? i2c and videodev is compiled into kernel. machine is
pentium 100, 128MB ram, no harddisk, kernel-2.4.9, nfsroot, no real
system (init script directly loads the modules and starts a bash for
debugging.


every tipp will be highly welcome!

best regards ...
clemens

-------------------------------------------------------------------


kernel initialization is completed here:

VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev 
Freeing unused kernel memory: 216k freed
i2c-core.o: driver VES1893 DVB demodulator registered.
i2c-core.o: driver VES1820 DVB demodulator registered.
i2c-core.o: driver L64781 DVB demodulator registered.
L64781: init done
i2c-core.o: driver tda8083 DVB demodulator registered.
i2c-core.o: driver stv0299 DVB demodulator registered.
i2c-core.o: driver i2c TV tuner driver registered.

this happens when insmoding saa7146_core.o:

Unable to handle kernel paging request at virtual address c981f000
 printing eip:
c9818a74
*pde = 0129c067
*pte = 08b91163
Oops: 000b
CPU:    0
EIP:    0010:[<c9818a74>]
EFLAGS: 00010216
eax: 7f7f7f7f   ebx: 00480000   ecx: 00120000   edx: 7f7f7f7f
esi: 00000000   edi: c981f000   ebp: 00000002   esp: c8dd1e98
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 70, stackpage=c8dd1000)
Stack: 00000000 00000000 c8b94000 00000800 00000000 c981f000 c98193c4
00000002
       c981b168 c1292c00 c1292c00 c981b0c0 00000000 00000001 c981b168
c981b100
       04800001 c9819b10 c1292c00 00000000 c981b07c 100213c2 c01d88fe
c1292c00
Call Trace: [<c98193c4>] [<c981b168>] [<c981b0c0>] [<c981b168>]
[<c981b100>]
   [<c9819b10>] [<c981b07c>] [<c01d88fe>] [<c981b07c>] [<c981b0c0>]
[<c01d8964>]
   [<c981b0c0>] [<c981806d>] [<c9819b89>] [<c981b0c0>] [<c011506d>]
[<c9818060>]
   [<c0106b63>]

Code: f3 ab f6 c3 02 74 02 66 ab f6 c3 01 74 01 aa f6 05 28 b0 81

and this for dvb.o:

invalid operand: 0000
CPU:    0
EIP:    0010:[<c9cb31ae>]
EFLAGS: 00010297
eax: 00000001   ebx: c1292c00   ecx: 00000cf8   edx: 00001002
esi: 00000000   edi: 00000000   ebp: c9cb6220   esp: c8dd1f04
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 73, stackpage=c8dd1000)
Stack: c981b100 00000000 13c21002 c9cb3b6d c1292c00 00000000 00000006
00000006
       00039130 c9cb3d15 c9ca9000 c011506d c8dd0000 08065c80 c9ca9000
bfffeb8c
       0000cfbc c8533000 00000054 c8534000 ffffffea 00000003 c129de80
00000060
Call Trace: [<c981b100>] [<c9cb3b6d>] [<c9cb3d15>] [<c011506d>]
[<c9ca9060>]
   [<c0106b63>]

Code: 0f 4d f0 89 f0 5b 5e 59 c3 90 83 ec 38 55 57 56 53 8b 5c 24
