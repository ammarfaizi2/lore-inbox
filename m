Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129434AbQKYO2X>; Sat, 25 Nov 2000 09:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131227AbQKYO2O>; Sat, 25 Nov 2000 09:28:14 -0500
Received: from mailgw2.netvision.net.il ([194.90.1.9]:23488 "EHLO
        mailgw2.netvision.net.il") by vger.kernel.org with ESMTP
        id <S129434AbQKYO2G>; Sat, 25 Nov 2000 09:28:06 -0500
Message-ID: <3A1FC5C2.BE94DBB8@netvision.net.il>
Date: Sat, 25 Nov 2000 15:59:30 +0200
From: Oren Held <orenh2@netvision.net.il>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG?] test11 - oops on loading some modules
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I patched my test10 directly to test11 (I didn't use the PREs, so I
can't
say which exact version caused my problem, though if it's
important I can check that). Anyway, after I saw the problem, I
downloaded the whole kernel tree to see if it's not just some patching
problem, but it still happens:

Some of the modules I load (bttv.o , eepro.o , ide-scsi.o), return a
kernel oops, and since then I see them in lsmod stuck in that position:
bttv                   55460   1  (initializing)

It seems to me like a problem with modules loading (some of these
modules weren't changed since test10)..
Here's an example of the oops that bttv.o returns:

----
bttv0: model: BT848A(Fly Video II) [insmod option]
Unable to handle kernel paging request at virtual address 00010000
printing eip:
c8852050
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c8852050>]
EFLAGS: 00010202
eax: 00010000   ebx: c8868748   ecx: fffffffb   edx: c886b110
esi: c88683bc   edi: c8868660   ebp: c8868748   esp: c7455e88
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 403, stackpage=c7455000)
Stack: c8858169 c8868660 c8868748 c88683bc c8868666 c8868660 c885c2b7
c8868660
       c8868500 00000001 c8868500 00000001 c8868665 c88648e5 00000000
00000282
       c8868500 c887d000 0000d8a4 c8861e5b c8868500 00000000 c8868500
c12ed400
Call Trace: [<c8858169>] [<c8868660>] [<c8868748>] [<c88683bc>]
[<c8868666>] [<c8868660>] [<c885c2b7>]
[<c8868660>] [<c8868500>] [<c8868500>] [<c8868665>] [<c88648e5>]
[<c8868500>] [<c887d000>] [<c8861e5b>]
[<c8868500>] [<c8868500>] [<c8862b0e>] [<c8868500>] [<c8866a20>]
[<c0188049>] [<c8866988>] [<c8866a20>]
[<c01880a4>] [<c8866a20>] [<c885c000>] [<c8862bf5>] [<c8866a20>]
[<c011ba1d>] [<c885a000>] [<c885c060>]
[<c010a5cb>]
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f0 ff 09 0f

----

Bye,
Oren.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
