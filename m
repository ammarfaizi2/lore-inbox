Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273974AbRISAaN>; Tue, 18 Sep 2001 20:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273975AbRISAaE>; Tue, 18 Sep 2001 20:30:04 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:19786 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S273974AbRISA3v>; Tue, 18 Sep 2001 20:29:51 -0400
Date: Tue, 18 Sep 2001 17:34:43 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Request for new block_device_operations function pointer
In-Reply-To: <Pine.GSO.4.21.0109181748350.27538-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0109181727111.27510-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Alexander Viro wrote:
|>On Tue, 18 Sep 2001, Matt D. Robinson wrote:
|>
|>> This would allow projects such as LKCD to use a specific dump
|>> device associated to a block device driver.  This dump driver
|>> writes data out directly to disk at a specific offset.  The
|>
|>... while submit_bh()... writes data out directly to disk at a specific
|>offset.  Amazing, isn't it?
|>
|>Notice that you _will_ need to deal with IO in driver's queue, no matter
|>how you implement the thing.  submit_bh() already does it.

... and deals with interrupt state, and any special device
requirements?  Actually, we don't want to deal with any
outstanding I/O.  You don't want to flush any outstanding
requests if you're crashing (which is what LKCD is for).
Sure, submit_bh() when things are running fine.  But not when
you're crashing.  And also, this is intended at some point in
the future to work to raw devices as well.

I don't want to deal with b_end_io(), blk_get_queue(),
generic_make_request() or any of that stuff.  This is
supposed to be raw data to the disk.

Again, the point here is to create a device operation that
allows the driver to enter a dumping state and write out
data raw to the device.  It's not intended for the normal
block operations path.

Thanks,

--Matt

