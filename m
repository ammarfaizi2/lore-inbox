Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbRGUROO>; Sat, 21 Jul 2001 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267754AbRGURNy>; Sat, 21 Jul 2001 13:13:54 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:8205 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S267750AbRGURNs>;
	Sat, 21 Jul 2001 13:13:48 -0400
Date: Sat, 21 Jul 2001 10:13:52 -0700 (PDT)
From: Paul Buder <paulb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Large ramdisk crashes system with 2.4.7
Message-ID: <Pine.LNX.4.33.0107211011540.15892-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

A large ramdisk will crash the system with kernel 2.4.7.  This is a
128 meg system with a lilo parameter of 'ramdisk=100000', an ext2 fs
on /dev/ram0 created with 80 megs and an attempted dd from /dev/zero
of 60 megs.  I reported this for 2.4.5 and 2.4.6 also.  I notice that
bdflush is looping through the same eight functions about forty times at
the time of the crash which can't be a good thing.  Here is the ksymoops
output for bdflush.


Trace; c012a3fd <__alloc_pages+109/278>
Trace; c012a2f2 <_alloc_pages+16/18>
Trace; c01333c2 <grow_buffers+3e/18c>
Trace; c01315c4 <refill_freelist+1c/50>
Trace; c01315d0 <refill_freelist+28/50>

# Starts looping here

Trace; c0131ab4 <getblk+158/16c>
Trace; c017d5e2 <rd_make_request+72/f4>
Trace; c0175f4c <generic_make_request+110/11c>
Trace; c0175fb2 <submit_bh+5a/74>
Trace; c01761bb <ll_rw_block+1ef/260>
Trace; c01338fa <flush_dirty_buffers+9e/e4>
Trace; c013396e <wakeup_bdflush+2e/34>
Trace; c01315de <refill_freelist+36/50>

# Round two

Trace; c0131ab4 <getblk+158/16c>
Trace; c017d5e2 <rd_make_request+72/f4>
Trace; c0175f4c <generic_make_request+110/11c>
Trace; c0175fb2 <submit_bh+5a/74>
Trace; c01761bb <ll_rw_block+1ef/260>
Trace; c01338fa <flush_dirty_buffers+9e/e4>
Trace; c013396e <wakeup_bdflush+2e/34>
Trace; c01315de <refill_freelist+36/50>


