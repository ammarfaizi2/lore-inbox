Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbUKWAZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbUKWAZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbUKWAXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:23:55 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:53715 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262477AbUKWAUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:20:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-mm3 (oops on AMD64)
Date: Tue, 23 Nov 2004 01:21:58 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20041121223929.40e038b2.akpm@osdl.org>
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411230121.58558.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 of November 2004 07:39, Andrew Morton wrote:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/
> 
> - It's time to shut things down for a 2.6.10 release now.  I'll do another
>   pass through the -mm lineup for things which should go into 2.6.10.  
> 
>   If anyone has patches in -mm which they think should go into 2.6.10 please
>   let me know.  (particularly ppc/ppc64).  The v4l patches certainly look 
like
>   they need to go in.
> 
> - I seem to have accumulated several tens of bug reports, most of which are
>   post-2.6.9 and a few of which predate 2.6.9.  I'll send out another round 
of
>   emails regarding that shortly.  Please let's focus on these things so we 
can
>   get a good 2.6.10 out.
> 
> - There's a pretty big revamp of the filesystem quota code in here.  If you
>   use quotas, please test.

I get the following oops from this kernel on AMD64 on system shutdown (I use 
quotas ;-)):

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff80199628>{invalidate_bdev+56}
PML4 11369067 PGD 16621067 PMD 0
Oops: 0000 [1]
CPU 0
Modules linked in: usbserial parport_pc lp parport ipv6 joydev sg st sd_mod 
sr_mod scsi_mod ide_cd cdrom ohci1394 cpufreq_userspace ieee1394d
Pid: 20470, comm: umount Not tainted 2.6.10-rc2-mm3
RIP: 0010:[<ffffffff80199628>] <ffffffff80199628>{invalidate_bdev+56}
RSP: 0018:ffff81001d903e28  EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000007 RCX: ffff8100018bbe68
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff81001f0cc388
RBP: 0000000000000008 R08: ffff81001d903e78 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffff81001d903ee8 R14: ffff810001ada6d0 R15: ffff810001ada660
FS:  00002aaaaade2700(0000) GS:ffffffff80557580(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000001b91a000 CR4: 00000000000006e0
Process umount (pid: 20470, threadinfo ffff81001d902000, task 
ffff81001fc8a8c0)
Stack: 0000000000000001 ffff810001ada4d8 0000000000000002 ffffffff801d9d57
       0000000000000001 0000000000000004 0000000000000000 ffff810001ada6f8
       0000000000000001 ffffffff00000000
Call Trace:<ffffffff801d9d57>{vfs_quota_off+1223} 
<ffffffff801bf52c>{sys_umount+780}
       <ffffffff801b5c43>{dput+35} <ffffffff8019749d>{__fput+237}
       <ffffffff8019394e>{filp_close+126} <ffffffff80193ad4>{sys_close+356}
       <ffffffff8010eba2>{system_call+126}

Code: 49 8b 44 24 08 5b 5d 41 5c 48 8b b8 a0 01 00 00 e9 83 db fd
RIP <ffffffff80199628>{invalidate_bdev+56} RSP <ffff81001d903e28>
CR2: 0000000000000008

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
