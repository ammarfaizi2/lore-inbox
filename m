Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTFDQ6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 12:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbTFDQ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 12:58:41 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:62598 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S263600AbTFDQ6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 12:58:39 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm4
References: <20030603231827.0e635332.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 04 Jun 2003 19:14:42 +0200
In-Reply-To: <20030603231827.0e635332.akpm@digeo.com>
Message-ID: <871xy9hiil.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
> 
> . There have been one or two reports of -mm3 getting stuck in
>   get_request_wait() against CDROMs.  If anyone sees that, or was seeing it
>   in -mm3 and does not see it in -mm4, please let us know.
> 

One of those came from me. Its better than what I've had before. I've
tinkered a bit, with and without debugging and ide-scsi, and I still
managed to get it to blow up. But I no longer see the insane loads
I've had on earlier kernels.

Attached is the output from a sesison with copying from CDs to the USB
drive with no ide-scsi, and i've put a comment it where it seems to
fall over:

usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b c3 2f 4f 00 04 00 00
usb-storage: Bulk command S 0x43425355 T 0x9a7 Trg 0 LUN 0 L 524288 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
usb-storage: Status code 0; transferred 524288/524288
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x9a7 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b c3 33 4f 00 04 00 00
usb-storage: Bulk command S 0x43425355 T 0x9a8 Trg 0 LUN 0 L 524288 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 127 entries
usb-storage: Status code 0; transferred 524288/524288
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
-- here
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: usb_storage_command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB
usb-storage: Status code -104; transferred 0/13
usb-storage: -- transfer cancelled
usb-storage: Bulk status result = 3
usb-storage: -- command was aborted
usb-storage: Bulk reset requested
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
usb-storage: Soft reset: clearing bulk-in endpoint halt
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=88 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Soft reset: clearing bulk-out endpoint halt
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=02 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Soft reset done
usb-storage: scsi command aborted
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0x9a8 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x9a8 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
