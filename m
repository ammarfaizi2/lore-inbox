Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUFHBUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUFHBUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 21:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUFHBUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 21:20:54 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:21521 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265148AbUFHBUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 21:20:49 -0400
To: John Bradford <john@grabjohn.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Michael Brennan <mbrennan@ezrs.com>, linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1086656992@astro.swin.edu.au>
Subject: Re:  why swap at all?
In-reply-to: <200406010910.i519AWsm000213@81-2-122-30.bradfords.org.uk>
References: <40BB88B5.8080300@ezrs.com> <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk> <40BBB5F7.1010407@yahoo.com.au> <200406010834.i518Y1cT000414@81-2-122-30.bradfords.org.uk> <20040601083206.GI2093@holomorphy.com> <200406010850.i518o8PD000134@81-2-122-30.bradfords.org.uk> <20040601085456.GJ2093@holomorphy.com> <200406010910.i519AWsm000213@81-2-122-30.bradfords.org.uk>
X-Face: m+g#A-,3D0}Ygy5KUD`Hckr=I9Au;w${NzE;Iz!6bOPqeX^]}KGt=l~r!8X|W~qv'`Ph4dZczj*obWD25|2+/a5.$#s23k"0$ekRhi,{cP,CUk=}qJ/I1acc
Message-ID: <slrn-0.9.7.4-20652-23232-200406081109-tc@hexane.ssi.swin.edu.au>
Date: Tue, 8 Jun 2004 11:18:49 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> said on Tue, 1 Jun 2004 10:10:32 +0100:
> Quote from William Lee Irwin III <wli@holomorphy.com>:
> > Quote from William Lee Irwin III <wli@holomorphy.com>:
> > > to reproduce these 'swap increases performance even with untouched RAM'
> > > claims.
> > 
> > Because ZONE_DMA, the lower 16MB is not all of RAM.
> 
> Ah, OK, this isn't really my area of expertise so maybe this is a stupid, (for
> LKML), question, but can we only migrate data from low RAM via swap!?
> 
> Also, surely this is only relevant to X86 architectures?


I just got an interesting problem - possibly (or not?) related to
this:

I have my laptop with 256MB of RAM, running 2.4.25-pre7, uptime 48
days. Every morning, I come in and have to wait 2 minutes while
everything comes back into RAM, after the daily slocate. So I did a
swapoff -a, and it failed despite all the applications and cache and
tmpfs adding up to far less than 256MB (more like 128).

I closed mozilla, which let me do a swapoff -a.

All was well for a few days, but then thismorning, my partitions were
mounted ro, and an oops was in syslog at the same time as all the
slocate work:

Jun  8 07:55:24 scuzzie kernel: VM: killing process xemacs
Jun  8 07:56:17 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:56:17 scuzzie kernel: VM: killing process mailoops
Jun  8 07:57:30 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d0/0)
Jun  8 07:57:34 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:35 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:35 scuzzie kernel: VM: killing process sh
Jun  8 07:57:35 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:35 scuzzie kernel: VM: killing process sh
Jun  8 07:57:38 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:38 scuzzie kernel: VM: killing process ssh-agent
Jun  8 07:57:38 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:38 scuzzie kernel: VM: killing process gunzip
Jun  8 07:57:40 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:40 scuzzie kernel: VM: killing process gunzip
Jun  8 07:57:40 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:40 scuzzie kernel: VM: killing process gunzip
Jun  8 07:57:41 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d0/0)
Jun  8 07:57:41 scuzzie kernel: ERROR: (device ide0(3,5)): txAbortCommit
Jun  8 07:57:41 scuzzie kernel: BUG at jfs_txnmgr.c:509 assert(tblk->next == 0)
Jun  8 07:57:41 scuzzie kernel: kernel BUG at jfs_txnmgr.c:509!
Jun  8 07:57:41 scuzzie kernel: invalid operand: 0000
Jun  8 07:57:41 scuzzie kernel: CPU:    0
Jun  8 07:57:41 scuzzie kernel: EIP:    0010:[txEnd+235/256]    Not tainted
Jun  8 07:57:41 scuzzie kernel: EFLAGS: 00010282
Jun  8 07:57:41 scuzzie kernel: eax: 00000033   ebx: d0811c98   ecx: c12dc000   edx: cd9f5f7c
Jun  8 07:57:41 scuzzie kernel: esi: 00000102   edi: cfec1d60   ebp: cf4eb000   esp: c12ddf18
Jun  8 07:57:41 scuzzie kernel: ds: 0018   es: 0018   ss: 0018
Jun  8 07:57:41 scuzzie kernel: Process keventd (pid: 2, stackpage=c12dd000)
Jun  8 07:57:41 scuzzie kernel: Stack: c028ed43 c028f190 000001fd c028f180 fffffffb 00000102 cf4eb05c c017db9e 
Jun  8 07:57:41 scuzzie kernel:        00000102 00000001 c12ddf54 00000000 00000000 c35c5220 c017dc0e c35c5220 
Jun  8 07:57:41 scuzzie kernel:        00000000 00000001 c014d3f2 c35c5220 00000000 00000003 c12ddf88 c12ddf88 
Jun  8 07:57:41 scuzzie kernel: Call Trace:    [jfs_commit_inode+222/256] [jfs_write_inode+78/96] [try_to_sync_unused_inodes+466/480] [__run_task_queue+90/112] [cont
ext_thread+442/448]
Jun  8 07:57:41 scuzzie kernel:   [context_thread+0/448] [rest_init+0/64] [arch_kernel_thread+46/64] [context_thread+0/448]
Jun  8 07:57:41 scuzzie kernel: 
Jun  8 07:57:41 scuzzie kernel: Code: 0f 0b fd 01 90 f1 28 c0 e9 71 ff ff ff 90 8d b4 26 00 00 00 
Jun  8 07:57:41 scuzzie kernel:  <5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:41 scuzzie kernel: VM: killing process gunzip
Jun  8 07:57:49 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun  8 07:57:49 scuzzie kernel: VM: killing process mozilla-bin
Jun  8 07:57:49 scuzzie kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Jun  8 07:58:09 scuzzie wwwoffles[25878]: Cannot make a lock file for 'http/www.bom.gov.au/LkdPT+cpeS73Lf-picjpvUw' [Read-only file system].
Jun  8 07:58:58 scuzzie anacron[16529]: Job `cron.weekly' terminated (exit status: 1) (mailing output)
Jun  8 07:58:59 scuzzie modprobe: modprobe: cannot create /var/log/ksymoops/20040608.log Read-only file system
Jun  8 07:58:59 scuzzie modprobe: modprobe: cannot create /var/log/ksymoops/20040608.log Read-only file system
Jun  8 07:58:59 scuzzie anacron[16529]: Tried to mail output of job `cron.weekly', but mailer process (/usr/sbin/sendmail) exited with ststus 1
Jun  8 07:58:59 scuzzie anacron[16529]: Normal exit (2 jobs run)



So OOM - but why? The cache was registering 65MB used.
24353,23> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  262647808 256618496  6029312        0  4820992 67239936
Swap:        0        0        0
MemTotal:       256492 kB
MemFree:          5888 kB
MemShared:           0 kB
Buffers:          4708 kB
Cached:          65664 kB
SwapCached:          0 kB
Active:          77944 kB
Inactive:       142308 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256492 kB
LowFree:          5888 kB
SwapTotal:           0 kB
SwapFree:            0 kB

Why was it so eager to kill applications, and not reclaim some of that
swap space? Is this a problem that is known on 2.4, and can't be fixed
(I can't use 2.6 on my laptop yet, far too many problems to even
start - eg the suspend to ram on APM thread).

Is there another output of a /proc file you want? I'll try not to get
the urge to use/reboot the box in the meantime.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Anyone seeking the "Relativistic Quantum Mechanics" soft option
course, may wish to leave now. -- Intro lecture to RQM
