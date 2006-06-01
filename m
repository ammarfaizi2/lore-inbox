Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWFANoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWFANoi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWFANoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:44:38 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:42685 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1750888AbWFANoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:44:37 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.5.230):SA:0(-102.3/1.7):. Processed in 3.279077 secs Process 25763)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Page Allocation Failure, Why?? Bug in kernel??
Date: Thu, 1 Jun 2006 19:21:30 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMGEIHCNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <447EEADC.4050306@grupopie.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sorry to cause inconvenience. To put the doubts concisely, I am doing
the following:

I am removing the sound driver (shipped with kernel 2.6.13) and then
inserting the same. This all I am doing inside an infinite loop. Before this
I have reserved and used (setting the same with memset) some 900 pages to
simulate an application environment. I am running this application on Linux
2.6.13 on an ARM based target. During the course of the run I get the
following page allocation error:
----------------------------------------------------------------------------
---------------------------------------------------------------insmod: page
allocation failure. order:5, mode:0xd0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:5
cpu 0 cold: low 0, high 2, batch 1 used:1
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         824kB (0kB HighMem)
Active:1625 inactive:291 dirty:0 writeback:0 unstable:0 free:206 slab:483
mapped:1382 pagetables:43
DMA free:824kB min:512kB low:640kB high:768kB active:6500kB inactive:1164kB
present:16384kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 52*4kB 25*8kB 4*16kB 3*32kB 2*64kB 1*128kB 0*256kB 0*512kB 0*1024kB =
824kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
422 free pages
593 reserved pages
483 slab pages
297 pages shared
0 pages swap cached
----------------------------------------------------------------------------
---------------------------------------------------------------
The meminfo and buddyinfo, before the said run of application, is as
follows:
----------------------------------------------------------------------------
---------------------------------------------------------------
Node 0, zone      DMA     15     20      4      3      2      2      0
0      0

MemTotal:        14296 kB
MemFree:           760 kB
Buffers:           224 kB
Cached:           2544 kB
SwapCached:          0 kB
Active:           7340 kB
Inactive:          520 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        14296 kB
LowFree:           760 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           5556 kB
Slab:             1932 kB
CommitLimit:      7148 kB
Committed_AS:     9148 kB
PageTables:        172 kB
VmallocTotal:   630784 kB
VmallocUsed:    262560 kB
VmallocChunk:   366588 kB
----------------------------------------------------------------------------
---------------------------------------------------------------
The meminfo and buddyinfo, after the said run of application, is as follows:
----------------------------------------------------------------------------
---------------------------------------------------------------
MemTotal:        14296 kB
MemFree:           936 kB
Buffers:           144 kB
Cached:           2440 kB
SwapCached:          0 kB
Active:           7308 kB
Inactive:          368 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        14296 kB
LowFree:           936 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           5556 kB
Slab:             1932 kB
CommitLimit:      7148 kB
Committed_AS:     9148 kB
PageTables:        172 kB
VmallocTotal:   630784 kB
VmallocUsed:    262560 kB
VmallocChunk:   366588 kB

Node 0, zone      DMA     21     32      4      3      2      2      0
0      0
----------------------------------------------------------------------------
---------------------------------------------------------------
I fail to understand that despite the fact the system has enough memory, it
is not allocating the same to application. Why? Is it possibly a bug in
kernel?

Thanks and anticipation.

~Abu.

-----Original Message-----
From: Paulo Marques [mailto:pmarques@grupopie.com]
Sent: Thursday, June 01, 2006 6:56 PM
To: Abu M. Muttalib
Cc: linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??


Abu M. Muttalib wrote:
> Hi,

Hi,

> I tried to run an application, try-sound.c. In the course of the run of
the
> application I repeatedly got page allocation failure, despite the fact
that
> enough pages are free. Why this is so, is it a bug in mm subsystem of
Linux
> kernel 2.6.13?
>
> Any pointer to help understand this behavior will be highly appreciated.

If you're expecting kernel developers to unpack your text file and read
through 40555(!!!) lines of text to find out what's wrong...

Please try to explain your problem better with some before / after
comparisons that fit nicely into an email and point out specifically
where you think it went wrong. Also describe what you're trying to do
and what kind of hardware you're using.

For more detailed information on how to report kernel bugs, please read
the file REPORTING-BUGS in the main kernel source directory.

Please don't see this as a "we don't care" message. If the kernel has
indeed a bug we very much do care! We just can't go through thousands of
lines of text to try to understand what the problem is... :(

--
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?

