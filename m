Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268057AbTBMPWB>; Thu, 13 Feb 2003 10:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268058AbTBMPWB>; Thu, 13 Feb 2003 10:22:01 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:19099 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268057AbTBMPWA>;
	Thu, 13 Feb 2003 10:22:00 -0500
Date: Thu, 13 Feb 2003 15:27:42 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.60 NFS FSX
Message-ID: <20030213152742.GA1560@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.60's NFS seems to have various issues.
(2.5.60 client, 2.4.21pre3 server)

- I ran an fsx and an fsstress in parallel.
  Client rebooted after 2-3 minutes.
- fsx on its own, after quite a while, this happens..

truncating to largest ever: 0x3ffff
skipping zero size read
skipping zero size write
skipping zero size write
skipping zero size write
READ BAD DATA: offset = 0x358ba, size = 0x4867
OFFSET	GOOD	BAD	RANGE
0x36000	0x0000	0x8c1a	0x 1ff3
operation# (mod 256) for the bad data may be 140
LOG DUMP (176283 total operations):
176284(156 mod 256): READ	0x35b07 thru 0x38c67	(0x3161 bytes)	***RRRR***
176285(157 mod 256): READ	0x12552 thru 0x1af77	(0x8a26 bytes)
176286(158 mod 256): WRITE	0x3560f thru 0x3ffff	(0xa9f1 bytes)	***WWWW
176287(159 mod 256): MAPWRITE 0x1aaae thru 0x233bf	(0x8912 bytes)
176288(160 mod 256): MAPREAD	0x3635d thru 0x3661b	(0x2bf bytes)
176289(161 mod 256): MAPREAD	0x374c0 thru 0x3ba42	(0x4583 bytes)	***RRRR***
176290(162 mod 256): WRITE	0x16794 thru 0x192eb	(0x2b58 bytes)
176291(163 mod 256): READ	0x128bf thru 0x1d5b0	(0xacf2 bytes)
176292(164 mod 256): READ	0x330d5 thru 0x35b26	(0x2a52 bytes)
176293(165 mod 256): MAPREAD	0xff6b thru 0x13c4e	(0x3ce4 bytes)
176294(166 mod 256): MAPWRITE 0x1c5e0 thru 0x2a720	(0xe141 bytes)
176295(167 mod 256): MAPWRITE 0x2a8df thru 0x2e628	(0x3d4a bytes)
176296(168 mod 256): MAPWRITE 0x370cc thru 0x3be24	(0x4d59 bytes)	******WWWW
176297(169 mod 256): MAPWRITE 0x21637 thru 0x30999	(0xf363 bytes)
... <much more spew .. 
(full log is at http://www.codemonkey.org.uk/cruft/nfs-fsx-2.5.60.txt )

Finally, I see a lot of these in the client logs..

NFS: server cheating in read reply: count 8192 > recvd 1000
NFS: server cheating in read reply: count 8192 > recvd 1000
NFS: server cheating in read reply: count 8192 > recvd 1000
NFS: server cheating in read reply: count 3888 > recvd 1000
NFS: server cheating in read reply: count 8192 > recvd 1000
NFS: server cheating in read reply: count 8192 > recvd 1000
...

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
