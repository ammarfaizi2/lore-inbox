Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284469AbRLXG5d>; Mon, 24 Dec 2001 01:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284472AbRLXG5Y>; Mon, 24 Dec 2001 01:57:24 -0500
Received: from bof.de ([195.4.223.10]:19729 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S284469AbRLXG5F>;
	Mon, 24 Dec 2001 01:57:05 -0500
Date: Mon, 24 Dec 2001 08:03:06 +0100
From: Patrick Schaaf <bof@bof.de>
To: linux-kernel@vger.kernel.org
Subject: RAID15 cannot raidhotremove
Message-ID: <20011224080306.I14419@oknodo.bof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While playing with a RAID15 setup, I attempt to remove one of the
partitions of one mirror pair. The operation fails, telling me the
drive were busy, and it triggers a bug message from the MD code,
together with a RAID state printout.

The command I used was

	raidhotremove /dev/md0 /dev/sdi2

See below for the kernel messages.

Kernel is 2.4.17-rc2, with raidtools2 of Debian woody.

Is this a genuine bug, or is my thinking incorrect? I want to simulate failure
of one drive. The alternative is removing the physical drive - is it likely
to work, or is there a general problem in this area?

Please Cc: me on replies, I'm not subscribed to linux-kernel, and the
archives lag by one day.

best regards
  Patrick

Dec 24 07:49:33 cdr kernel: md: trying to remove sdi2 from md0 ... 
Dec 24 07:49:33 cdr kernel: md: bug in file md.c, line 2334
Dec 24 07:49:33 cdr kernel: 
Dec 24 07:49:33 cdr kernel: md:^I**********************************
Dec 24 07:49:33 cdr kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
Dec 24 07:49:33 cdr kernel: md:^I**********************************
Dec 24 07:49:33 cdr kernel: md9: <md11><md10> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<f42c4b20.51b444eb.121d4232.118441fa> CT:3c25cfc5
Dec 24 07:49:33 cdr kernel: md:     L1 S272814912 ND:2 RD:2 md9 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c25cfc5 ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:5f1626f7 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md10(9,10),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md11(9,11),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,md11(9,11),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md11: O:md11, SZ:272814912 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<f42c4b20.51b444eb.121d4232.118441fa> CT:3c25cfc5
Dec 24 07:49:33 cdr kernel: md:     L1 S272814912 ND:2 RD:2 md9 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c25cfc5 ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:9b3bf721 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md10(9,10),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md11(9,11),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,md11(9,11),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md10: O:md10, SZ:272814912 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<f42c4b20.51b444eb.121d4232.118441fa> CT:3c25cfc5
Dec 24 07:49:33 cdr kernel: md:     L1 S272814912 ND:2 RD:2 md9 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c25cfc5 ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:9b3bf71e E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md10(9,10),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md11(9,11),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,md10(9,10),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md11: <sdp3><sdo3><sdn3><sdm3><sdl3><sdk3><sdj3><sdi3> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:0d043048 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdp3: O:sdp3, SZ:38973568 F:0 DN:7 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:4929ecad E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdo3: O:sdo3, SZ:38973568 F:0 DN:6 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:4929ec9b E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdn3: O:sdn3, SZ:38973568 F:0 DN:5 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:4929ec89 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdm3: O:sdm3, SZ:38973568 F:0 DN:4 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:4929ec77 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdl3: O:sdl3, SZ:38973568 F:0 DN:3 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:4929ec65 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdk3: O:sdk3, SZ:38973568 F:0 DN:2 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:4929ec53 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdj3: O:sdj3, SZ:38973568 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:4929ec41 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdi3: O:sdi3, SZ:38973568 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e9b10f1b.9ad1f8f4.d2476fde.ce93f4aa> CT:3c25bc18
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md11 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc18 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:4929ec2f E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj3(8,147),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdk3(8,163),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdl3(8,179),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sdm3(8,195),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdn3(8,211),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdo3(8,227),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdp3(8,243),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sdi3(8,131),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md10: <sdh3><sdg3><sdf3><sde3><sdd3><sdc3><sdb3><sda3> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:5b1a5e3c E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdh3: O:sdh3, SZ:38973568 F:0 DN:7 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:97401a99 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdg3: O:sdg3, SZ:38973568 F:0 DN:6 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:97401a87 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdf3: O:sdf3, SZ:38973568 F:0 DN:5 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:97401a75 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sde3: O:sde3, SZ:38973568 F:0 DN:4 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:97401a63 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdd3: O:sdd3, SZ:38973568 F:0 DN:3 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:97401a51 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdc3: O:sdc3, SZ:38973568 F:0 DN:2 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:97401a3f E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdb3: O:sdb3, SZ:38973568 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:97401a2d E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sda3: O:sda3, SZ:38973568 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<0a1856ca.83a0a009.df4ac820.0670e023> CT:3c25bc10
Dec 24 07:49:33 cdr kernel: md:     L5 S38973568 ND:8 RD:8 md10 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c25bc10 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:97401a1b E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdb3(8,19),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,sdc3(8,35),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,sdd3(8,51),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,sde3(8,67),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,sdf3(8,83),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,sdg3(8,99),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,sdh3(8,115),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sda3(8,3),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md8: <md7><md6><md5><md4><md3><md2><md1><md0> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:45a344b5 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md7: O:md7, SZ:38957440 F:0 DN:7 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:81c6e7ba E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md6: O:md6, SZ:38957440 F:0 DN:6 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:81c6e7b7 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md5: O:md5, SZ:38957440 F:0 DN:5 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:81c6e7b4 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md4: O:md4, SZ:38957440 F:0 DN:4 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:81c6e7b1 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md3: O:md3, SZ:38957440 F:0 DN:3 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:81c6e7ae E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md2: O:md2, SZ:38957440 F:0 DN:2 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:81c6e7ab E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md1: O:md1, SZ:38957440 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:81c6e7a8 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev md0: O:md0, SZ:38957440 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<4f25c8d6.600a804a.d4b3ea74.da1bac73> CT:3c23a2b8
Dec 24 07:49:33 cdr kernel: md:     L5 S38957440 ND:8 RD:8 md8 LO:0 CS:131072
Dec 24 07:49:33 cdr kernel: md:     UT:3c23a2b8 ST:0 AD:8 WD:8 FD:0 SD:0 CSUM:81c6e7a5 E:00000001
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,md1(9,1),R:1,S:6>
Dec 24 07:49:33 cdr kernel:      D  2:  DISK<N:2,md2(9,2),R:2,S:6>
Dec 24 07:49:33 cdr kernel:      D  3:  DISK<N:3,md3(9,3),R:3,S:6>
Dec 24 07:49:33 cdr kernel:      D  4:  DISK<N:4,md4(9,4),R:4,S:6>
Dec 24 07:49:33 cdr kernel:      D  5:  DISK<N:5,md5(9,5),R:5,S:6>
Dec 24 07:49:33 cdr kernel:      D  6:  DISK<N:6,md6(9,6),R:6,S:6>
Dec 24 07:49:33 cdr kernel:      D  7:  DISK<N:7,md7(9,7),R:7,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,md0(9,0),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md0: <sdi2><sda2> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<1fbcaadd.209fd190.96032c01.80864e70> CT:3c231711
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md0 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:7aaa1057 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda2(8,2),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdi2(8,130),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdi2(8,130),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdi2: O:sdi2, SZ:38957504 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<1fbcaadd.209fd190.96032c01.80864e70> CT:3c231711
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md0 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:7aaa10a5 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda2(8,2),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdi2(8,130),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdi2(8,130),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sda2: O:sda2, SZ:38957504 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<1fbcaadd.209fd190.96032c01.80864e70> CT:3c231711
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md0 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:7aaa1023 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sda2(8,2),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdi2(8,130),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sda2(8,2),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md1: <sdj2><sdb2> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e8ace778.846c792d.5f76aa54.9614e530> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md1 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:86690a11 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdb2(8,18),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj2(8,146),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdj2(8,146),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdj2: O:sdj2, SZ:38957504 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e8ace778.846c792d.5f76aa54.9614e530> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md1 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:86690a5f E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdb2(8,18),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj2(8,146),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdj2(8,146),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdb2: O:sdb2, SZ:38957504 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<e8ace778.846c792d.5f76aa54.9614e530> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md1 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:866909dd E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdb2(8,18),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdj2(8,146),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sdb2(8,18),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md2: <sdk2><sdc2> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<641e83bb.d6df29bf.92924585.81d861bf> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md2 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:732c6ed7 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdc2(8,34),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdk2(8,162),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdk2(8,162),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdk2: O:sdk2, SZ:38957504 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<641e83bb.d6df29bf.92924585.81d861bf> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md2 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:732c6f25 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdc2(8,34),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdk2(8,162),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdk2(8,162),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdc2: O:sdc2, SZ:38957504 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<641e83bb.d6df29bf.92924585.81d861bf> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md2 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:732c6ea3 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdc2(8,34),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdk2(8,162),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sdc2(8,34),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md3: <sdl2><sdd2> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<7d55021d.f89f0087.b6aec844.4c15513a> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md3 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:9c7c366c E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdd2(8,50),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdl2(8,178),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdl2(8,178),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdl2: O:sdl2, SZ:38957504 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<7d55021d.f89f0087.b6aec844.4c15513a> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md3 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:9c7c36ba E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdd2(8,50),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdl2(8,178),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdl2(8,178),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdd2: O:sdd2, SZ:38957504 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<7d55021d.f89f0087.b6aec844.4c15513a> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md3 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:9c7c3638 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdd2(8,50),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdl2(8,178),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sdd2(8,50),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md4: <sdm2><sde2> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<db7afee0.5232d53f.833eb3b0.775e8bc9> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md4 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:4c0f2e13 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sde2(8,66),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdm2(8,194),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdm2(8,194),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdm2: O:sdm2, SZ:38957504 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<db7afee0.5232d53f.833eb3b0.775e8bc9> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md4 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:4c0f2e61 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sde2(8,66),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdm2(8,194),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdm2(8,194),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sde2: O:sde2, SZ:38957504 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<db7afee0.5232d53f.833eb3b0.775e8bc9> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md4 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:4c0f2ddf E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sde2(8,66),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdm2(8,194),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sde2(8,66),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md5: <sdn2><sdf2> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<9616f30b.10a19c31.e7c52d28.e230abfd> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md5 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:9472830d E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdf2(8,82),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdn2(8,210),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdn2(8,210),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdn2: O:sdn2, SZ:38957504 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<9616f30b.10a19c31.e7c52d28.e230abfd> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md5 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:9472835b E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdf2(8,82),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdn2(8,210),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdn2(8,210),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdf2: O:sdf2, SZ:38957504 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<9616f30b.10a19c31.e7c52d28.e230abfd> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md5 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:947282d9 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdf2(8,82),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdn2(8,210),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sdf2(8,82),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md6: <sdo2><sdg2> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<166fb681.6b6bd289.4a7c34d7.8b4bcdf3> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md6 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:7b67a6b0 E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdg2(8,98),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdo2(8,226),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdo2(8,226),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdo2: O:sdo2, SZ:38957504 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<166fb681.6b6bd289.4a7c34d7.8b4bcdf3> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md6 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:7b67a6fe E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdg2(8,98),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdo2(8,226),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdo2(8,226),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdg2: O:sdg2, SZ:38957504 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<166fb681.6b6bd289.4a7c34d7.8b4bcdf3> CT:3c23174e
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md6 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:7b67a67c E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdg2(8,98),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdo2(8,226),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sdg2(8,98),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md7: <sdp2><sdh2> array superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<01c4cf80.87108395.360eaf24.373d90b8> CT:3c23174f
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md7 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:19e5adff E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdh2(8,114),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdp2(8,242),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdp2(8,242),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdp2: O:sdp2, SZ:38957504 F:0 DN:1 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<01c4cf80.87108395.360eaf24.373d90b8> CT:3c23174f
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md7 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:19e5ae4d E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdh2(8,114),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdp2(8,242),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:1,sdp2(8,242),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md: rdev sdh2: O:sdh2, SZ:38957504 F:0 DN:0 <6>md: rdev superblock:
Dec 24 07:49:33 cdr kernel: md:  SB: (V:0.90.0) ID:<01c4cf80.87108395.360eaf24.373d90b8> CT:3c23174f
Dec 24 07:49:33 cdr kernel: md:     L1 S38957504 ND:2 RD:2 md7 LO:0 CS:8192
Dec 24 07:49:33 cdr kernel: md:     UT:3c231ffa ST:0 AD:2 WD:2 FD:0 SD:0 CSUM:19e5adcb E:00000003
Dec 24 07:49:33 cdr kernel:      D  0:  DISK<N:0,sdh2(8,114),R:0,S:6>
Dec 24 07:49:33 cdr kernel:      D  1:  DISK<N:1,sdp2(8,242),R:1,S:6>
Dec 24 07:49:33 cdr kernel: md:     THIS:  DISK<N:0,sdh2(8,114),R:0,S:6>
Dec 24 07:49:33 cdr kernel: md:^I**********************************
Dec 24 07:49:33 cdr kernel: 
Dec 24 07:49:33 cdr kernel: md: cannot remove active disk sdi2 from md0 ... 
