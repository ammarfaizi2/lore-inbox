Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUJXG5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUJXG5u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 02:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbUJXG5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 02:57:50 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:32006 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S261378AbUJXG5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 02:57:48 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: XFS strangeness, xfs_db out of memory
Date: Sun, 24 Oct 2004 08:57:26 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410240857.31893.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was testing a tiny script on top of xfs_fsr to show fragmentation and the 
resultss of defragmentation.  As a result of fine tuning the output I ran the 
script repeatedly and suddenly got error from find (unknown error 999 if my 
memory serves me. It scrolled off the screen).

The logs show this.
Oct 24 08:06:50 xine kernel: hda: dma_timer_expiry: dma status == 0x21
Oct 24 08:07:00 xine kernel: hda: DMA timeout error
Oct 24 08:07:00 xine kernel: hda: dma timeout error: status=0xd0 { Busy }
Oct 24 08:07:00 xine kernel: 
Oct 24 08:07:00 xine kernel: hda: DMA disabled
Oct 24 08:07:00 xine kernel: ide0: reset: success

How bad is that for XFS?... The error isn't permanent it seems.

After that xfs_db -r /dev-with-home -c "frag -v" gives me an out-of-memory
error after a while, consistently.

xfs_db: out of memory

The script essentially does  this

xfs_info $dev
xfs_db -r $dev -c "frag -v"
find $mountp
xfs_fsr -v

Program versions
kernel is 2.6.8.1-12mdk (Mandrake 10.1 Community edition)
xfsdump-2.2.21-1mdk
xfsprogs-2.6.13-1mdk

xfs_repair had lots of comments after this, but went through.

-- robin
