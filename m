Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbTIJSD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTIJSD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:03:57 -0400
Received: from hstntx01.bsius.com ([64.246.32.38]:25031 "EHLO mx1.bsius.com")
	by vger.kernel.org with ESMTP id S265319AbTIJSDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:03:55 -0400
From: "Bill Church" <bill@bsius.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: PIIXn DMA errors
Date: Wed, 10 Sep 2003 14:03:52 -0400
Organization: Bayside Solution, Inc.
Message-ID: <000601c377c5$e4c11e70$6900000a@bsi000>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reposting this because I never saw it come through, if it's
duplicate I apologize in advance... Also, I saw *some* mention about a
similar issue in the archives which mentioned that 2.4.22 would fix this
problem, but doesn't seem to work for me. :(

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

