Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWGGJm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWGGJm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWGGJm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:42:27 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:64749 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S932096AbWGGJm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:42:26 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.5/1.7):. Processed in 3.10554 secs Process 27854)
From: "Abu M. Muttalib" <abum@aftek.com>
To: <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: Commenting out out_of_memory() function in __alloc_pages()
Date: Fri, 7 Jul 2006 15:16:37 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMAEBKDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0024_01C6A1D8.57723C30"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0024_01C6A1D8.57723C30
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I am getting the Out of memory.

To circumvent the problem, I have commented the call to "out_of_memory(),
and replaced "goto restart" with "goto nopage".

At "nopage:" lable I have added a call to "schedule()" and then "return
NULL" after "schedule()".

I tried the modified kernel with a test application, the test application is
mallocing memory in a loop. Unlike as expected the process gets killed. On
second run of the same application I am getting the page allocation failure
as expected but subsequently the system hangs.

I am attaching the test application and the log herewith.

I am getting this exception with kernel 2.6.13. With kernel
2.4.19-rmka7-pxa1 there was no problem.

Why its so? What can I do to alleviate the OOM problem?

Thanks in anticipation and regards,
Abu.

------=_NextPart_000_0024_01C6A1D8.57723C30
Content-Type: text/plain;
	name="mail_oom_test_6.TXT"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mail_oom_test_6.TXT"

sh-3.00# ./test1=07

OOM Test: Counter =3D 0
....
OOM Test: Counter =3D 6635
, OOM: Out of Memory would have been called....<4>test1: page allocation =
failure. order:0, mode:0xd2=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:2=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:1=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         588kB (0kB HighMem)=0A=
=0DActive:2178 inactive:230 dirty:0 writeback:0 unstable:0 free:147 =
slab:367 mapped:2178 pagetables:43=0A=
=0DDMA free:588kB min:512kB low:640kB high:768kB active:8712kB =
inactive:920kB present:16384kB pages_scanned:4851 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 9*4kB 3*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 588kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D218 free pages=0A=
=0D625 reserved pages=0A=
=0D367 slab pages=0A=
=0D0 pages shared=0A=
=0D0 pages swap cached=0A=
=0DVM: killing process test1=0A=
=0DKilled
sh-3.00# ./test1

OOM Test: Counter =3D 0
....
OOM Test: Counter =3D 6416
, OOM: Out of Memory would have been called....<4>test1: page allocation =
failure. order:0, mode:0x201d0=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:2=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:1=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         672kB (0kB HighMem)=0A=
=0DActive:2187 inactive:170 dirty:0 writeback:0 unstable:0 free:168 =
slab:365 mapped:2125 pagetables:43=0A=
=0DDMA free:672kB min:512kB low:640kB high:768kB active:8748kB =
inactive:680kB present:16384kB pages_scanned:2939 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 28*4kB 6*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 672kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D239 free pages=0A=
=0D625 reserved pages=0A=
=0D365 slab pages=0A=
=0D13 pages shared=0A=
=0D0 pages swap cached=0A=
=0DError -5 while decompressing!=0A=
=0Dc01e42f4(2388)->c0754000(4096)=0A=
=0DError -3 while decompressing!=0A=
=0Dc01e4c48(2531)->c0caf000(4096)=0A=
=0DError -3 while decompressing!=0A=
=0Dc01e562b(2643)->c0914000(4096)=0A=
=0D, OOM: Out of Memory would have been called....<4>test1: page =
allocation failure. order:0, mode:0x201d2=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:3=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:1=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         600kB (0kB HighMem)=0A=
=0DActive:2267 inactive:113 dirty:0 writeback:0 unstable:0 free:150 =
slab:365 mapped:2125 pagetables:43=0A=
=0DDMA free:600kB min:512kB low:640kB high:768kB active:9068kB =
inactive:452kB present:16384kB pages_scanned:222 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 22*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 600kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D222 free pages=0A=
=0D625 reserved pages=0A=
=0D365 slab pages=0A=
=0D13 pages shared=0A=
=0D0 pages swap cached=0A=
=0D, OOM: Out of Memory would have been called....<4>init: page =
allocation failure. order:0, mode:0x201d0=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:3=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:1=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         696kB (0kB HighMem)=0A=
=0DActive:2220 inactive:136 dirty:0 writeback:0 unstable:0 free:174 =
slab:365 mapped:2125 pagetables:43=0A=
=0DDMA free:696kB min:512kB low:640kB high:768kB active:8880kB =
inactive:544kB present:16384kB pages_scanned:6729 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 44*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 696kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D246 free pages=0A=
=0D625 reserved pages=0A=
=0D365 slab pages=0A=
=0D3 pages shared=0A=
=0D0 pages swap cached=0A=
=0DError -5 while decompressing!=0A=
=0Dc01e7949(2386)->c040d000(4096)=0A=
=0DError -3 while decompressing!=0A=
=0Dc01e829b(2297)->c05e9000(4096)=0A=
=0D, OOM: Out of Memory would have been called....<4>init: page =
allocation failure. order:0, mode:0x201d2=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:4=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:1=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         600kB (0kB HighMem)=0A=
=0DActive:2189 inactive:166 dirty:0 writeback:0 unstable:0 free:150 =
slab:364 mapped:2125 pagetables:43=0A=
=0DDMA free:600kB min:512kB low:640kB high:768kB active:8756kB =
inactive:664kB present:16384kB pages_scanned:7675 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 20*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 600kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D223 free pages=0A=
=0D625 reserved pages=0A=
=0D364 slab pages=0A=
=0D1 pages shared=0A=
=0D0 pages swap cached=0A=
=0D, OOM: Out of Memory would have been called....<4>test1: page =
allocation failure. order:0, mode:0x201d0=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:4=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:1=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         600kB (0kB HighMem)=0A=
=0DActive:2291 inactive:64 dirty:0 writeback:0 unstable:0 free:150 =
slab:364 mapped:2125 pagetables:43=0A=
=0DDMA free:600kB min:512kB low:640kB high:768kB active:9164kB =
inactive:256kB present:16384kB pages_scanned:10106 all_unreclaimable? yes=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 20*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 600kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D223 free pages=0A=
=0D625 reserved pages=0A=
=0D364 slab pages=0A=
=0D2 pages shared=0A=
=0D0 pages swap cached=0A=
=0D, OOM: Out of Memory would have been called....<4>init: page =
allocation failure. order:0, mode:0x201d2=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:4=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:0=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         512kB (0kB HighMem)=0A=
=0DActive:2296 inactive:125 dirty:0 writeback:0 unstable:0 free:128 =
slab:364 mapped:2127 pagetables:43=0A=
=0DDMA free:512kB min:512kB low:640kB high:768kB active:9184kB =
inactive:500kB present:16384kB pages_scanned:10106 all_unreclaimable? yes=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 512kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D200 free pages=0A=
=0D625 reserved pages=0A=
=0D364 slab pages=0A=
=0D34 pages shared=0A=
=0D0 pages swap cached=0A=
=0D, OOM: Out of Memory would have been called....<4>init: page =
allocation failure. order:0, mode:0x201d2=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:4=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:0=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         512kB (0kB HighMem)=0A=
=0DActive:2296 inactive:125 dirty:0 writeback:0 unstable:0 free:128 =
slab:364 mapped:2127 pagetables:43=0A=
=0DDMA free:512kB min:512kB low:640kB high:768kB active:9184kB =
inactive:500kB present:16384kB pages_scanned:10106 all_unreclaimable? yes=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 512kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D200 free pages=0A=
=0D625 reserved pages=0A=
=0D364 slab pages=0A=
=0D34 pages shared=0A=
=0D0 pages swap cached=0A=
=0D, OOM: Out of Memory would have been called....<4>test1: page =
allocation failure. order:0, mode:0x201d2=0A=
=0DMem-info:=0A=
=0DDMA per-cpu:=0A=
=0Dcpu 0 hot: low 2, high 6, batch 1 used:4=0A=
=0Dcpu 0 cold: low 0, high 2, batch 1 used:0=0A=
=0DNormal per-cpu: empty=0A=
=0DHighMem per-cpu: empty=0A=
=0DFree pages:         512kB (0kB HighMem)=0A=
=0DActive:2296 inactive:125 dirty:0 writeback:0 unstable:0 free:128 =
slab:364 mapped:2133 pagetables:43=0A=
=0DDMA free:512kB min:512kB low:640kB high:768kB active:9184kB =
inactive:500kB present:16384kB pages_scanned:10106 all_unreclaimable? yes=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DNormal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB =
present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DHighMem free:0kB min:128kB low:160kB high:192kB active:0kB =
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no=0A=
=0Dlowmem_reserve[]: 0 0 0=0A=
=0DDMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB =
0*1024kB =3D 512kB=0A=
=0DNormal: empty=0A=
=0DHighMem: empty=0A=
=0DSwap cache: add 0, delete 0, find 0/0, race 0+0=0A=
=0DFree swap  =3D 0kB=0A=
=0DTotal swap =3D 0kB=0A=
=0DFree swap:            0kB=0A=
=0D4096 pages of RAM=0A=
=0D200 free pages=0A=
=0D625 reserved pages=0A=
=0D364 slab pages=0A=
=0D40 pages shared=0A=
=0D0 pages swap cached=0A=
=0D, OOM: Out of Memory would have been called....VM: killing process =
test1=0A=
=0D





















------=_NextPart_000_0024_01C6A1D8.57723C30
Content-Type: application/octet-stream;
	name="test1.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="test1.c"

#include<stdio.h>=0A=
#include<string.h>=0A=
=0A=
main()=0A=
{=0A=
	char* buff;=0A=
	int count;=0A=
	=0A=
	count=3D0;=0A=
	while(1)=0A=
	{=0A=
		printf("\nOOM Test: Counter =3D %d", count);=0A=
		buff =3D (char*) malloc(1024);=0A=
	//	memset(buff,'\0',1024);=0A=
		count++;=0A=
			=0A=
		if (buff=3D=3DNULL)=0A=
		{=0A=
			printf("\nOOM Test: Memory allocation error");=0A=
		}=0A=
	}=0A=
}=0A=

------=_NextPart_000_0024_01C6A1D8.57723C30--

