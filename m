Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291553AbSBRRaT>; Mon, 18 Feb 2002 12:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310994AbSBRR1J>; Mon, 18 Feb 2002 12:27:09 -0500
Received: from [62.245.135.174] ([62.245.135.174]:23683 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S310917AbSBRRYa>;
	Mon, 18 Feb 2002 12:24:30 -0500
Message-ID: <3C7138C7.CE24ADC5@TeraPort.de>
Date: Mon, 18 Feb 2002 18:24:23 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre8-K2-VM-24-preempt-lock i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 0-order allocation failed, followed by process murder
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/18/2002 06:24:23 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/18/2002 06:24:29 PM,
	Serialize complete at 02/18/2002 06:24:29 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 the appended 0-order alloc failure resulted in killing X and
subsequently my beloved cats (at least the screensaver cycling through
my collection of "family" pictures :-) From the time in
/var/log/messages this happend during "updatedb" (yes, I could switch
that of ...).

 The system in question is a Notebook with 320 MB and no swap. Kernel is
2.4.18-pre8 with Andreas VM-24, O(1)-K8, preempt and lock break. Running
with swap disabled improves my "interactive" experience. Of course, I am
aware that I risk OOM conditions, but according to the output there was
enough memory available in buffer/cache.

 The thing happens from arch/i383/mm/fault.c. I have added the "VM: out
of memory ..." output and a call to show_mem() just before the kill
instruction (this happened before). As the mem-info shows, there should
be plenty of memory available in buffer/cache.

 Is this of any help? Anything I should do? 

% dmesg
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
cf8dde60 c026c520 00000000 000001d2 00000000 000001d2 cff8c3c0 00104025
       ce9ab3c0 00000001 00000001 c02b747c c02b7654 000001d2 00000000
c012f556
       418e4000 c01253dc 418e4000 cff8c3c0 00000001 ce9ab3c0 c01254b5
cff8c3c0
Call Trace: [<c012f556>] [<c01253dc>] [<c01254b5>] [<c012565b>]
[<c01124db>]
   [<c0112328>] [<c0106367>] [<c0106470>] [<c0107158>]
VM: out of memory condition in do_page_fault. adress=0x418e4000,
error_code=0x06
Mem-info:
Free pages:        2472kB (     0kB HighMem)
Zone:DMA freepages:  1352kB
Zone:Normal freepages:  1120kB
Zone:HighMem freepages:     0kB
( Active: 36930, inactive: 39647, free: 618 )
2*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 1*256kB 0*512kB 1*1024kB
0*2048kB = 1352kB)
8*4kB 2*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB
0*2048kB = 1120kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:            0kB
81888 pages of RAM
0 pages of HIGHMEM
1669 reserved pages
16884 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:    30320kB
Cache memory:    87756kB
VM: killing process X

% ksymoops
Reading Oops report from the terminal
cf8dde60 c026c520 00000000 000001d2 00000000 000001d2 cff8c3c0 00104025
       ce9ab3c0 00000001 00000001 c02b747c c02b7654 000001d2 00000000
c012f556
       418e4000 c01253dc 418e4000 cff8c3c0 00000001 ce9ab3c0 c01254b5
cff8c3c0
Call Trace: [<c012f556>] [<c01253dc>] [<c01254b5>] [<c012565b>]
[<c01124db>]
   [<c0112328>] [<c0106367>] [<c0106470>] [<c0107158>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c012f556 <_alloc_pages+16/18>
Trace; c01253dc <do_anonymous_page+50/f4>
Trace; c01254b4 <do_no_page+34/17c>
Trace; c012565a <handle_mm_fault+5e/f0>
Trace; c01124da <do_page_fault+1b2/4f2>
Trace; c0112328 <do_page_fault+0/4f2>
Trace; c0106366 <restore_sigcontext+116/13c>
Trace; c0106470 <sys_sigreturn+e4/110>
Trace; c0107158 <error_code+34/40>

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
