Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWHRKst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWHRKst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWHRKst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:48:49 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:3503 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751354AbWHRKss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:48:48 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.39394.504082.975709@gargle.gargle.HOWL>
Date: Fri, 18 Aug 2006 14:43:46 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, David Chinner <dgc@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow writeback.
Newsgroups: gmane.linux.kernel
In-Reply-To: <20060817224952.e418c669.akpm@osdl.org>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<1155818179.5662.19.camel@localhost>
	<20060817081415.f48fbb37.akpm@osdl.org>
	<1155831779.5620.15.camel@localhost>
	<20060817224952.e418c669.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000046 283252a83b1f50a3af86e2f46a6ca109
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

[...]

 > 
 > The way this code all works is pretty crude and simple: a process comes
 > in to to some writeback and it enters a polling loop:
 > 
 > 	while (we need to do writeback) {
 > 		for (each superblock) {
 > 			if (the superblock's backing_dev isn't congested) {
 > 				stuff some more IO down it()
 > 			}
 > 		}
 > 		take_a_nap();
 > 	}
 > 
 > so the process remains captured in that polling loop until the
 > dirty-memory-exceed condition subsides.  The reason why we avoid

Hm... wbc->nr_to_write is checked all the way down
(balance_dirty_pages(), writeback_inodes(), sync_sb_inodes(),
mpage_writepages()), so "occasional writer" cannot be stuck for more
than 32 + 16 pages, it seems.

Nikita.

