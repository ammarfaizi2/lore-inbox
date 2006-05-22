Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWEVS5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWEVS5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWEVS5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:57:48 -0400
Received: from cyrus.iparadigms.com ([64.140.48.8]:47847 "EHLO
	cyrus.iparadigms.com") by vger.kernel.org with ESMTP
	id S1750959AbWEVS5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:57:47 -0400
Message-ID: <447209A8.2040704@iparadigms.com>
Date: Mon, 22 May 2006 11:57:44 -0700
From: fitzboy <fitzboy@iparadigms.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tuning for large files in xfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a very large (2TB) proprietary database that is kept on an XFS
partition under a debian 2.6.8 kernel. It seemed to work well, until I
recently did some of my own tests and found that the performance should
be better then it is...

basically, treat the database as just a bunch of random seeks. The XFS
partition is sitting on top of a SCSI array (Dell PowerVault) which has
13+1 disks in a RAID5, stripe size=64k. I have done a number of tests
that mimic my app's accesses and realized that I want the inode to be
as large as possible (which in an intel box is only 2k), played with su
and sw and got those to 64k and 13... and performance got better.

BUT... here is what I need to understand, the filesize has a drastic
effect on performance. If I am doing random reads from a 20GB file
(system only has 2GB ram, so caching is not a factor), I get
performance about where I want it to be: about 5.7 - 6ms per block. But
if that file is 2TB then the time almost doubles, to 11ms. Why is this?
No other factors changed, only the filesize.

Another note, on this partition there is no other file then this one
file.

I am assuming that somewhere along the way, the kernel now has to do an
additional read from the disk for some metadata for xfs... perhaps the
btree for the file doesn't fit in the kernel's memory? so it actually
needs to do 2 seeks, one to find out where to go on disk then one to
get the data. Is that the case? If so, how can I remedy this? How can I
tell the kernel to keep all of the files xfs data in memory?

Tim

