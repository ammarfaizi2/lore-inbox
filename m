Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbRFGQ30>; Thu, 7 Jun 2001 12:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbRFGQ3R>; Thu, 7 Jun 2001 12:29:17 -0400
Received: from ns.tasking.nl ([195.193.207.2]:60171 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S261854AbRFGQ3A>;
	Thu, 7 Jun 2001 12:29:00 -0400
Date: Thu, 7 Jun 2001 18:28:10 +0200
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5: extreme sluggishness/strange OOM
Message-ID: <20010607182810.A29223@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A PIII with 64MB ram, 256MB swap became extremely sluggish. While still
inside X11 the caps-lock LED responded only after about 10 seconds. Disk
LED was continuously on. Impossible to connect from another system (just too
slow) but the box still responded to ICMP echo.

I played a bit with magic sysrq before the system was rebooted. This is an
excerpt from /var/log/messages. I don't know how to interpret everything but
certainly the long stack traces look suspicious to me. Obviously the system
ran out of memory and swap but I'm not sure how. Yes I know here are some VM
issues which _might_ be responsible.

Jun  7 16:49:51 posio kernel: Out of Memory: Killed process 10165 (gnome-terminal). 
Jun  7 16:49:54 posio automount[4566]: expired /usr/src/olman
Jun  7 16:50:40 posio automount[555]: attempting to mount entry /usr/src/olman
Jun  7 16:53:51 posio automount[6550]: expired /usr/src/olman
Jun  7 16:54:50 posio automount[555]: attempting to mount entry /usr/src/olman
Jun  7 16:56:32 posio automount[6694]: expired /usr/src/olman
Jun  7 16:58:08 posio kernel: Out of Memory: Killed process 6033 (gnome-terminal). 
Jun  7 16:58:10 posio kernel: Out of Memory: Killed process 12952 (gnome-terminal). 
Jun  7 16:58:10 posio kernel: Out of Memory: Killed process 16744 (gnomecal). 
Jun  7 16:58:10 posio kernel: Out of Memory: Killed process 16742 (gmc). 
Jun  7 16:58:10 posio kernel: Out of Memory: Killed process 16736 (panel). 
Jun  7 16:58:58 posio automount[555]: attempting to mount entry /usr/src/olman
Jun  7 17:04:08 posio kernel: Out of Memory: Killed process 7882 (cpumemusage_app). 
Jun  7 17:04:40 posio kernel: Out of Memory: Killed process 6756 (gmc). 
Jun  7 17:05:06 posio automount[13344]: expired /usr/src/olman
Jun  7 17:05:20 posio automount[555]: attempting to mount entry /usr/src/olman
Jun  7 17:06:32 posio automount[13829]: expired /usr/src/olman
Jun  7 17:07:53 posio kernel: Out of Memory: Killed process 6748 (panel). 
Jun  7 17:08:01 posio automount[555]: attempting to mount entry /usr/src/olman
Jun  7 17:11:13 posio automount[15088]: expired /usr/src/olman
Jun  7 17:12:09 posio automount[555]: attempting to mount entry /usr/src/olman
Jun  7 17:13:30 posio automount[15543]: expired /usr/src/olman
Jun  7 17:13:55 posio automount[555]: attempting to mount entry /usr/src/olman
Jun  7 17:15:12 posio automount[15778]: expired /usr/src/olman
Jun  7 17:19:42 posio automount[555]: attempting to mount entry /usr/src/olman
Jun  7 17:20:57 posio automount[16168]: expired /usr/src/olman
Jun  7 17:23:43 posio pam_rhosts_auth[16274]: allowed to fvm@espoo.tasking.nl as fvm
Jun  7 17:24:04 posio kernel: SysRq: Show Memory 
Jun  7 17:24:04 posio kernel: Mem-info: 
Jun  7 17:24:04 posio kernel: Free pages:        1768kB (     0kB HighMem) 
Jun  7 17:24:04 posio kernel: ( Active: 346, inactive_dirty: 96, inactive_clean: 201, free: 442 (222 444 666) ) 
Jun  7 17:24:04 posio kernel: 115*4kB 7*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB = 1012kB) 
Jun  7 17:24:04 posio kernel: 85*4kB 8*8kB 2*16kB 0*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB = 756kB) 
Jun  7 17:24:04 posio kernel: = 0kB) 
Jun  7 17:24:04 posio kernel: Swap cache: add 940496, delete 940331, find 2846139/4357658 
Jun  7 17:24:04 posio kernel: Free swap:            0kB 
Jun  7 17:24:04 posio kernel: 16128 pages of RAM 
Jun  7 17:24:04 posio kernel: 0 pages of HIGHMEM 
Jun  7 17:24:04 posio kernel: 1029 reserved pages 
Jun  7 17:24:05 posio kernel: 2646 pages shared 
Jun  7 17:24:06 posio kernel: 165 pages swap cached 
Jun  7 17:24:07 posio kernel: 0 pages in page table cache 
Jun  7 17:24:07 posio kernel: Buffer memory:      152kB 
Alt-SysRq-T:
Jun  7 17:24:10 posio kernel: >] [<dfdfdfdf>] [<dfdfdfdf>] [<dfdfdfdf>]  
Jun  7 17:24:10 posio kernel:        [<dfdfdfdf>] [<dfdfdfdf>] [<dfdfdfdf>] [<dfdfdfdf>] [<dfdfdfdf>] [<dfdfdfdf>] [<dfdfdfdf>] [<dfdfdfdf>]  
Jun  7 17:24:10 posio last message repeated 32 times
Jun  7 17:24:10 posio kernel:        [<dfdfdfdf>] [<dfdfdfdf>] [<c0264c56>] [<c01af75f>] [<c02a9ce7>] [<c0118c95>] [<c0118feb>] [<c010adab>]  
Jun  7 17:24:10 posio kernel:        [<c0107f3d>] [<c01080d8>] [<c0106dc0>] [<c01cf136>] [<c01d539c>] [<c0107f3d>] [<c02a9ce7>] [<c02a9d4f>]  
Jun  7 17:24:10 posio kernel:        [<c01ce5ea>] [<c01cd841>] [<c01d59a6>] [<c01d59f7>] [<c01ae9a8>] [<c026dfa3>] [<c0268608>] [<c0275bc3>]  
Jun  7 17:24:10 posio kernel:        [<c026da8f>] [<c0274a43>] [<c0275b40>] [<c0275b39>] [<c026da8f>] [<c02754bd>] [<c0275b2c>] [<c028bc7d>]  
Jun  7 17:24:10 posio kernel:        [<c028b83c>] [<c029127c>] [<c02912b6>] [<c026218d>] [<c02a3498>] [<c02a43f9>] [<c02a3a02>] [<c02a3a38>]  
Jun  7 17:24:10 posio kernel:        [<c0107f3d>] [<c01102f2>] [<c016ab20>] [<c02a42c9>] [<c02a50f9>] [<c02a543b>] [<c02a4e79>] [<c02a12e5>]  
Jun  7 17:24:10 posio kernel:        [<c0167b75>] [<c015ef2d>] [<c015f0c0>] [<c4899000>] [<c0128e0a>] [<c0126e9e>] [<c0128764>] [<c0128844>]  
Jun  7 17:24:10 posio kernel:        [<c011e78b>] [<c011ee07>] [<c010f75b>] [<c010f5f4>] [<c011539f>] [<c0106d03>] [<c010002b>]  
Jun  7 17:24:10 posio kernel: sh        S 00000000     0 15683  15251 15686  (NOTLB)         
Jun  7 17:24:10 posio kernel: Call Trace: [<d9d9d800>] [<d9d9d9d9>] [<e8ba2e8c>] [<fff10011>] [<fff10011>] [<fff10011>] [<fff10011>]  
Jun  7 17:24:10 posio kernel:        [<fff10011>] [<fff10011>] [<fff10011>] [<f045890c>] [<f0558dfc>] [<e500838d>] [<ef28838d>] [<c95e5bf8>]  
Jun  7 17:24:10 posio kernel:        [<ffe57083>] [<ffb80e74>] [<ebffffff>] [<e808458b>] [<c9fc5d8b>] [<c9850e8b>] [<e1e90000>] [<e975c085>]  
Jun  7 17:24:10 posio kernel:        [<c9850000>] [<ef48838d>] [<ff50ffff>] [<fd2ee800>] [<c483ffff>] [<e8c031d2>] [<f8890000>] [<fffcc3e8>]  
Jun  7 17:24:11 posio kernel:        [<ff006a04>] [<fffd0be8>] [<e85324ec>] [<dc558de0>] [<e598838d>] [<f8450304>] [<f6890000>] [<e875c985>]  
Jun  7 17:24:11 posio kernel:        [<c9850000>] [<ef88838d>] [<ff50ffff>] [<fb9ee800>] [<c483ffff>] [<e8c031d2>] [<fb46e8f8>] [<e8f88900>]  
Jun  7 17:24:11 posio kernel:        [<e85324ec>] [<f4458904>] [<c7e44d89>] [<d2310000>] [<e2c15474>] [<e2c13874>] [<e2c11c74>] [<f045c7e8>]  
Jun  7 17:24:11 posio kernel:        [<ffe71883>] [<ebf84503>] [<fc458900>] [<c6891e74>] [<f6896deb>] [<eae8838d>] [<d8eb08c4>] [<d0b3ff12>]  
Jun  7 17:24:11 posio kernel:        [<e8000001>] [<f9c6e801>] [<c689ffff>] [<d0b3ff56>] [<e8000001>] [<e8500974>] [<fc558bf8>] [<fff90fe8>]  
Jun  7 17:24:11 posio kernel:        [<ec658d00>] [<c95f5e5b>] [<d0b3ff13>] [<e8000001>] [<f685f631>] [<c7fffff9>] [<f7e6e850>] [<ff50ffff>]  
Jun  7 17:24:12 posio kernel:        [<fc458d50>] [<f832e850>] [<c483ffff>] [<fff88314>] [<f8d2e808>] [<c95e5bf4>] [<e8500000>] [<c9fc5d8b>]  
Jun  7 17:24:12 posio kernel:        [<e80875ff>] [<fff853e8>] [<fc5d8bff>] [<e85310ec>] [<f045890c>] [<f0558df4>] [<ebd4838d>] [<efbd838d>]  
Jun  7 17:24:12 posio kernel:        [<d1e8ffff>] [<c95e5bf8>] [<fcc0313e>] [<f7aef2ff>] [<e1c149d1>] [<e7898465>] [<eb884589>] [<c48304c7>]  
Jun  7 17:24:12 posio kernel:        [<e0752001>] [<d189168b>] [<ffefbe83>] [<fff59be8>] [<ebc031ff>] [<fcc7833d>] [<e289fc29>] [<f64ee852>]  
Jun  7 17:24:12 posio kernel:        [<ff308b84>] [<db905589>] [<c95f5e5b>] [<ebfc7589>] [<fff653e8>] [<c603eb09>] [<fe890a06>] [<f68970eb>]  
Jun  7 17:24:13 posio kernel:        [<e8513189>] [<f68968eb>] [<f52ae856>] [<fb4d880e>] [<f642048b>] [<d87420c4>] [<f4f2e800>] [<fb4d8afc>]  
Jun  7 17:24:13 posio kernel:        [<f689c3c9>] [<f445c700>] [<c01ae9a8>] [<f4838d00>] [<f475ff3e>] [<c026dfa3>] [<c0268608>] [<c0275bc3>]  
Jun  7 17:24:13 posio kernel:        [<c026da8f>] [<c0274a43>] [<c0275b40>] [<c0275b39>] [<c026da8f>] [<c02754bd>] [<c0275b2c>] [<c028bc7d>]  
Jun  7 17:24:13 posio kernel:        [<c028b83c>] [<c029127c>] [<c02912b6>] [<c026218d>] [<c02a3498>] [<c02a43f9>] [<c02a3a02>] [<c02a3a38>]  
Jun  7 17:24:13 posio kernel:        [<c0264de7>] [<c0264f74>] [<c0268919>] [<c016ab40>] [<c016ab20>] [<c02a42c9>] [<c02a50f9>] [<c02a543b>]  
Jun  7 17:24:13 posio kernel:        [<c02a4e79>] [<c02a12e5>] [<c0167b75>] [<f75de65b>] [<c01287f5>] [<c011e78b>] [<c011ee07>] [<c010f75b>]  
Jun  7 17:24:14 posio kernel:        [<c010f5f4>] [<c011539f>] [<c0106d03>]  
Jun  7 17:24:14 posio kernel: yam       S 00000000     0 15686  15683 16156  (NOTLB)         
Jun  7 17:24:14 posio kernel: Call Trace: [<d9d9d800>] [<d9d9d9d9>] [<e8ba2e8c>] [<c01cd841>] [<c01d5832>] [<c01d5260>] [<c01ce9e0>]  
Jun  7 17:24:16 posio kernel:        [<c01ce968>] [<c01ceca1>] [<c01cd841>] [<c01d5832>] [<c01d5260>] [<c01ce9e0>] [<c01ce968>] [<c01ceca1>]  
Jun  7 17:24:17 posio kernel:        [<c01cf11b>] [<c011997c>] [<c0119a5d>] [<c0119b0c>] [<c01ae9a8>] [<c01155c0>] [<c0118f84>] [<c0118816>]  
Jun  7 17:24:17 posio kernel:        [<c026dfa3>] [<c0268608>] [<c026b603>] [<c0275bc3>] [<c026da8f>] [<c0274a43>] [<c0275b40>] [<c0275b39>]  
Jun  7 17:24:17 posio kernel:        [<c026da8f>] [<c02754bd>] [<c0275b2c>] [<c028bc7d>] [<c028b83c>] [<c029127c>] [<c02912b6>] [<c026218d>]  
Jun  7 17:24:17 posio kernel:        [<c02a3498>] [<c02a43f9>] [<c02a3a02>] [<c02a3a38>] [<c01cd841>] [<c01102f2>] [<c016ab20>] [<c02a42c9>]  
Jun  7 17:24:17 posio kernel:        [<c02a50f9>] [<c02a543b>] [<c02a4e79>] [<c02a12e5>] [<c01a08a3>] [<c01cd841>] [<c01d5832>] [<c01d5260>]  
Jun  7 17:24:17 posio kernel:        [<c01cd841>] [<c01d5832>] [<c01d5260>] [<c01ce9e0>] [<c01ce968>] [<c0126e96>] [<c0128764>] [<c0128865>]  
Jun  7 17:24:18 posio kernel:        [<c011e78b>] [<c011ee07>] [<c010f75b>] [<c010f5f4>] [<c011539f>] [<c0106d03>] [<c010002b>]  
Jun  7 17:24:18 posio kernel: sh        S 00000000  1796 16156  15686 16159  (NOTLB)         
Jun  7 17:24:18 posio kernel: Call Trace: [<d9d9d800>] [<d9d9d9d9>] [<e8ba2e8c>] [<c0118c95>] [<c01ae9a8>] [<c01080d8>] [<c026dfa3>]  
Jun  7 17:24:19 posio kernel:        [<c0268608>] [<c026b603>] [<c0275bc3>] [<c026da8f>] [<c0274a43>] [<c0275b40>] [<c0275b39>] [<c026da8f>]  
Jun  7 17:24:19 posio kernel:        [<c02754bd>] [<c0275b2c>] [<c028bc7d>] [<c028b83c>] [<c029127c>] [<d3fea400>] [<e2baf8ea>] [<c02912b6>]  
Jun  7 17:24:19 posio kernel:        [<c026218d>] [<c02a3498>] [<c02a43f9>] [<c02a3a02>] [<c02a3a38>] [<c0264de7>] [<c0264f74>] [<c0268919>]  
Jun  7 17:24:20 posio kernel:        [<c016ab40>] [<c016ab20>] [<c02a42c9>] [<c02a50f9>] [<c02a543b>] [<c02a4e79>] [<c02a12e5>] [<c0167b75>]  
Jun  7 17:24:20 posio kernel:        [<c01c0006>] [<c4899000>] [<c0128e0a>] [<c4899000>] [<c0128e0a>] [<c0126e9e>] [<c0128764>] [<c0128865>]  
Jun  7 17:24:20 posio kernel:        [<c011e78b>] [<c011ee07>] [<c010f75b>] [<c010f5f4>] [<c011539f>] [<c0106d03>] [<c010002b>]  
Jun  7 17:24:20 posio kernel: yam       S 00000000     0 16159  16156 16278  (NOTLB)         
Jun  7 17:24:23 posio kernel: Call Trace: [<d9d9d800>] [<d9d9d9d9>] [<e8ba2e8c>] [<fbad2088>] [<fbad2a87>] [<fbad2287>] [<fbad2088>]  
Jun  7 17:24:23 posio kernel:        [<c01a08a3>] [<c01cd841>] [<c01d537f>] [<c01d5260>] [<c01a13ff>] [<c01cd841>] [<c01a13ff>] [<c01cd841>]  
Jun  7 17:24:23 posio kernel:        [<c01cd841>] [<c01ae9a8>] [<c01ae9a8>] [<c01ae9a8>] [<c01d5832>] [<c01d5260>] [<c026dfa3>] [<c0268608>]  
Jun  7 17:24:23 posio kernel:        [<c0275bc3>] [<c026da8f>] [<c0274a43>] [<c0275b40>] [<c0275b39>] [<c026da8f>] [<c02754bd>] [<c0275b2c>]  
Jun  7 17:24:23 posio kernel:        [<c028bc7d>] [<c028b83c>] [<c029127c>] [<f1217c7b>] [<c02912b6>] [<c026218d>] [<c02a3498>] [<c02a43f9>]  
Jun  7 17:24:24 posio kernel:        [<c02a3a02>] [<c02a3a38>] [<c0264dd3>] [<c0268919>] [<c011607e>] [<c01102f2>] [<c016ab20>] [<c02a42c9>]  
Jun  7 17:24:24 posio kernel:        [<c02a50f9>] [<c02a543b>] [<c02a4e79>] [<c02a12e5>] [<c0167b75>] [<c015ef2d>] [<c015f0c0>] [<c0126e96>]  
Jun  7 17:24:24 posio kernel:        [<c0128764>] [<c0128865>] [<c011e78b>] [<c011ee07>] [<c010f75b>] [<c010f5f4>] [<c011539f>] [<c0106d03>]  
Jun  7 17:24:24 posio kernel: sh        S C2114000  1336 16278  16159 16290  (NOTLB)         
Jun  7 17:24:24 posio kernel: Call Trace: [<d9d9d800>] [<d9d9d9d9>] [<e8ba2e8c>] [<c01cd841>] [<c01a08a3>] [<c01cd841>] [<c01a08a3>]  
Jun  7 17:24:24 posio kernel:        [<c01102f2>] [<c012e87f>] [<c01a08a3>] [<c01a08de>] [<c01a08fd>] [<c01ae9a8>] [<c026dfa3>] [<c0268608>]  
Jun  7 17:24:25 posio kernel:        [<c0275bc3>] [<c026da8f>] [<c0274a43>] [<c0275b40>] [<c0275b39>] [<c026da8f>] [<c02754bd>] [<c0275b2c>]  
Jun  7 17:24:25 posio kernel:        [<c028bc7d>] [<c028b83c>] [<c029127c>] [<c02912b6>] [<c026218d>] [<c02a3498>] [<c02a43f9>] [<c02a3a02>]  
Jun  7 17:24:25 posio kernel:        [<c02a3a38>] [<c0264de7>] [<c0264f74>] [<c0268919>] [<c016ab40>] [<c016ab20>] [<c02a42c9>] [<c02a50f9>]  
Jun  7 17:24:25 posio kernel:        [<c02a543b>] [<c01cd841>] [<c01d5832>] [<c01d5260>] [<c01ce9e0>] [<c01ce968>] [<c01a08a3>] [<c01a08de>]  
Jun  7 17:24:25 posio kernel:        [<c01a08fd>] [<c0107f3d>] [<c01a0fd1>] [<c01a1091>] [<c0130514>] [<c01102f2>] [<c4899000>] [<c0128e0a>]  
Jun  7 17:24:25 posio kernel:        [<c0126e96>] [<c0128764>] [<c0121d1d>] [<c011ecd0>] [<c011edd1>] [<c013665c>] [<c0136729>] [<c012d8cc>]  
Jun  7 17:24:25 posio kernel:        [<c012dbd6>] [<c0106d03>]  
Jun  7 17:24:25 posio kernel: in.telnetd  S 7FFFFFFF     0 16284    394 16289  (NOTLB)         
Jun  7 17:24:25 posio kernel: Call Trace: [<d9d9d800>] [<d9d9d9d9>] [<d4e7602f>] [<d4e76030>] [<d4e76031>] [<d4e76032>] [<d4e76033>]  
Jun  7 17:24:26 posio kernel:        [<d4e76034>] [<d4e76035>] [<d4e76036>] [<d4e76037>] [<d4e76038>] [<d4e76039>] [<d4e7603a>] [<d4e7603b>]  
Jun  7 17:24:26 posio kernel:        [<d4e7603c>] [<c01a08a3>] [<c01102f2>] [<c012e87f>] [<c01a08a3>] [<c01a08de>] [<c01a08fd>] [<c01a08a3>]  
Jun  7 17:24:26 posio kernel:        [<c01a0b6f>] [<c01a0fd1>] [<c01a1091>] [<c0130514>] [<c4899000>] [<c0128e0a>] [<c0126e9e>] [<c0128764>]  
Jun  7 17:24:26 posio kernel:        [<c0128865>] [<c0121d8f>] [<c0128865>] [<c011ecd0>] [<c011edd1>] [<c010f75b>] [<c010f5f4>] [<c014122c>]  
Jun  7 17:24:26 posio kernel:        [<c0106e44>] [<c02a9ce7>] [<c02a9d4f>] [<c01ce5ea>] [<c01cd841>] [<c01d59a6>] [<c01d59f7>] [<c01a08a3>]  
Jun  7 17:24:26 posio kernel:        [<c01ae9a8>] [<c01102f2>] [<c01ae9a8>] [<c0268608>] [<c026dfa3>] [<c0268608>] [<c0275bc3>] [<c026da8f>]  
Jun  7 17:24:26 posio kernel:        [<c0274a43>] [<c0275b40>] [<c0275d44>] [<c026da8f>] [<c0274cc4>] [<c0275bfc>] [<c011edd1>] [<c0264de7>]  
Jun  7 17:24:26 posio kernel:        [<c0264f74>] [<c0268919>] [<c02664bf>] [<c0121d1d>] [<c01287f5>] [<c010ff93>] [<c013b728>] [<c013bce1>]  
Jun  7 17:24:27 posio kernel:        [<c0106d03>]  
Jun  7 17:24:27 posio kernel: login     D C166B4A0  1776 16289  16284        (NOTLB)         
Jun  7 17:24:27 posio kernel: Call Trace: [<d9d9d800>] [<d9d9d9d9>] [<c01a08a3>] [<c01102f2>] [<c01cd841>] [<c01d537f>] [<c01d5260>]  
Jun  7 17:24:27 posio kernel:        [<c01cd841>] [<c01cf0e7>] [<c01cd841>] [<c01cd841>] [<c01d5832>] [<c01d5260>] [<c01a08a3>] [<c01a0b6f>]  
Jun  7 17:24:27 posio kernel:        [<c01a0fd1>] [<c01a1091>] [<c0130514>] [<c4899000>] [<c0128e0a>] [<c0126e9e>] [<c0128764>] [<c0128865>]  
Jun  7 17:24:27 posio kernel:        [<c0121d8f>] [<c0128865>] [<c011ecd0>] [<c011edd1>] [<c010f75b>] [<c010f5f4>] [<c014122c>] [<c0106e44>]  
Jun  7 17:24:27 posio kernel:        [<c02a9eaf>] [<c01a08a3>] [<c01a08de>] [<c01a08fd>] [<c01102f2>] [<c0126e96>] [<c0128764>] [<c012fa7e>]  
Jun  7 17:24:28 posio kernel:        [<c01a08a3>] [<c01a0fd1>] [<c012e845>] [<c012f93b>] [<c014e66f>] [<c0140d30>] [<c0140dc5>] [<c0140fea>]  
Jun  7 17:24:28 posio kernel:        [<c014f4cb>] [<c01374bb>] [<f2b812bb>] [<c0137be4>] [<f2b812bb>] [<c0138338>] [<c012d4dc>] [<c012d7dc>]  
Jun  7 17:24:28 posio kernel:        [<c0106d03>]  
Jun  7 17:24:28 posio kernel: sh        D C1D73CE0     0 16290  16278        (NOTLB)         
Jun  7 17:24:28 posio kernel: Call Trace: [<d9d9d800>] [<d9d9d9d9>] [<e8ba2e8c>] [<c4830000>] [<ff509d8d>] [<e853ffff>] [<eaf6e856>]  
Jun  7 17:24:29 posio kernel:        [<c4830000>] [<d936e850>] [<d7106801>] [<e8080a40>] [<ec895f5e>] [<c6890001>] [<fed53fe8>] [<db8504c4>]  
Jun  7 17:24:29 posio kernel:        [<df890000>] [<e8500843>] [<e8080a49>] [<ff680000>] [<e856fc75>] [<d7256800>] [<d285080a>] [<c7000000>]  
Jun  7 17:24:29 posio kernel:        [<e800016a>] [<fffed2e4>] [<d73c6808>] [<fed40be8>] [<d7606857>] [<f1e80808>] [<e851fc4d>] [<d882e801>]  
Jun  7 17:24:29 posio kernel:        [<fffcffe8>] [<fed6bbe8>] [<ffe78110>] [<c820a152>] [<e8500809>] [<c483c389>] [<fff83be8>] [<fff79be8>]  
Jun  7 17:24:29 posio kernel:        [<db850cc4>] [<e8500000>] [<f6bee850>] [<d78b6800>] [<c4830001>] [<e80808d7>] [<f68947eb>] [<c689ffff>]  
Jun  7 17:24:29 posio kernel:        [<f61d74f6>] [<e8565000>] [<ffffbbe8>] [<ffba1be8>] [<f4658dff>] [<f6f085c7>] [<cf680000>] [<f6ec9589>]  
Jun  7 17:24:29 posio kernel:        [<e852ffff>] [<f6f48589>] [<c483ffff>] [<e102e853>] [<c4830001>] [<fc9d8900>] [<e8958900>] [<f6fc9d8d>]  
Jun  7 17:24:30 posio kernel:        [<e853ffff>] [<c4830001>] [<f8858d33>] [<f6f8858b>] [<fff6e895>] [<ede85208>] [<fff6f085>] [<f6f4958b>]  
Jun  7 17:24:30 posio kernel:        [<e852ffff>] [<fffecf30>] [<fff6f495>] [<fff6ec95>] [<d73c6808>] [<f6f0958b>] [<fed0f7e8>] [<e80808d8>]  
Jun  7 17:24:30 posio kernel:        [<f6dca58d>] [<c4830002>] [<f3000001>] [<de8904c4>] [<ec895f5e>] [<fcdb3108>] [<cf60828b>] [<c9750038>]  
Jun  7 17:24:30 posio kernel:        [<cc906808>] [<c483d2ff>] [<c4830000>] [<e0b03bd1>] [<ffff7b8c>] [<e8500000>] [<e8500c74>] [<dc80c7ba>]  
Jun  7 17:24:30 posio kernel:        [<c7b8048b>] [<f4658d00>] [<d8158b08>] [<f08570e0>] [<f68905eb>] [<f4658dd7>] [<efa03d3b>] [<ef9ca118>]  
Jun  7 17:24:30 posio kernel:        [<ef9ca11c>] [<d2313674>] [<da394205>] [<ec658dc8>] [<ef9c1d8b>] [<c9855048>] [<c6394c40>] [<c7000003>]  
Jun  7 17:24:30 posio kernel:        [<db85188b>] [<ff698c0f>] [<f631ffff>] [<efa00d8b>] [<ce390818>] [<f8658dd9>] [<ec895e5b>] [<e0153bd2>]  
Jun  7 17:24:30 posio kernel:        [<ec89ce7c>] [<e8e58955>] [<c7000071>] [<f5e80000>] [<e800006f>] [<fff5fbe8>] [<e8056aff>] [<c7000016>]  
Jun  7 17:24:30 posio kernel:        [<e800002d>] [<f63ee800>] [<ec89ffff>] [<efd005c7>] [<e8000070>] [<ec890000>] [<f6850000>] [<f7820f1d>]  
Jun  7 17:24:31 posio kernel:        [<de840fde>] [<c7227518>] [<d0ff008b>] [<eb04c483>] [<ff500840>] [<c483d2ff>] [<e375db85>] [<f339188b>]  
Jun  7 17:24:31 posio kernel:        [<db850000>] [<f6891f74>] [<d0ff008b>] [<eb04c483>] [<ff500840>] [<c483d2ff>] [<e375db85>] [<d2850450>]  
Jun  7 17:24:31 posio kernel:        [<d2ff5008>] [<f6851076>] [<ff008b50>] [<f0658dd0>] [<db310c55>] [<c01a08a3>] [<eb04708b>] [<c01102f2>]  
Jun  7 17:24:31 posio kernel:        [<c01cd841>] [<c01d5832>] [<c01d5260>] [<c01ce9e0>] [<c01ce968>] [<c01ceca1>] [<c01cf11b>] [<c01d539c>]  
Jun  7 17:24:33 posio kernel:        [<c0107f3d>] [<c010a188>] [<c01ae9a8>] [<c026dfa3>] [<c0268608>] [<c0275bc3>] [<c026da8f>] [<c0274a43>]  
Jun  7 17:24:34 posio kernel:        [<c0275b40>] [<c0275b39>] [<c026da8f>] [<c02754bd>] [<c0275b2c>] [<c028bc7d>] [<c028b83c>] [<c029127c>]  
Jun  7 17:24:34 posio kernel:        [<c02912b6>] [<c026218d>] [<c02a3498>] [<c02a43f9>] [<c02a3a02>] [<c02a3a38>] [<c0264de7>] [<c0264f74>]  
Jun  7 17:24:35 posio kernel:        [<c0268919>] [<c016ab40>] [<c016ab20>] [<c02a42c9>] [<c01cd841>] [<c01d5832>] [<c01d5260>] [<c01ce9e0>]  
Jun  7 17:24:35 posio kernel:        [<c01ce968>] [<c01ceca1>] [<c0126e96>] [<c0128764>] [<c012fa7e>] [<c01a08a3>] [<c01a0fd1>] [<c012e845>]  
Jun  7 17:24:35 posio kernel:        [<c014f261>] [<c0140fea>] [<c014f4a0>] [<c01374bb>] [<c013787c>] [<c013724c>] [<c01381e8>] [<c0134fd6>]  
Jun  7 17:24:35 posio kernel:        [<c0106d03>]  

ksymoops said:
Trace; d9d9d800 <END_OF_CODE+199e5bec/????>
Trace; d9d9d9d9 <END_OF_CODE+199e5dc5/????>
Trace; e8ba2e8c <END_OF_CODE+287eb278/????>

[cut 150 lines of similar garbage]

Trace; ff008b50 <END_OF_CODE+3ec50f3c/????>
Trace; f0658dd0 <END_OF_CODE+302a11bc/????>
Trace; db310c55 <END_OF_CODE+1af59041/????>
Trace; c01a08a3 <__make_request+167/7bc>
Trace; eb04708b <END_OF_CODE+2ac8f477/????>
Trace; c01102f2 <schedule+2d2/430>
Trace; c01cd841 <ide_set_handler+59/64>		<= recursion?
Trace; c01d5832 <do_rw_disk+106/320>		<=
Trace; c01d5260 <read_intr+0/13c>		<=
Trace; c01ce9e0 <ide_stall_queue+0/24>		<=
Trace; c01ce968 <start_request+1c4/23c>		<=
Trace; c01ceca1 <ide_do_request+29d/2e4>	<=
Trace; c01cf11b <ide_intr+12f/150>
Trace; c01d539c <write_intr+0/12c>
Trace; c0107f3d <handle_IRQ_event+31/5c>
Trace; c010a188 <end_8259A_irq+18/1c>
Trace; c01ae9a8 <boomerang_start_xmit+244/2d4>
Trace; c026dfa3 <qdisc_restart+13/c8>
Trace; c0268608 <dev_queue_xmit+e8/1d4>
Trace; c0275bc3 <ip_finish_output2+83/bc>
Trace; c026da8f <nf_hook_slow+137/170>
Trace; c0274a43 <ip_output+53/58>
Trace; c0275b40 <ip_finish_output2+0/bc>
Trace; c0275b39 <output_maybe_reroute+d/14>
Trace; c026da8f <nf_hook_slow+137/170>
Trace; c02754bd <ip_build_xmit+2bd/338>
Trace; c0275b2c <output_maybe_reroute+0/14>
Trace; c028bc7d <udp_sendmsg+339/3b4>
Trace; c028b83c <udp_getfrag+0/c4>
Trace; c029127c <inet_sendmsg+0/40>
Trace; c02912b6 <inet_sendmsg+3a/40>
Trace; c026218d <sock_sendmsg+81/a4>
Trace; c02a3498 <xprt_timer+0/70>
Trace; c02a43f9 <rpc_add_timer+7d/8c>
Trace; c02a3a02 <do_xprt_transmit+3ba/40c>
Trace; c02a3a38 <do_xprt_transmit+3f0/40c>
Trace; c0264de7 <kfree_skbmem+b/58>
Trace; c0264f74 <__kfree_skb+140/148>
Trace; c0268919 <net_tx_action+45/a0>
Trace; c016ab40 <nfs3_xdr_lookupres+20/634>
Trace; c016ab20 <nfs3_xdr_lookupres+0/634>
Trace; c02a42c9 <xprt_clear_backlog+21/50>
Trace; c01cd841 <ide_set_handler+59/64>		<=
Trace; c01d5832 <do_rw_disk+106/320>		<=
Trace; c01d5260 <read_intr+0/13c>		<=
Trace; c01ce9e0 <ide_stall_queue+0/24>		<=
Trace; c01ce968 <start_request+1c4/23c>		<=
Trace; c01ceca1 <ide_do_request+29d/2e4>	<=
Trace; c0126e96 <reclaim_page+2fe/3ec>
Trace; c0128764 <__alloc_pages_limit+6c/90>
Trace; c012fa7e <create_buffers+6a/1b4>
Trace; c01a08a3 <__make_request+167/7bc>
Trace; c01a0fd1 <generic_make_request+d9/140>
Trace; c012e845 <__wait_on_buffer+55/9c>
Trace; c014f261 <ext2_find_entry+1a1/3b0>
Trace; c0140fea <iget4+c6/d4>
Trace; c014f4a0 <ext2_lookup+30/88>
Trace; c01374bb <real_lookup+53/c4>
Trace; c013787c <path_walk+238/7fc>
Trace; c013724c <getname+5c/a0>
Trace; c01381e8 <__user_walk+3c/58>
Trace; c0134fd6 <sys_newstat+16/70>
Trace; c0106d03 <system_call+33/40>

Jun  7 17:24:57 posio kernel: SysRq: Show Regs 
Jun  7 17:24:57 posio kernel:  
Jun  7 17:24:57 posio kernel: EIP: 0010:[<c0107f30>] CPU: 0 EFLAGS: 00000246 
Jun  7 17:24:57 posio kernel: EAX: 00000001 EBX: c1130360 ECX: 0000000e EDX: c2213d98 
Jun  7 17:24:57 posio kernel: ESI: 00000001 EDI: 0000000e EBP: c2213d98 DS: 0018 ES: 0018 
Jun  7 17:24:57 posio kernel: CR0: 8005003b CR2: 400332c8 CR3: 03ef0000 CR4: 000006d0 
Jun  7 17:24:57 posio kernel: Call Trace: [<c01080a7>] [<c0106dc0>] [<c0230018>] [<c0100018>] [<c023723b>] [<c02372ac>] [<c02372cc>]  
Jun  7 17:24:57 posio kernel:        [<c0118f84>] [<c0116237>] [<c0116178>] [<c011607e>] [<c01080d8>] [<c4899000>] [<c0106dc0>] [<c4899000>]  
Jun  7 17:24:57 posio kernel:        [<ffff0001>] [<c0100018>] [<c01292e7>] [<c4899000>] [<c011eb28>] [<c011ede2>] [<c010f75b>] [<c010f5f4>]  
Jun  7 17:24:57 posio kernel:        [<ffff037f>] [<ffff0120>] [<c0106171>] [<c010623e>] [<c0106e44>]  
>>EIP; c0107f30 <handle_IRQ_event+24/5c>   <=====
Trace; c01080a7 <do_IRQ+6b/ac>
Trace; c0106dc0 <ret_from_intr+0/20>
Trace; c0230018 <hub_probe+98/1b8>
Trace; c0100018 <startup_32+18/a5>
Trace; c023723b <rh_send_irq+4f/c0>
Trace; c02372ac <rh_int_timer_do+0/44>
Trace; c02372cc <rh_int_timer_do+20/44>
Trace; c0118f84 <timer_bh+244/288>
Trace; c0116237 <bh_action+1b/68>
Trace; c0116178 <tasklet_hi_action+3c/60>
Trace; c011607e <do_softirq+4e/74>
Trace; c01080d8 <do_IRQ+9c/ac>
Trace; c4899000 <END_OF_CODE+44e13ec/????>
Trace; c0106dc0 <ret_from_intr+0/20>
Trace; c4899000 <END_OF_CODE+44e13ec/????>
Trace; ffff0001 <END_OF_CODE+3fc383ed/????>
Trace; c0100018 <startup_32+18/a5>
Trace; c01292e7 <__swap_free+af/140>
Trace; c4899000 <END_OF_CODE+44e13ec/????>
Trace; c011eb28 <do_swap_page+e8/18c>
Trace; c011ede2 <handle_mm_fault+7a/d8>
Trace; c010f75b <do_page_fault+167/4dc>
Trace; c010f5f4 <do_page_fault+0/4dc>
Trace; ffff037f <END_OF_CODE+3fc3876b/????>
Trace; ffff0120 <END_OF_CODE+3fc3850c/????>
Trace; c0106171 <restore_sigcontext+111/134>
Trace; c010623e <sys_sigreturn+aa/d4>
Trace; c0106e44 <error_code+34/40>

Jun  7 17:24:57 posio kernel: SysRq: Show Regs 
Jun  7 17:24:57 posio kernel:  
Jun  7 17:24:58 posio kernel: EIP: 0010:[<c01cf136>] CPU: 0 EFLAGS: 00000286 
Jun  7 17:24:58 posio kernel: EAX: 00000003 EBX: c03b1f40 ECX: 00000001 EDX: c038914c 
Jun  7 17:24:58 posio kernel: ESI: c1164060 EDI: 00000286 EBP: c03b1f00 DS: 0018 ES: 0018 
Jun  7 17:24:59 posio kernel: CR0: 8005003b CR2: 080601d4 CR3: 037ee000 CR4: 000006d0 
Jun  7 17:24:59 posio kernel: Call Trace: [<c01d5260>] [<c0107f3d>] [<c01080a7>] [<c0106dc0>]  
>>EIP; c01cf136 <ide_intr+14a/150>   <=====
Trace; c01d5260 <read_intr+0/13c>
Trace; c0107f3d <handle_IRQ_event+31/5c>
Trace; c01080a7 <do_IRQ+6b/ac>
Trace; c0106dc0 <ret_from_intr+0/20>

Jun  7 17:24:59 posio kernel: SysRq: Show Regs 
Jun  7 17:24:59 posio kernel:  
Jun  7 17:24:59 posio kernel: EIP: 0010:[<c025ae0c>] CPU: 0 EFLAGS: 00000296 
Jun  7 17:25:00 posio kernel: EAX: 00000f94 EBX: 00000f94 ECX: 01000002 EDX: 00fcbcad 
Jun  7 17:25:00 posio kernel: ESI: c0348000 EDI: c03b5d40 EBP: 0008e000 DS: 0018 ES: 0018 
Jun  7 17:25:00 posio kernel: CR0: 8005003b CR2: 0804ee44 CR3: 03865000 CR4: 000006d0 
Jun  7 17:25:01 posio kernel: Call Trace: [<c025ac4c>] [<c01053da>] [<c0105000>] [<c0100198>]  
>>EIP; c025ae0c <acpi_idle+1c0/26c>   <=====
Trace; c025ac4c <acpi_idle+0/26c>
Trace; c01053da <cpu_idle+32/48>
Trace; c0105000 <do_linuxrc+0/d8>
Trace; c0100198 <L6+0/2>

-- 
Frank
