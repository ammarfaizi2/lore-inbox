Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbSLRU10>; Wed, 18 Dec 2002 15:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbSLRU10>; Wed, 18 Dec 2002 15:27:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:27583 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267385AbSLRU1Z>;
	Wed, 18 Dec 2002 15:27:25 -0500
Message-ID: <3E00DC07.7729E6A2@digeo.com>
Date: Wed, 18 Dec 2002 12:35:19 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Macaulay <robert_macaulay@dell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.47 - Assertion failed in fs/jbd/journal.c:415
References: <Pine.LNX.4.44.0212181301480.15962-100000@ping.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 20:35:19.0247 (UTC) FILETIME=[FAE64DF0:01C2A6D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Macaulay wrote:
> 
> We were performing an IO performance test on 2.5.47. The storage we were
> writing to was a Fibre Channel array(dell 650f) via qlogic 2200 cards
> using the qlogicfc driver in the Linux kernel. There were 8 separate LUNS
> on the FC array, each of which has an ext3 filesystem on them. There are
> no partition tables on the disks(one of the disks would not accept one,
> separate issue). The ext3 filesystem was created directly on the block
> devices, /dev/sdf /dev/sdg etc. The server is a Dell Poweredge 6650, 4
> procs, 8Gig RAM. More detailed system information is appended at the
> bottom.
> 
> For now, the test was 100% writing to all 8 filesystems in parallel. The
> following BUG was reported halfway through the 4th run of this test. I'm
> not sure how reproducible this is.
> 
> The machine is still running. IO in progress at the time of the BUG has
> stopped in D state, New IO is stil possible though to the disks. I will
> leave the system up and running if there is any more info needed for a few
> days.
> 
> I will be trying a more recent version in a few days. 2.5.47 was the
> latest kernel I could compile at the time. I've looked through the
> archives, but could not find any mention of this particular bug, so I do
> not know if it has been addressed or not. Thanks
> 
> Assertion failure in journal_write_metadata_buffer() at fs/jbd/journal.c:415: "buffer_jdirty(jh2bh(jh_in))"

I can't immediately see what would cause this.  There is code in
__journal_file_buffer which could have triggered this, but we should
have exclusion from that via both lock_kernel() and lock_journal().

I'll see if Stephen can spot it.   I shall assume you were using
the data-ordered journalling mode.
