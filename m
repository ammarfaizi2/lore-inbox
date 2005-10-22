Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVJVKUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVJVKUH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 06:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVJVKUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 06:20:06 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:20158 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932211AbVJVKUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 06:20:05 -0400
Date: Sat, 22 Oct 2005 12:20:02 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Oops in __d_lookup()
Message-ID: <20051022102002.GB21656@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I have got the following Oops under 2.6.14-rc4 and -rc5 - it is in
the updatedb process, altough I have seen that also in nfsd (both running
over XFS volumes mainly, altough there are few ext3 volumes as well.
The server is 4-opteron HP DL-585.

Unable to handle kernel paging request at 00000000ffffffff RIP:
<ffffffff80199310>{__d_lookup+128}
PGD 251690067 PUD 0
Oops: 0000 [1] SMP
CPU 2
Modules linked in: ide_cd cdrom
Pid: 27577, comm: updatedb Not tainted 2.6.14-rc5acpi #1
RIP: 0010:[<ffffffff80199310>] <ffffffff80199310>{__d_lookup+128}
RSP: 0018:ffff810623c0bc88  EFLAGS: 00010206
RAX: 00000000ffffffff RBX: 00000000ffffffff RCX: 0000000000000016
RDX: 0000027ec3780cd0 RSI: 00000000002f86ab RDI: ffff810491896a28
RBP: ffff810214346170 R08: 0000000000000007 R09: 0000000000000007
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000de1db4d3
R13: ffff810491896a28 R14: ffff810623c0bd28 R15: 000000000000001a
FS:  00002aaaaae064c0(0000) GS:ffffffff805da900(0000) knlGS:000000005557daa0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000ffffffff CR3: 0000000399392000 CR4: 00000000000006e0
Process updatedb (pid: 27577, threadinfo ffff810623c0a000, task ffff8101e801a9c0)
Stack: 0000000000000296 ffffffff802a9951 0000000000000000 ffff810435253000
       0000001a00000296 0000000000000000 ffff810623c0bd38 ffff810623c0be68
       ffff810623c0bd28 ffff81067f70f9c8
Call Trace:<ffffffff802a9951>{__up_read+33} <ffffffff8018dfb1>{do_lookup+49}
       <ffffffff8018ea9d>{__link_path_walk+2653} <ffffffff8025da4d>{xfs_dir2_block_getdents+589}
       <ffffffff8018f022>{link_path_walk+178} <ffffffff801632fa>{kmem_cache_alloc+122}
       <ffffffff8018f55e>{path_lookup+446} <ffffffff8018f71e>{__user_walk+62}
       <ffffffff801894b6>{vfs_lstat+38} <ffffffff801898ff>{sys_newlstat+31}
       <ffffffff8010db56>{system_call+126}

Code: 48 8b 03 0f 18 08 48 8d 6b e8 44 39 65 30 0f 85 8c 00 00 00
RIP <ffffffff80199310>{__d_lookup+128} RSP <ffff810623c0bc88>
CR2: 00000000ffffffff

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
