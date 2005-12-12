Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVLLHPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVLLHPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVLLHPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:15:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:18133 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751118AbVLLHPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:15:34 -0500
Subject: Memory corruption & SCSI in 2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Brian King <brking@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 18:13:26 +1100
Message-Id: <1134371606.6989.95.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Current -git as of today (that is 2.6.15-rc5 + the batch of fixes Linus
pulled after his return) was dying in weird ways for me on POWER5. I had
the good idea to activate slab debugging, and I now see it detecting
slab corruption as soon as the IPR driver initializes.

Since I remember seeing a discussion somewhere on a list between Brian
King and Jens Axboe about use-after-free problems in SCSI and possible
other niceties of that sort, I though it might be related...

Anything I can do to help track this down ?

ipr: IBM Power RAID SCSI Device Driver version: 2.1.0 (October 31, 2005)
ipr 0000:c0:01.0: Found IOA with IRQ: 99
ipr 0000:c0:01.0: Starting IOA initialization sequence.
ipr 0000:c0:01.0: Adapter firmware version: 020A004E
ipr 0000:c0:01.0: IOA initialized.
scsi0 : IBM 570B Storage Adapter
Slab corruption: start=c000000070de39a0, len=728
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c0000000002297c4>](.blk_cleanup_queue+0xe4/0x170)
1d0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00
2b0: 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=c000000070de36b0, len=728
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<0000000000000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c000000070de3c90, len=728
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c000000000227b00>](.blk_alloc_queue_node+0x30/0x90)

Ben.

