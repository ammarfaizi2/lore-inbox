Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbTHVFWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 01:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTHVFWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 01:22:46 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:44497 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263047AbTHVFWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 01:22:44 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Fri, 22 Aug 2003 15:22:30 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16197.43158.905670.891510@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md: bug in file raid5.c, line 1909 in 2.4.22-pre7
In-Reply-To: message from Mike Fedyk on Tuesday August 19
References: <20030819203712.GB4083@matchmail.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 19, mfedyk@matchmail.com wrote:
> I have another report against rc1 also, but this is with a different line
> number and under different circumstances, but with the same hardware.
> 
> Details in dmesg file.
.....
> Aug 15 16:44:22 srv-lr2600 kernel: RAID5 conf printout:
> Aug 15 16:44:22 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
> Aug 15 16:44:22 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
> Aug 15 16:44:22 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
> Aug 15 16:44:22 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
> Aug 15 16:44:22 srv-lr2600 kernel: md: bug in file raid5.c, line 1909
> 
> And why did I get this bug?
> 
> Aug 15 16:44:22 srv-lr2600 kernel: 
> Aug 15 16:44:22 srv-lr2600 kernel: md:^I**********************************
> Aug 15 16:44:22 srv-lr2600 kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
> Aug 15 16:44:22 srv-lr2600 kernel: md:^I**********************************
> Aug 15 16:44:22 srv-lr2600 kernel: md0: <hda3><hdg3><hde3> array superblock:
> Aug 15 16:44:22 srv-lr2600 kernel: md:  SB: (V:0.90.0) ID:<dea08cef.28d34b00.79cd55bc.46bdbe06> CT:3f34718d
> Aug 15 16:44:22 srv-lr2600 kernel: md:     L5 S159694016 ND:3 RD:3 md0 LO:0 CS:65536
> Aug 15 16:44:23 srv-lr2600 kernel: md:     UT:3f3d602e ST:0 AD:2 WD:3 FD:0 SD:1 CSUM:f9253789 E:0001b800
> Aug 15 16:44:23 srv-lr2600 kernel:      D  0:  DISK<N:0,hde3(33,3),R:0,S:6>
> Aug 15 16:44:23 srv-lr2600 kernel:      D  1:  DISK<N:1,hdg3(34,3),R:1,S:6>
> Aug 15 16:44:23 srv-lr2600 kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:8>
> Aug 15 16:44:23 srv-lr2600 kernel:      D  3:  DISK<N:3,hda3(3,3),R:3,S:0>


Because descriptor 2 (D  2:) in the superblock has state
MD_DISK_REMOVED (S:8) rather and doesn't have the MD_DISK_FAULTY but
set (S:9 or S:1).
As far as I can see, the 2.4 code would never set just MD_DISK_REMOVED
(though it really should cope with it).  It is possible that the 2.6
code does.  Has this array had 2.6 running on it?  Does it have any
interesting history?

NeilBrown

