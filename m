Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbUBEPXW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbUBEPXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:23:22 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:60032 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265290AbUBEPXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:23:08 -0500
Date: Thu, 5 Feb 2004 16:23:04 +0100 (MET)
From: Mattias Wadenstein <maswan@acc.umu.se>
To: linux-kernel@vger.kernel.org
Subject: Performance issue with 2.6 md raid0
Message-ID: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

While testing a file server to store a couple of TB in resonably large
files (>1G), I noticed an odd performance behaviour with the md raid0 in a
pristine 2.6.2 kernel as compared to a 2.4.24 kernel.

When striping two md raid5:s, instead of going from about 160-200MB/s for
a single raid5 to 300M/s for the raid0 in 2.4.24, the 2.6.2 kernel gave
135M/s in single stream read performance.

The setup:
2 x 2.0 GHz Opteron 248, 4 gigs of ram (running 32-bit kernels)
2 x 8-port 3ware sata raid cards, acting as disk controllers (no hw raid)
16 x Maxtor 250-gig 7k2 rpm sata drives.
1 x system drive on onboard pata doing pretty much nothing.

The sata drives are configured in 2 8-disk md raid5s, not hw raid for
performance reasons, we get better numbers from the md driver in that case
than the hw raid on the card. Then I have created a raid0 of these two
raid5 devices.

I used jfs for these numbers, I have only seen minor differences in speed
in the single-stream case on this hardware though for different
filesystems I have tested (ext2, xfs, jfs, reiserfs). And the filesystem
numbers are reflected pretty close by doing a dd from /dev/md10. The same
goes for increasing the chunk-size to 4M instead of 32k, roughly the same
numbers. The system is not doing anything else.

The results (as meassured by bonnie++ -f -n0, all numbers in kB/s, all
numbers for a single stream[*]):
2.4.24, one of the raid5s: Write: 138273, Read: 212474
2.4.24, raid0 of two raid5s: Write: 215827, Read: 303388
2.6.2, one of the raid5s: Write: 159271, Read: 161327
2.6.2, raid0 of two raid5s: Write: 280691, Read: 134622

It is the last read value that really stands out.

Any ideas? Anything I should try? More info wanted?

Please Cc: me as I'm not a subscriber to this list.

[*]: For multiple streams, say a dozen or so readers, the aggregate
performance on the 2.6.2 raid0 went down to about 60MB/s, which is a bit
of a real performance problem for the intended use, I'd like to at least
saturate a single gigE interface and hopefully two with that many readers.

/Mattias Wadenstein
