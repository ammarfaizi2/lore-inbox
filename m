Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130970AbRBPWoN>; Fri, 16 Feb 2001 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131177AbRBPWoC>; Fri, 16 Feb 2001 17:44:02 -0500
Received: from sub19-210.member.dsl-only.net ([63.105.19.210]:12548 "HELO
	thalvors.miralink.com") by vger.kernel.org with SMTP
	id <S130970AbRBPWnq>; Fri, 16 Feb 2001 17:43:46 -0500
Date: Fri, 16 Feb 2001 14:43:33 -0800 (PST)
From: Tracy Camp <campt@thalvors.miralink.com>
To: linux-kernel@vger.kernel.org
Subject: Assistance in understanding this...?
Message-ID: <Pine.LNX.4.21.0102161433340.582-100000@thalvors.miralink.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm developing a driver that performs some 'formatting' of sorts on a scsi
block device as part of the initialization process.  This involves
writting a long series of non-contiguous blocks to a disk device -
something akin to:

for(i =0; i < NUM_BLOCKS; i++) {
	bh = getblk(i * offset_size);
	memcpy(bh->b_data,&somestructure,sizeof(struct somestruct));
	mark_buffer_dirty(bh);
	ll_rw_block(bh, WRITE,1);
	wait_on_buffer(bh);
	brelse(bh);
	}

the kernel here I should mention is stock 2.4.0

This all works fine it seems, except that after awhile the system becomes
very fragile and eventually panic's with a NULL pointer derefrence.  This
presumeably occurs because of a resource shortage.  Thing I'm not
understand is how doing the above even for a large value of NUM_BLOCKS
creates a resource shortage.  I'm obviously missing something here....

This is typically triggered by running any external program, (ie. vi, top,
or gcc seem to work fine for this). and the only noticable thing is that
the memory allocated to buffers grows to be pretty much all memory except
for the last two megs - this seems normal?  I can capture some of the
panic/dumps if anyone thinks they might be of interest.  

Ideas?

t.

Tracy Camp
Product Development
Miralink Corp.PDX
Portland OR
503-223-3140

