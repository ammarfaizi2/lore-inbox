Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVHKUyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVHKUyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVHKUyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:54:50 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49320 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932353AbVHKUyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:54:49 -0400
Message-ID: <42FBBB10.9020407@pobox.com>
Date: Thu, 11 Aug 2005 16:54:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>
Subject: libata PATA todo list
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.5 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Since there's been some recent interest in the subject,
	I thought I would post the PATA todo list for libata. Some of these
	items are from my memory, and some are from a list Alan was kind enough
	to create. The items verbatim from Alan are prefixed "Alan: ". [...] 
	Content analysis details:   (0.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since there's been some recent interest in the subject, I thought I 
would post the PATA todo list for libata.  Some of these items are from 
my memory, and some are from a list Alan was kind enough to create.  The 
items verbatim from Alan are prefixed "Alan: ".


1) Locked device/host speed

To support devices such as those in the ide/pci/generic.c list, we need 
to ensure that libata -never- attempts to change the device speed 
(ata_dev_set_xfermode should be avoided).


2) Simplex DMA

PCI IDE specification has a 'simplex' DMA bit, which should be tested. 
Simplex means that only one command can be outstanding, for BOTH port0 
and port1, at any given time.

Possibly some hosts also need Simplex DMA, but may not assert the 
standard PCI IDE Simplex DMA capability bit.  I don't know.


3) Speed change on error

Downshift device to a slower UDMA speed, and eventually from DMA->PIO, 
as errors persist.  There is no 'specified way' to do this, this is 
purely hueristic.


4) Alan:  Command filter

Alan -- explanation?

I know one line item here, at least:  Promise controllers snoop SET 
FEATURES - XFER MODE command.  We must stop command processing on ALL 
ports when this command is issued, to avoid corruption.


5) Alan:  MWDMA broken still?  is piix doc correct?


6) Alan:  some PATA LBA48 devices cannot do > 256 sectors.


7) Alan:  Some ALi requires LBA48 be done via PIO.  LBA28 DMA is OK.


8) ATAPI device CDB interrupt

Some older ATAPI devices require the OS driver to wait for an interrupt, 
after CDB is written, before command processing proceeds.


9) ATAPI devices may delay setting DRQ=1 for up to 3ms.

Make sure we honor the delay noted in IDENTIFY PACKET DEVICE word 0.


10) ATAPI DMA alignment (discussed elsewhere)

Needed even for PATA, AFAICT.



