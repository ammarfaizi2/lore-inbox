Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTIIXj0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTIIXj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:39:26 -0400
Received: from hstntx01.bsius.com ([64.246.32.38]:5814 "EHLO mx1.bsius.com")
	by vger.kernel.org with ESMTP id S264292AbTIIXjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:39:16 -0400
From: "Bill Church" <bill@bsius.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.2x kernel + ICH4 DMA errors
Date: Tue, 9 Sep 2003 19:39:12 -0400
Organization: Bayside Solution, Inc.
Message-ID: <001a01c3772b$92fba410$6900000a@bsi000>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a GigaByte GA-8IGX with an Intel 845G chipset.

Two new Hitachi 180GXP 80G DeskStar drives. Both set as master on two
ATA/100 channels (/dev/hda and /dev/hdc).

P4 2.53 Processor at 533FSB

2 Sticks of 512MB Corsair 333MHz DDR Ram

My issue:

Started out with Gentoo gs-sources Kernel (2.4.22_pre2-gss). When I
would boot with both drives connected, /dev/hdc would timeout and hang
when enumerating the partitions. If I disabled DMA, the system would
boot with out error. I disabled ACPI also, but that seemed to have no
effect.

I reverted to the vanilla-sources Kernel (2.4.22) with the same config
file and experienced the same results. However, /dev/hdc would time out
several times but no hang. Upon investigation I found that /dev/hda had
DMA enabled but /dev/hdc had DMA disabled. So with hdparm I enabled dma
on /dev/hdc and tried some operations on that drive. Just an fdisk
/dev/hdc produced timeouts. Checking hdparm again on /dev/hdc revealed
that it was again disabled.

I then tried setting both drives on the same channel, manually setting
master on one drive and slave on another. Same issues as before. I also
tried swapping cables and drive positions. Moving /dev/hdc drive to
/dev/hda and vice-versa.

So I decided to revert to 2.4.20, I experienced the same results as did
originally (time out on /dev/hdc to lockup).

I then decided to try 2.6.0-test4, same results...

I am using 80 conductor 40 pin ATA-100 cables. And I'm using the PIIXn
option under ATA/IDE/MFM/RLL support.

Thanks in advance...

-Bill
bill at bsius dot com

