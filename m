Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTKWQEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 11:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTKWQEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 11:04:53 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:50561 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262126AbTKWQEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 11:04:52 -0500
X-Sender-Authentication: net64
Date: Sun, 23 Nov 2003 17:04:46 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem Report: 2.4.23-rc2, ide, dma settings
Message-Id: <20031123170446.7c70439e.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I just found out that either I did not understand what the "keepsettings" flag
in hdparm is meant to be, or it does not work as expected. Situation is as
follows:

Trying to record DVDs with a SONY DRU-500A connected to

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)

I do "hdparm -k1 -d1 /dev/hdc" and see:

/dev/hdc:
 setting using_dma to 1 (on)
 setting keep_settings to 1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)

Then I try recording, but something bad happens:

Nov 23 16:36:50 box kernel: scsi : aborting command due to timeout : pid
5977459, scsi3, channel 0, id 0, lun 0 UNKNOWN(0x54) 01 00 00 00 00 00 00 00 00

Nov 23 16:36:50 box kernel: hdc: irq timeout: status=0xd0 { Busy }
Nov 23 16:36:50 box kernel: hdc: ATAPI reset complete

And after that:

# hdparm /dev/hdc

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  1 (on)
 readonly     =  0 (off)
 BLKRAGET failed: Invalid argument
 HDIO_GETGEO failed: Invalid argument

DMA is off. Is this expected? Recording btw _continues_, only without DMA. This
happens during high load situations...

Regards,
Stephan

