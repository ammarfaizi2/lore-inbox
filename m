Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSGLPav>; Fri, 12 Jul 2002 11:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSGLPau>; Fri, 12 Jul 2002 11:30:50 -0400
Received: from adsl-65-43-15-209.dsl.clevoh.ameritech.net ([65.43.15.209]:48908
	"EHLO bugs.home.shadowstar.net") by vger.kernel.org with ESMTP
	id <S316582AbSGLPau>; Fri, 12 Jul 2002 11:30:50 -0400
Date: Fri, 12 Jul 2002 11:32:44 -0400 (EDT)
From: Alec Smith <alec@shadowstar.net>
X-X-Sender: alec@bugs.home.shadowstar.net
To: linux-kernel@vger.kernel.org
cc: ext3-users@redhat.com
Subject: ext3 corruption
Message-ID: <Pine.LNX.4.44.0207121127001.7507-100000@bugs.home.shadowstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Over the last month or so, I've noticed the following error showing up
repeatedly in my system logs under kernel 2.4.18-ac3 and more recently
under 2.4.19-rc1:

EXT3-fs error (device ide0(3,3)) in ext3_new_inode: error 28

I've now been able to capture the following Oops before the system went
down entirely:

Assertion failure in do_get_write_access() at transaction.c:611:
"!(((jh2bh(jh))->b_state & (1UL << BH_Lock)) != 0)"
kernel BUG at transaction.c:611!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c015b12e>]    Not tainted
EFLAGS: 00010282
eax: 00000078   ebx: ddadd294   ecx: 00000004   edx: ddb0ff64
esi: ddadd200   edi: dec5d920   ebp: ddadd200   esp: d28dfe70
ds: 0018   es: 0018   ss: 0018
Process sendmail (pid: 21193, stackpage=d28df000)
Stack: c01f7460 c01f5969 c01f58d7 00000263 c01f94a0 00000000 00000000
cbf3b3c0
       ddadd294 ddadd200 dec5d920 d4a82730 c015b506 dec5d920 d4a82730
00000000
       ddd9acc0 ddadd000 dec5d920 c4cbdc20 c015744d dec5d920 ddd9acc0
00000000
Call Trace: [<c015b506>] [<c015744d>] [<c0155b04>] [<c0155b15>]
[<c0155c07>]
   [<c0157a95>] [<c013b5c6>] [<c013b6a9>] [<c0111bc0>] [<c01087eb>]

Code: 0f 0b 63 02 d7 58 1f c0 83 c4 14 8b 4c 24 20 bb e2 ff ff ff


Any help or patches would be greatly appreciated. I'd be glad to provide
more information if needed.


Alec

