Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265925AbUAHUdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUAHUdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:33:21 -0500
Received: from devil.servak.biz ([209.124.81.2]:14526 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S265925AbUAHUc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:32:56 -0500
Subject: Re: 2.6.1-rc2-mm1
From: Torrey Hoffman <thoffman@arnor.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <1073593346.1618.3.camel@moria.arnor.net>
References: <20040107232831.13261f76.akpm@osdl.org>
	 <1073593346.1618.3.camel@moria.arnor.net>
Content-Type: text/plain
Message-Id: <1073594795.1738.2.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Jan 2004 12:46:40 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may have spoke too soon.  Mozilla is failing to start for me on
rc2-mm1, evolution crashed when trying to send a previous edition of
this email, and the gnome-notification-applet died at startup.  These
problems didn't happen on -rc2-vanilla.

Another message from the kernel log, sometime during the above problems:
Jan  8 12:18:27 moria kernel:  <3>Debug: sleeping function called from
invalid context at mm/page_alloc.c:550
Jan  8 12:18:27 moria kernel: in_atomic():1, irqs_disabled():0
Jan  8 12:18:27 moria kernel: Call Trace:
Jan  8 12:18:27 moria kernel:  [<c012420c>] __might_sleep+0xab/0xc9
Jan  8 12:18:27 moria kernel:  [<c0146d80>] __alloc_pages+0x341/0x346
Jan  8 12:18:27 moria kernel:  [<c011ee17>] pte_alloc_one+0x20/0x56
Jan  8 12:18:27 moria kernel:  [<c0150185>] pte_alloc_map+0x4e/0x111
Jan  8 12:18:27 moria kernel:  [<c014395f>]
filemap_populate_nonblock+0x2a1/0x2ce
Jan  8 12:18:27 moria kernel:  [<c014c49c>] mark_page_accessed+0x2d/0x34
Jan  8 12:18:27 moria kernel:  [<c01525d3>] do_no_page+0x3f1/0x400
Jan  8 12:18:27 moria kernel:  [<c015280a>] handle_mm_fault+0x100/0x1aa
Jan  8 12:18:27 moria kernel:  [<c0150b01>] unmap_vmas+0xed/0x2c6
Jan  8 12:18:27 moria kernel:  [<c011f68e>] do_page_fault+0x35d/0x588
Jan  8 12:18:27 moria kernel:  [<c0121670>] scheduler_tick+0x3f/0x67c
Jan  8 12:18:27 moria kernel:  [<c011f331>] do_page_fault+0x0/0x588
Jan  8 12:18:27 moria kernel:  [<c0339163>] error_code+0x2f/0x38
Jan  8 12:18:27 moria kernel:  [<c033007b>] fn_hash_insert+0x3c0/0x45b
Jan  8 12:18:27 moria kernel:

I'm going back to -rc2-vanilla for now...


On Thu, 2004-01-08 at 12:22, Torrey Hoffman wrote:
> On Wed, 2004-01-07 at 23:28, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc2/2.6.1-rc2-mm1/
> ...
> 
> > - There's a fix for the Radeon framebuffer card here which we're a bit
> >   wobbly about.  if you have such a thing, please send a report.
> 
> Boots and runs ok so far on a Radeon 7500 All-In-Wonder, ABIT Max-3 MB
> with the 875 chipset, P4 800 with HT.  
> 
> Ordinary -rc2 also worked, except I got a bunch of garbage on the screen
> when the penguins were displayed.  That's fixed now.  However, I got
> these during boot...  (Ordinary -rc2 didn't have this, IIRC.)
> 
> Unable to handle kernel paging request at virtual address 284c2029
>  printing eip:
> c01741b4
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> CPU:    0
> EIP:    0060:[<c01741b4>]    Not tainted VLI
> EFLAGS: 00210202
> EIP is at poll_freewait+0x10/0x43
> eax: 00000000   ebx: e8838008   ecx: 00200202   edx: c039fa90
> esi: e8838008   edi: 284c2025   ebp: ecd17f68   esp: ecd17f5c
> ds: 007b   es: 007b   ss: 0068
> Process mozilla-bin (pid: 1570, threadinfo=ecd16000 task=e8ffd980)
> Stack: 00000000 f13bcd28 f13bcd20 ecd17fbc c0174ea4 ecd17fa0 f13bcd20
> ecd17fa0
>        7fffffff 00000001 ecd16000 41a3d7b8 f13bcd28 00000000 f13bcd20
> 00000000
>        00000001 c01741e7 e8838000 00000000 f7557d00 41a3d7b0 00000000
> 406f5238
> Call Trace:
>  [<c0174ea4>] sys_poll+0x23e/0x282
>  [<c01741e7>] __pollwait+0x0/0xac
>  [<c0338682>] sysenter_past_esp+0x43/0x65
>  
> Code: 89 e5 8b 45 08 c7 00 e7 41 17 c0 c7 40 08 00 00 00 00 c7 40 04 00
> 00 00 00 5d c3 55 89 e5 57 56 8b 45 08 53 8b 78 04 85 ff 74 2e <8b> 5f
> 04 8d 77 08 83 eb 1c 8d 53 04 8b 43 18 e8 fb 04 fb ff 8b
> Badness in unblank_screen at drivers/char/vt.c:2793
> Call Trace:
>  [<c025397a>] unblank_screen+0x127/0x12c
>  [<c011f06c>] bust_spinlocks+0x2c/0x54
>  [<c010d805>] die+0xb1/0x11e
>  [<c011f522>] do_page_fault+0x1f1/0x588
>  [<c012204f>] schedule+0x39d/0x6b2
>  [<c0130348>] schedule_timeout+0xb4/0xb6
>  [<c011f331>] do_page_fault+0x0/0x588
>  [<c0339163>] error_code+0x2f/0x38
>  [<c01741b4>] poll_freewait+0x10/0x43
>  [<c0174ea4>] sys_poll+0x23e/0x282
>  [<c01741e7>] __pollwait+0x0/0xac
>  [<c0338682>] sysenter_past_esp+0x43/0x65
>  
>  <1>Unable to handle kernel paging request at virtual address 32972029
>  printing eip:
> c01741b4
> *pde = 00000000
> Oops: 0000 [#2]
> PREEMPT SMP
> CPU:    0
> EIP:    0060:[<c01741b4>]    Not tainted VLI
> EFLAGS: 00010202
> EIP is at poll_freewait+0x10/0x43
> eax: 00000000   ebx: e9383008   ecx: 00000202   edx: c039fa90
> esi: e9383008   edi: 32972025   ebp: ecd13f68   esp: ecd13f5c
> ds: 007b   es: 007b   ss: 0068
> Process notification-ar (pid: 1553, threadinfo=ecd12000 task=f260d340)
> Stack: 00000000 f1083c08 f1083c00 ecd13fbc c0174ea4 ecd13fa0 f1083c00
> ecd13fa0
>        7fffffff 00000001 ecd12000 080a72e0 f1083c08 00000000 f1083c00
> 00000000
>        00000001 c01741e7 e9383000 00000000 e962fda0 080a7288 40141670
> 401a5238
> Call Trace:
>  [<c0174ea4>] sys_poll+0x23e/0x282
>  [<c01741e7>] __pollwait+0x0/0xac
>  [<c0338682>] sysenter_past_esp+0x43/0x65
>  
> Code: 89 e5 8b 45 08 c7 00 e7 41 17 c0 c7 40 08 00 00 00 00 c7 40 04 00
> 00 00 00 5d c3 55 89 e5 57 56 8b 45 08 53 8b 78 04 85 ff 74 2e <8b> 5f
> 04 8d 77 08 83 eb 1c 8d 53 04 8b 43 18 e8 fb 04 fb ff 8b
> Badness in unblank_screen at drivers/char/vt.c:2793
> Call Trace:
>  [<c025397a>] unblank_screen+0x127/0x12c
>  [<c011f06c>] bust_spinlocks+0x2c/0x54
>  [<c010d805>] die+0xb1/0x11e
>  [<c011f522>] do_page_fault+0x1f1/0x588
>  [<c012204f>] schedule+0x39d/0x6b2
>  [<c02e21cc>] sock_poll+0x29/0x30
>  [<c011f331>] do_page_fault+0x0/0x588
>  [<c0339163>] error_code+0x2f/0x38
>  [<c01741b4>] poll_freewait+0x10/0x43
>  [<c0174ea4>] sys_poll+0x23e/0x282
>  [<c01741e7>] __pollwait+0x0/0xac
>  [<c0338682>] sysenter_past_esp+0x43/0x65
>  
-- 
Torrey Hoffman <thoffman@arnor.net>

