Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269532AbRHIJ1n>; Thu, 9 Aug 2001 05:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269533AbRHIJ1d>; Thu, 9 Aug 2001 05:27:33 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:39165 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S269532AbRHIJ1X>; Thu, 9 Aug 2001 05:27:23 -0400
Importance: Normal
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
To: Arjan van de Ven <arjanv@redhat.com>, trini@kernel.crashing.org,
        linux-kernel@vger.kernel.org, ext3-users@redhat.com
Cc: "Carsten Otte" <COTTE@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF3B2CDA95.E1850ED7-ONC1256AA3.0031FECD@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Thu, 9 Aug 2001 11:26:29 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 09/08/2001 11:27:09
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Well ext3 has more debugging checks than ext3 at the moment, and also
requires the
>underlying blocklayers (LVM/RAID etc) to not lie. So the test _IS_
relevant,
>not to caste blame, but to find the interaction.....


OK, I tried it now  with md  and the bug was there again. Now during a rm
-rf * .
As the bug ouccured with LVM __and__  with MD it looks like a ext3-problem.
Tom Rini reported the same problem on a PPC-Box. Possibly it is a big
endian problem.

The message was again:
kernel: Assertion failure in journal_forget() at transaction.c:1184:
"!jh->b_committed_data"


Here a have a new backtrace, I resolved the functions manually from
system.map -hopefully without a mistake.

kernel BUG at transaction.c:1184!
illegal operation: 0001
CPU:    1
Process rm (pid: 1917, stackpage=06125000)

Kernel PSW:    070c0000 8008023c   =journal_forget
task: 06124000 ksp: 06125938 pt_regs: 061258a0
Kernel GPRS:
00000000  8001c118  00000022  00000001
8008023a  00c2a000  00197198  00000001
12fc1880  08d06494  00001899  1575c9b0
0001f94c  800800ac  8008023a  06125938
Kernel ACRS:
00000000  00000000  00000000  00000000
00000001  00000000  00000000  00000000
00000000  00000000  00000000  00000000
00000000  00000000  00000000  00000000
Kernel BackChain  CallChain
       06125938   [<0008023a>]           =journal_forget
       061259a0   [<000747e6>]           =ext3_forget
       06125a08   [<00076c00>]           =ext3_clear_blocks
       06125a70   [<00076d20>]           =ext3_free_data
       06125ae8   [<00076ee4>]           =ext3_free_branches
       06125b60   [<00076e44>]           =ext3_free_branches
       06125bd8   [<00076e44>]           =ext3_free_branches
       06125c50   [<0007723c>]           =ext3_truncate


greetings



