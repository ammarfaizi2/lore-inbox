Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVDEHiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVDEHiU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVDEHdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:33:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18595 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261617AbVDEH3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:29:45 -0400
Date: Tue, 5 Apr 2005 09:29:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, stsp@aknet.ru
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050405072929.GA24560@elte.hu>
References: <20050405065544.GA21360@elte.hu> <20050405000319.4fa1d962.akpm@osdl.org> <20050405071604.GA23355@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405071604.GA23355@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
> > 
> > With nmi_watchdog=1, I got random Oopses (Unable to handle kernel 
> > paging request, not by the NMI oopser) from many processes.  It is not 
> > happend with -rc1.
> > 
> > The following change fixes this problem.
> 

> this fixed my crashes too.

spoke too soon - they still trigger even with the patch applied.

	Ingo

Unable to handle kernel paging request at virtual address f543c000
 printing eip:
c010287c
*pde = 00516067
*pte = 3543c000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c010287c>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-rc2) 
EIP is at restore_all+0x4/0x18
eax: 00000202   ebx: 009b63f9   ecx: 00000000   edx: 00000001
esi: 009b63f9   edi: 00000001   ebp: f543a000   esp: f543bfc8
ds: 007b   es: 007b   ss: 0068
Process udevd (pid: 1044, threadinfo=f543a000 task=f5412b10)
Stack: 009b63f9 00000000 000001b6 009b63f9 00000001 bf8c503c 00000005 0000007b 
       0000007b ffffff00 c01027ba 00000060 00000202 0000007b 
Call Trace:
 [<c010368c>] show_stack+0x7a/0x90
 [<c0103808>] show_registers+0x14d/0x1c5
 [<c0103a06>] die+0xf4/0x186
 [<c010f2ad>] do_page_fault+0x430/0x649
 [<c01032eb>] error_code+0x4f/0x54
Code: 00 00 3d 21 01 00 00 0f 83 1a 01 00 00 ff 14 85 00 39 40 c0 89 44 24 18 fa 8b 4d 08 66 f7 c1 ff fe 0f 85 c0 00 00 00 8b 44 24 30 <8a> 64 24 38 8a 44 24 2c 25 03 04 02 00 3d 03 04 00 00 74 0d 5b 
 printing eip:
*EIP:    0060:[<c010287c>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-rc2) 
EIP is at restore_all+0x4/0x18
eax: 00000206   ebx: 080d1502   ecx: 00000000   edx: 00000001
esi: 080ec058   edi: 080e8b6e   ebp: f5e38000   esp: f5e39fc8
ds: 007b   es: 007b   ss: 0068
Process rc.sysinit (pid: 3032, threadinfo=f5e38000 task=f5913b10)
Stack: 080d1502 bff73ff0 009c0ffc 080ec058 080e8b6e bff73fb4 000000c3 0000007b 
       0000007b ffffff00 c01027ba 00000060 00000206 0000007b 
Call Trace:
 [<c010368c>] show_stack+0x7a/0x90
 [<c0103808>] show_registers+0x14d/0x1c5
 [<c0103a06>] die+0xf4/0x186
 [<c010f2ad>] do_page_fault+0x430/0x649
 [<c01032eb>] error_code+0x4f/0x54
Code: 00 00 3d 21 01 00 00 0f 83 1a 01 00 00 ff 14 85 00 39 40 c0 89 44 24 18 fa 8b 4d 08 66 f7 c1 ff fe 0f 85 c0 00 00 00 8b 44 24 30 <8a> 64 24 38 8a 44 24 2c 25 03 04 02 00 3d 03 04 00 00 74 0d 5b 
 <6>EXT3 FS on hdb1, internal journal
cdrom: open failed.
Adding 1052216k swap on /dev/hdb2.  Priority:-1 extents:1
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
