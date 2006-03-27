Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWC0VF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWC0VF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWC0VF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:05:27 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:23206 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751217AbWC0VF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:05:27 -0500
Date: Mon, 27 Mar 2006 23:05:14 +0200
To: linux-kernel@vger.kernel.org
Subject: Hanging ext3 or USB, linux 2.6.16-rc6-mm2
Message-ID: <20060327210514.GA24421@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to hang ext3 or usb today.
I have a small machine that boot off a compactflash card.
I want to use a bigger card, so I used scp to copy everything
from that machine to a new 4GB card in a usb cardreader.
This cardreader have never given me trouble before, but is
usually used for reading.

I decided on a ext3 fs in order to avoid long fsck runs,
and a minimal 4MB journal in order to not waste space.
Disk seeks are supposed to be really cheap on a device
with no moving parts anyway.  The root reserved percentage
is 1% instead of the usual 5% - more space, and fragmentation
will probably not hurt much with cheap seeks.

When scp had filled the card to 71% of capacity (according to df), 
it stopped in the middle of a file.  I first suspected network
errors, but a "ls /mnt" hung.

I now have the following processes in D-state:
[khubd] [scsi_eh_4] [usb-storage] [kjournald] scp,
3 x [pdflush], 2 x ls, lsusb, and a sync.

Could this be a ext3 problem due to the small journal or something?

Or is a usb problem more likely? "Dmesg" shows an
usb disconnect sometime after I mounted that filesystem,
but it seems to be usblp0 which looks like the printer to me.

Helge Hafting
