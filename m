Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUCROCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 09:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUCROCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 09:02:17 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28165 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262644AbUCROCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 09:02:15 -0500
Message-ID: <000701c40cf3$014e4730$0801a8c0@ostehaps>
From: "David Dindorp" <david@dindorp.dk>
To: <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Status HPT374 (HighPoint 1540) Sata in 2.6
Date: Thu, 18 Mar 2004 15:12:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bit of personal experience using HPT374-based controllers.
May or may not apply, as mine are all PATA RocketRaid 404's!

Bartlomiej Zolnierkiewicz / Mike Fedyk wrote:

bz>> I think that it may work with drivers/ide/hpt366.c

It (HPT374) does.

mf> Does that limit you to 133MB/s speeds?
mf> And does that mean no hot-swap?

The controller itself limits you to 133MB/s speeds, except for one channel
per controller, which mysteriously always runs at 100MB/s. Benchmarks found
on the net however suggest that this particular controller is in fact very
fast...

RAID1 arrays seem to work fine. RAID0 arrays created with an old BIOS version
works fine, but don't create the array with a new BIOS version. HighPoint has
apparently moved the RAID signature, and the ataraid module doesn't know where
to. Only applies if you want to use the HPT raid function with ataraid.

If you want hot swap, you will need to use the HighPoint supplied driver. The
newest version I found last time checking was compiled against 2.4.20-8. It
comes with a BIOS flash image, which you should use - it will leave you with
a smaller amount of bizarre, unexplained errors. Although the error messages
that you DO in fact get from the proprietary driver will be in an arcane and
cryptic language, which will not contain any reference to where or why the
error occured, only that the driver did a bus reset plus one seemingly random
integer.

There's a BIOS limitation of 2 HPT374 controllers per system. Last time I
spoke with HighPoint, that was because any more than two controllers would
consume an excessive amount of memory for Option ROM's. (Also, you would most
probably run into the PCI bandwidth barrier.) The proprietary driver will
save you a lot of trouble if you go for 2 controllers and a 2.4 kernel,
because 2.4 has a limitation of 10 IDE channels (2x HPT374 = 8).

I'm not sure exactly why the HighPoint driver supports hot swap, and
linux-ide does not. I've tried patching linux-ide to do hot swap, to some
extent of success, but gave up as I have no clue *exactly* what is required
to make the magic work. I'm interested, if anyone knows.

Regarding technical support on the card. Support from HighPoint through
email won't get you anywhere. Based on personal experience and postings
on usenet, they do not reply to support emails. Calling them on the phone
will in most cases give you someone quite competent to speak with. 
I suspect it might be the engineers who create these cards that you get
to bother, which gives the added advantage that they actually know what
they're talking about.

