Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVCMGKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVCMGKB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 01:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVCMGJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 01:09:57 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:64229 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262974AbVCMGHd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 01:07:33 -0500
Date: Sat, 12 Mar 2005 22:07:30 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: chaffee@bmrc.berkeley.edu, <mc@cs.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] sync doesn't flush everything out (msdos and vfat,
 2.6.11)
In-Reply-To: <878y4sg8vz.fsf@devron.myhome.or.jp>
Message-ID: <Pine.GSO.4.44.0503122205270.4831-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> vfat and msdos doesn't support the link(), and the truncate() which
> extends size is not supported yet.
>
> This test seems to calling abort(0) by CHECK(ret)...

I updated the test case (basically just set CHECk to be a NOP).  Can you
please download and re-run the test case?  After reboot, run dosfsck -a on
the crashed disk, you'll see some output like:

dosfsck 2.10, 22 Sep 2003, FAT32, LFN
/å004  and
/0005
  share clusters.
  Truncating second to 0 bytes.
/0005
  File size is 4 bytes, cluster chain length is 0 bytes.
  Truncating file to 0 bytes.
Performing changes.
/dev/sbd0: 5 files, 4/8167 clusters

This causes file /0005 to be truncated to 0.

-Junfeng

