Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbUJ1EEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbUJ1EEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUJ1EEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:04:30 -0400
Received: from web12826.mail.yahoo.com ([216.136.174.207]:58292 "HELO
	web12826.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262743AbUJ1EEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:04:21 -0400
Message-ID: <20041028040421.80505.qmail@web12826.mail.yahoo.com>
Date: Wed, 27 Oct 2004 21:04:21 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: ext3 multiple thread streaming write performance with 2.6.9
To: Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing extremely variable and poor performance
with ext3 in the presence of multiple streaming
writers.  Below are the results of some tests I have
conducted with iozone.  XFS appears to be most
consistent performer for this workload, followed by
ext2 and finally ext3.  Has this been observed
elsewhere?  If so, is it possible to tune ext3 to
perform better on this workload?

Thanks,
Shantanu

Hardware config:
2x2.0 Xeons w/HT, 1.25GB memory, 18GB 15000 SCSI disk
attached to MPT Fusion controller.

Software config:
All SMP kernels with anticipatory I/O schedular used
throughout except for 2.4  Default values for
{pd,bd}flush used throughout.
Iozone parameters:
  -i0 -r 4k -s (256m / # threads) -e -t (# threads)

Results:
The first field is the filesystem type and how it was
mounted (for ext3).  The second field is the #
threads.  The last field is the rate observed by the
parent process in MBytes for sequential write during
each of the 3 runs followed by the average in
parenthesis.  Each filesystem was newly formatted once
before running the benchmark.  There was no other
activity on the machine during the runs.

2.6.9 (from kernel.org)

               ext2: 1: 54 54 54 (54)
               ext2: 2: 25 20 21 (22)
               ext2: 4: 29 32 40 (34)
                xfs: 1: 53 53 52 (53)
                xfs: 2: 49 49 53 (50)
                xfs: 4: 46 50 48 (48)
  ext3:data=ordered: 1: 48 48 47 (48)
  ext3:data=ordered: 2: 39 28  4 (24)
  ext3:data=ordered: 4:  4 23  4 (11)
ext3:data=writeback: 1: 48 48 48 (48)
ext3:data=writeback: 2:  4 34  4 (14)
ext3:data=writeback: 4:  5  4  5 ( 5)

2.6.8-4 (Debian 2.6.8 based kernel)

               ext2: 1: 54 54 54 (54)
               ext2: 2: 21 21 54 (32)
               ext2: 4: 28 23 22 (24)
                xfs: 1: 54 53 53 (53)
                xfs: 2: 49 52 51 (51)
                xfs: 4: 49 48 49 (49)
  ext3:data=ordered: 1: 48 48 48 (48)
  ext3:data=ordered: 2:  4  4 18 ( 9)
  ext3:data=ordered: 4:  6  5  4 ( 5)
ext3:data=writeback: 1: 48 49 50 (49)
ext3:data=writeback: 2:  4 33  4 (14)
ext3:data=writeback: 4:  4  5  4 ( 4)

2.4.27-2 (Debian 2.4.27 based kernel)

               ext2: 1: 46 47 47 (47)
               ext2: 2: 18 23 25 (22)
               ext2: 4: 17 18 23 (19)
                xfs: 1: 49 48 49 (49)
                xfs: 2: 49 48 48 (48)
                xfs: 4: 42 43 43 (43)
  ext3:data=ordered: 1: 39 37 37 (38)
  ext3:data=ordered: 2: 38 37 38 (38)
  ext3:data=ordered: 4: 45 35 35 (38)
ext3:data=writeback: 1: 37 37 37 (37)
ext3:data=writeback: 2: 27 34  9 (23)
ext3:data=writeback: 4:  8  4  6 ( 6)



	
		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail
