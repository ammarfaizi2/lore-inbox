Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTA3NVk>; Thu, 30 Jan 2003 08:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbTA3NVk>; Thu, 30 Jan 2003 08:21:40 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:49412 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267499AbTA3NVh>; Thu, 30 Jan 2003 08:21:37 -0500
Date: Thu, 30 Jan 2003 14:30:51 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid-0/reiserfs problem; file system not recognized after reboot
Message-ID: <20030130133051.GA12400@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030130124224.GA8844@middle.of.nowhere> <20030130130041.GA21637@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030130130041.GA21637@codemonkey.org.uk>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@codemonkey.org.uk>
Date: Thu, Jan 30, 2003 at 01:00:41PM +0000
> On Thu, Jan 30, 2003 at 01:42:24PM +0100, Jurriaan wrote:
> 
>  > umount /dev/md0
>  > umount /dev/md1
>  > raidstop /dev/md0
>  > raidstop /dev/md1
>  > dd if=/dev/zero of=/dev/hdi bs=512 count=1
>  > dd if=/dev/zero of=/dev/hdk bs=512 count=1
>  > fdisk /dev/hdi < /root/fdisk.in
>  > fdisk /dev/hdk < /root/fdisk.in
>  > mkraid --really-force /dev/md0
>  > mkraid --really-force /dev/md1
> 
> meant to do raidstart here ?
> 
I was switching these disks around on a number of computers, and
altering partition tables, so I needed it. If I use raidstart, I get
interesting results:

raidstart /dev/md0 works without any trouble.
raidstart /dev/md1 gives lots of debugging info, and doesn't work. I
can't understand why it says 'hdi appears to be on the same physical
disk as hdi2' - and why it is referring to hdi at all.

Jan 30 14:27:44 middle kernel:  [events: 00000004]
Jan 30 14:27:44 middle last message repeated 2 times
Jan 30 14:27:44 middle kernel: md: autorun ...
Jan 30 14:27:44 middle kernel: md: considering hdk ...
Jan 30 14:27:44 middle kernel: md:  adding hdk ...
Jan 30 14:27:44 middle kernel: md:  adding hdi ...
Jan 30 14:27:44 middle kernel: md:  adding hdi2 ...
Jan 30 14:27:44 middle kernel: md: created md1
Jan 30 14:27:44 middle kernel: md: bind<hdi2,1>
Jan 30 14:27:44 middle kernel: md1: WARNING: hdi appears to be on the same physical disk as hdi2. True
Jan 30 14:27:44 middle kernel:      protection against single-disk failure might be compromised.
Jan 30 14:27:44 middle kernel: md: bind<hdi,2>
Jan 30 14:27:44 middle kernel: md: bind<hdk,3>
Jan 30 14:27:44 middle kernel: md: running: <hdk><hdi><hdi2>
Jan 30 14:27:44 middle kernel: md: hdk's event counter: 00000004
Jan 30 14:27:44 middle kernel: md: hdi's event counter: 00000004
Jan 30 14:27:44 middle kernel: md: hdi2's event counter: 00000004
Jan 30 14:27:44 middle kernel: md: device name has changed from hdi to hdi2 since last import!
Jan 30 14:27:44 middle kernel: md: bug in file md.c, line 1486
Jan 30 14:27:44 middle kernel: 
Jan 30 14:27:44 middle kernel: md:^I**********************************
Jan 30 14:27:44 middle kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
Jan 30 14:27:44 middle kernel: md:^I**********************************
Jan 30 14:27:44 middle kernel: md1: <hdk><hdi><hdi2> array superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<0f7f1b56.4311bdef.8b16525e.373d40ed> CT:3e391dd9
Jan 30 14:27:44 middle kernel: md:     L0 S07590656 ND:2 RD:2 md1 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e392732 ST:1 AD:2 WD:2 FD:0 SD:0 CSUM:3af6d4c1 E:00000004
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi2(56,2),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdk: O:hdk, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<0f7f1b56.4311bdef.8b16525e.373d40ed> CT:3e391dd9
Jan 30 14:27:44 middle kernel: md:     L0 S07590656 ND:2 RD:2 md1 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e392732 ST:1 AD:2 WD:2 FD:0 SD:0 CSUM:3af6d4c1 E:00000004
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi(56,0),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdi: O:hdi, SZ:00000000 F:0 DN:0 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<0f7f1b56.4311bdef.8b16525e.373d40ed> CT:3e391dd9
Jan 30 14:27:44 middle kernel: md:     L0 S07590656 ND:2 RD:2 md1 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e392732 ST:1 AD:2 WD:2 FD:0 SD:0 CSUM:3af6d4be E:00000004
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi(56,0),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:0,hdi(56,0),R:0,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdi2: O:hdi, SZ:00000000 F:0 DN:0 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<0f7f1b56.4311bdef.8b16525e.373d40ed> CT:3e391dd9
Jan 30 14:27:44 middle kernel: md:     L0 S07590656 ND:2 RD:2 md1 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e392732 ST:1 AD:2 WD:2 FD:0 SD:0 CSUM:3af6d4be E:00000004
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi(56,0),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:0,hdi2(56,2),R:0,S:6>
Jan 30 14:27:44 middle kernel: md0: <hdk1><hdi1> array superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<dd3eda4f.ad086b2f.8aef8b90.65d86c59> CT:3e391dd4
Jan 30 14:27:44 middle kernel: md:     L0 S70559872 ND:2 RD:2 md0 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e39280d ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:a4e27bf0 E:00000007
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi1(56,1),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdk1: O:hdk1, SZ:70559872 F:0 DN:1 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<dd3eda4f.ad086b2f.8aef8b90.65d86c59> CT:3e391dd4
Jan 30 14:27:44 middle kernel: md:     L0 S70559872 ND:2 RD:2 md0 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e39280d ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:a4e27bf3 E:00000007
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi1(56,1),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdi1: O:hdi1, SZ:70559872 F:0 DN:0 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<dd3eda4f.ad086b2f.8aef8b90.65d86c59> CT:3e391dd4
Jan 30 14:27:44 middle kernel: md:     L0 S70559872 ND:2 RD:2 md0 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e39280d ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:a4e27bf0 E:00000007
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi1(56,1),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:0,hdi1(56,1),R:0,S:6>
Jan 30 14:27:44 middle kernel: md:^I**********************************
Jan 30 14:27:44 middle kernel: 
Jan 30 14:27:44 middle kernel: md: bug in file md.c, line 1650
Jan 30 14:27:44 middle kernel: 
Jan 30 14:27:44 middle kernel: md:^I**********************************
Jan 30 14:27:44 middle kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
Jan 30 14:27:44 middle kernel: md:^I**********************************
Jan 30 14:27:44 middle kernel: md1: <hdk><hdi><hdi2> array superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<0f7f1b56.4311bdef.8b16525e.373d40ed> CT:3e391dd9
Jan 30 14:27:44 middle kernel: md:     L0 S07590656 ND:2 RD:2 md1 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e392732 ST:1 AD:2 WD:2 FD:0 SD:0 CSUM:3af6d4c1 E:00000004
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi2(56,2),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdk: O:hdk, SZ:00000000 F:0 DN:1 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<0f7f1b56.4311bdef.8b16525e.373d40ed> CT:3e391dd9
Jan 30 14:27:44 middle kernel: md:     L0 S07590656 ND:2 RD:2 md1 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e392732 ST:1 AD:2 WD:2 FD:0 SD:0 CSUM:3af6d4c1 E:00000004
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi(56,0),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdi: O:hdi, SZ:00000000 F:0 DN:0 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<0f7f1b56.4311bdef.8b16525e.373d40ed> CT:3e391dd9
Jan 30 14:27:44 middle kernel: md:     L0 S07590656 ND:2 RD:2 md1 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e392732 ST:1 AD:2 WD:2 FD:0 SD:0 CSUM:3af6d4be E:00000004
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi(56,0),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:0,hdi(56,0),R:0,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdi2: O:hdi, SZ:00000000 F:0 DN:0 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<0f7f1b56.4311bdef.8b16525e.373d40ed> CT:3e391dd9
Jan 30 14:27:44 middle kernel: md:     L0 S07590656 ND:2 RD:2 md1 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e392732 ST:1 AD:2 WD:2 FD:0 SD:0 CSUM:3af6d4be E:00000004
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi(56,0),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk(57,0),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:0,hdi2(56,2),R:0,S:6>
Jan 30 14:27:44 middle kernel: md0: <hdk1><hdi1> array superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<dd3eda4f.ad086b2f.8aef8b90.65d86c59> CT:3e391dd4
Jan 30 14:27:44 middle kernel: md:     L0 S70559872 ND:2 RD:2 md0 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e39280d ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:a4e27bf0 E:00000007
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi1(56,1),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdk1: O:hdk1, SZ:70559872 F:0 DN:1 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<dd3eda4f.ad086b2f.8aef8b90.65d86c59> CT:3e391dd4
Jan 30 14:27:44 middle kernel: md:     L0 S70559872 ND:2 RD:2 md0 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e39280d ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:a4e27bf3 E:00000007
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi1(56,1),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md: rdev hdi1: O:hdi1, SZ:70559872 F:0 DN:0 <6>md: rdev superblock:
Jan 30 14:27:44 middle kernel: md:  SB: (V:0.90.0) ID:<dd3eda4f.ad086b2f.8aef8b90.65d86c59> CT:3e391dd4
Jan 30 14:27:44 middle kernel: md:     L0 S70559872 ND:2 RD:2 md0 LO:0 CS:65536
Jan 30 14:27:44 middle kernel: md:     UT:3e39280d ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:a4e27bf0 E:00000007
Jan 30 14:27:44 middle kernel:      D  0:  DISK<N:0,hdi1(56,1),R:0,S:6>
Jan 30 14:27:44 middle kernel:      D  1:  DISK<N:1,hdk1(57,1),R:1,S:6>
Jan 30 14:27:44 middle kernel: md:     THIS:  DISK<N:0,hdi1(56,1),R:0,S:6>
Jan 30 14:27:44 middle kernel: md:^I**********************************
Jan 30 14:27:44 middle kernel: 
Jan 30 14:27:44 middle kernel: md :do_md_run() returned -22
Jan 30 14:27:44 middle kernel: md: md1 stopped.
Jan 30 14:27:44 middle kernel: md: unbind<hdk,2>
Jan 30 14:27:44 middle kernel: md: export_rdev(hdk)
Jan 30 14:27:44 middle kernel: md: unbind<hdi,1>
Jan 30 14:27:44 middle kernel: md: export_rdev(hdi)
Jan 30 14:27:44 middle kernel: md: unbind<hdi2,0>
Jan 30 14:27:44 middle kernel: md: export_rdev(hdi2)
Jan 30 14:27:44 middle kernel: md: ... autorun DONE.
>  > yes | mkreiserfs /dev/md0
>  > yes | mkreiserfs /dev/md
> 
> and shouldnt that be md1 ?
Yes, that's a typo in the mail (not in the script, I could mount it just
fine).

Thanks,
Jurriaan
-- 
I'll never be a blue-eyed boy although my eyes are blue
	The Oysterband - The generals are born again
GNU/Linux 2.4.21-pre3-ac5 SMP/ReiserFS 1x2824 bogomips load av: 0.12 0.05 0.03
