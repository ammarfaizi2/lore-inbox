Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130433AbQKJOQI>; Fri, 10 Nov 2000 09:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130666AbQKJOPt>; Fri, 10 Nov 2000 09:15:49 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:5167 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130433AbQKJOPq>; Fri, 10 Nov 2000 09:15:46 -0500
Message-ID: <3A0C030C.DE694934@linux.com>
Date: Fri, 10 Nov 2000 06:15:40 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: [bug] kernel panic related to reiserfs, 2.4.0-test11-pre1 and 3.6.18
Content-Type: multipart/mixed;
 boundary="------------F985D2F7C572013006C90D76"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F985D2F7C572013006C90D76
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Over the last three weeks my box has been locking up w/ a black screen
of death.  This time I had kdb patched in and got the following:

Entering kdb (current=0xcf906000, pid 16808) Panic: invalid operand
due to panic @ 0xc0163d7a
eax = 0x0000001a ebx = 0xcf907d8c ecx = 0xcf906000 edx = 0xcd3cde00
esi = 0xc36fc494 edi = 0xcf907cd4 esp = 0xcf907c78 eip = 0xc0163d7a
ebp = 0xcf907cd4 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs =
0xcf907c44
kdb> bt
    EBP       EIP         Function(args)
0xcf907cd4 0xc0163d7a de_still_valid+0x3e (0xcf4dcf80, 0xa, 0xcf907d8c)
                               kernel .text 0xc0100000 0xc0163d3c
0xc0163e18
0xcf907cf0 0xc0163e31 entry_points_to_object+0x19 (0xcf4dcf80, 0xa,
0xcf907d8c, 0xc6f053e0, 0xce3a39a8)
                               kernel .text 0xc0100000 0xc0163e18
0xc0163e98
0xcf907f04 0xc01642fa reiserfs_rename+0x432 (0xce3a3940, 0xc974d2c0,
0xce3a3940, 0xcf4dcf20)
                               kernel .text 0xc0100000 0xc0163ec8
0xc0164610
0xcf907f2c 0xc0139c94 vfs_rename_other+0x26c (0xce3a3940, 0xc974d2c0,
0xce3a3940, 0xcf4dcf20)
                               kernel .text 0xc0100000 0xc0139a28
0xc0139cec
0xcf907f50 0xc0139d25 vfs_rename+0x39 (0xce3a3940, 0xc974d2c0,
0xce3a3940, 0xcf4dcf20)
                               kernel .text 0xc0100000 0xc0139cec
0xc0139d7c
0xcf907fbc 0xc0139ef9 sys_rename+0x17d (0xbfffd824, 0x809c160,
0x809c160, 0xbfffd824, 0x811b048)
                               kernel .text 0xc0100000 0xc0139d7c
0xc0139f80
           0xc010aadb system_call+0x33
                               kernel .text 0xc0100000 0xc010aaa8
0xc010aae0

kdb> sr s
SysRq: Emergency Sync
kdb> g
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0163d7a>]
EFLAGS: 00010246
eax: 0000001a   ebx: cf907d8c   ecx: cf906000   edx: cd3cde00
esi: c36fc494   edi: cf907cd4   ebp: cf907cd4   esp: cf907c78
ds: 0018   es: 0018   ss: 0018
Process sendmail (pid: 16808, stackpage=cf907000)
Stack: c02ba2e5 c02ba37d 0000004d cf907d8c c6f053e0 c6f053e0 c0cd73c0
00000012
       c36fc1c8 00000005 c36fc444 00000010 0000000a c36fc6e4 00000000
0000057b
       00002b2e 0000056c 0000057b 32e1fd80 000001f4 00000000 ce8fe472
cf907cf0
Call Trace: [<c02ba2e5>] [<c02ba37d>] [<c0163e31>] [<c01642fa>]
[<c02bf60f>] [<c0139c94>] [<c0139d25>]
       [<c0139ef9>] [<c010aadb>]
Code: 0f 0b 8b 7d c4 8b 45 bc 8b 4d c8 0f b7 57 14 03 50 34 89 c8


I have been writing code on it for the last two days straight.  It was
fully functional until I left for 15 minutes for a shower.  I came back
and the system is hosed.  Everything is quickly going to D state.  I can
move and type until I attempt to execute or reference anything.  It's
all downhill from there.

It is 2.4.0-test11-pre1 with reiserfs 3.6.18.

With kdb, after the panic happens, I can hit 'sr s' then 'g', it will
OOPS (process sendmail) then continue.  Without kdb, I am SOL and have
to hit the power button.  sysrq won't react.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------F985D2F7C572013006C90D76
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------F985D2F7C572013006C90D76--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
