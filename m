Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289220AbSA1QKc>; Mon, 28 Jan 2002 11:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSA1QKZ>; Mon, 28 Jan 2002 11:10:25 -0500
Received: from [195.25.229.189] ([195.25.229.189]:52184 "EHLO
	mailrennes.rennes.si.fr.atosorigin.com") by vger.kernel.org
	with ESMTP id <S289220AbSA1QKG>; Mon, 28 Jan 2002 11:10:06 -0500
Message-ID: <008f01c1a815$d8cdcc70$8a140237@rennes.si.fr.atosorigin.com>
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Assertion failure / do_get_write_acess() / loop / samba
Date: Mon, 28 Jan 2002 17:07:12 +0100
Organization: ENIB - Promo `98
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 28 Jan 2002 16:07:12.0756 (UTC) FILETIME=[D8C39340:01C1A815]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I've encountered a reproductible 'Assertion failure' in 2.4.17.
It happens on pure vanilla, as well as on sched O1-J0, and also on
2.4.18-pre4.

I'm testing 2.4.18-pre7 in a moment, when compilling is done
(slow machine).

I've a SMB share mounted on /mnt/smb, in which I've got a 1GiB file
with an ext3 fs on it, that I mount on /mnt/loop

I'm able to write a bit of data on it (about a few Mib), and then I
got this Assertion failure:

--8<-- Begin --8<--
Assertion failure in do_get_write_access() at transaction.c:728:
"(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01599f4>]    Not tainted
EFLAGS: 00010282
eax: 0000007b   ebx: 00000000   ecx: 00000004   edx: 00000000
esi: 00000001   edi: c3206fc0   ebp: c2599b20   esp: c4f81c50
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 1858, stackpage=c4f81000)
Stack: c029fac0 c029bbce c029bb3c 000002d8 c02a1bc0 00000001 00000000
c223a600
       c2f5a4c0 c223a694 c223a600 c3206fc0 c2599b20 c0159a86 c3206fc0
c2599b20
       00000000 c3206fc0 c223a400 00000318 00000005 c014f833 c3206fc0
c21e1a20
Call Trace: [<c0159a86>] [<c014f833>] [<c01515cd>] [<c01518f9>] [<c024a06a>]
   [<c010805a>] [<c0151ee5>] [<c0159ef2>] [<c0132eb2>] [<c0152006>]
[<c013334b>]
   [<c015e887>] [<c0159014>] [<c01339a1>] [<c0151fb0>] [<c015244e>]
[<c0151fb0>]
   [<c012769c>] [<c01386a9>] [<c0131046>] [<c0130aaa>] [<c0106ceb>]

Code: 0f 0b 8b 45 00 83 c4 14 8b 50 38 8b 70 34 8b 7d 0c 0f b7 40
--8<--  End  --8<--

Then the system is almost responsive (switch consoles, exit, etc...).
But when I try to reboot (what I do as soon as I can!), it hangs.
I'm not under X (X running, but I'm under a fb text console, I hate
that much X...).

syslog does not give me any more that the assertion failure.

I have to power it off physically (power cycle) to regain any control.

After reboot, the FS on the loop file seems OK (recovery complete).

Any idea? I'm ready to test anything you might think of. Cause this is
my work machine and I'm in France, don't expect me to be 'interactive'
when posting!

Thank you for your attention.

Regards,
Yann.

--
.---------------------------.----------------------.------------------.
|       Yann E. MORIN       |  Real-Time Embedded  | ASCII RIBBON /"\ |
| Phone: (33/0) 662 376 056 |  Software  Designer  |   CAMPAIGN   \ / |
|   http://ymorin.free.fr   °----------------------:   AGAINST     X  |
| yann.morin.1998@anciens.enib.fr                  |  HTML MAIL   / \ |
°--------------------------------------------------°------------------°



