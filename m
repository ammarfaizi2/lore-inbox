Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTHVRVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 13:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTHVRVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 13:21:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59142
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263302AbTHVRVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 13:21:44 -0400
Date: Fri, 22 Aug 2003 10:21:42 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6 md raid5 disk faulty marking bug was: md: bug in file raid5.c, line 1909 in 2.4.22-pre7
Message-ID: <20030822172142.GF1040@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <20030819203712.GB4083@matchmail.com> <16197.43158.905670.891510@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16197.43158.905670.891510@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 03:22:30PM +1000, Neil Brown wrote:
> On Tuesday August 19, mfedyk@matchmail.com wrote:
> > Aug 15 16:44:22 srv-lr2600 kernel: md: bug in file raid5.c, line 1909
> > 
> > And why did I get this bug?
> > 
> > Aug 15 16:44:22 srv-lr2600 kernel: 
> > Aug 15 16:44:22 srv-lr2600 kernel: md:^I**********************************
> > Aug 15 16:44:22 srv-lr2600 kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
> > Aug 15 16:44:22 srv-lr2600 kernel: md:^I**********************************
> > Aug 15 16:44:22 srv-lr2600 kernel: md0: <hda3><hdg3><hde3> array superblock:
> > Aug 15 16:44:22 srv-lr2600 kernel: md:  SB: (V:0.90.0) ID:<dea08cef.28d34b00.79cd55bc.46bdbe06> CT:3f34718d
> > Aug 15 16:44:22 srv-lr2600 kernel: md:     L5 S159694016 ND:3 RD:3 md0 LO:0 CS:65536
> > Aug 15 16:44:23 srv-lr2600 kernel: md:     UT:3f3d602e ST:0 AD:2 WD:3 FD:0 SD:1 CSUM:f9253789 E:0001b800
> > Aug 15 16:44:23 srv-lr2600 kernel:      D  0:  DISK<N:0,hde3(33,3),R:0,S:6>
> > Aug 15 16:44:23 srv-lr2600 kernel:      D  1:  DISK<N:1,hdg3(34,3),R:1,S:6>
> > Aug 15 16:44:23 srv-lr2600 kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:8>
> > Aug 15 16:44:23 srv-lr2600 kernel:      D  3:  DISK<N:3,hda3(3,3),R:3,S:0>
> 
> 
> Because descriptor 2 (D  2:) in the superblock has state
> MD_DISK_REMOVED (S:8) rather and doesn't have the MD_DISK_FAULTY but
> set (S:9 or S:1).
> As far as I can see, the 2.4 code would never set just MD_DISK_REMOVED
> (though it really should cope with it).  It is possible that the 2.6
> code does.  Has this array had 2.6 running on it?  Does it have any
> interesting history?

Yes, it was running 2.6-test2-mm2 or so (don't remember exactly, I can check
though if needed) previously, but I didn't notice any bug messages from
there, and seeing that it was 2.4 I was surprised to see bug messages from md.

This is an IDE raid of three 160GB Maxtor hard drives.  Unfortunately, a rw
badblocks run didn't show the problems that showed up while trying to setup
the production system, but smartctl did, and so did the kernel while 100
sectors were being moved around by the smart firmware in the drive.  Anyway,
I'm getting a new drive, but after a few badblocks runs, and running a
couple raid resyncs (not my intention, but raid got funny after 2.6 was run
on the machine.) 

Do you have any patches for 2.6 md?  Right now this system is still in
testing, and I'd like to help get this code path tested, and fixed.

Mike
