Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUCIOHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 09:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUCIOHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 09:07:43 -0500
Received: from mail.humboldt.co.uk ([81.2.65.18]:20714 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S261951AbUCIOHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 09:07:25 -0500
Subject: cdromaudio patch gives up too easily
From: Adrian Cox <adrian@humboldt.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Content-Type: text/plain
Message-Id: <1078841242.995.24.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 14:07:23 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch for DMA based CD reading worked well for me until I tried to
read the audio from a badly damaged CDR.  At this point the code dropped
back to the old mechanism and stayed that way for further CDs.

The logs below show what happened, running 2.6.4-rc2 with just that
patch:

cdrom: open failed.
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x30
ATAPI device hdc:
  Error: Medium error -- (Sense key=0x03)
  (reserved error code) -- (asc=0x57, ascq=0x00)
  The failed "Prevent/Allow Medium Removal" packet command was:
  "1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
cdrom: open failed.
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x30
ATAPI device hdc:
  Error: Medium error -- (Sense key=0x03)
  (reserved error code) -- (asc=0x57, ascq=0x00)
  The failed "Prevent/Allow Medium Removal" packet command was:
  "1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
cdrom: cdda rip sense 03/02/00
cdrom: dropping to old style cdda
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x30
ATAPI device hdc:
  Error: Medium error -- (Sense key=0x03)
  (reserved error code) -- (asc=0x02, ascq=0x00)
  The failed "Read CD" packet command was:
  "be 04 00 00 00 00 00 00 08 f8 00 00 00 00 00 00 "

... and the above pattern eventually becomes this:
ide-cd: cmd 0xbe timed out
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
ide-cd: cmd 0xbe timed out
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: ATAPI reset complete
ide-cd: cmd 0xbe timed out
hdc: irq timeout: status=0xd0 { Busy }
hdc: irq timeout: error=0xd0LastFailedSense 0x0d
hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0xd0LastFailedSense 0x0d
hdc: drive not ready for command
hdc: ATAPI reset complete

At some point in the sequence I killed grip and ejected the CD.

- Adrian Cox


