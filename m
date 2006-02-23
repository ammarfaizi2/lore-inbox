Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWBWQ0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWBWQ0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWBWQ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:26:05 -0500
Received: from wb6-a.mail.utexas.edu ([128.83.126.144]:36367 "EHLO
	wb6-a.mail.utexas.edu") by vger.kernel.org with ESMTP
	id S1751677AbWBWQ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:26:03 -0500
Message-ID: <43FDE216.9000802@mail.utexas.edu>
Date: Thu, 23 Feb 2006 08:25:58 -0800
From: Philip Langdale <philipl@mail.utexas.edu>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: CRC errors with sata drives connected to ULi M5281
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I happen to have a motherboard with an onboard M5281
controller that provides extra sata and pata ports.
Up until now, I've never had a use for it, but I've
been trying to use it with some spare drives I now
have, and it's been resulting in errors while reading
from the drive, and the system locks up with a sufficiently
long sustained transfer.

I observe identical behaviour with 2.6.15.4 and 2.6.16-rc4,
which doesn't really surprise me as the uli driver is basically
unchanged between them.

My symptoms appear identical to the ones described here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1378.html

> ata13: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata13: status=0x51 { DriveReady SeekComplete Error }
> ata13: error=0x84 { DriveStatusError BadCRC }

In my case, I have a uniprocessor preempt kernel.

I have tried with maxtor and hitachi drives which both work
fine when connected to a via vt6421 controller card that I
also have.

Interestingly, the frequency of BadCRC errors seems to be
inversely related to the transfer speed. I tried forcing
it to use PIO for transfers and this caused a significant
increase in the number of errors reported. In fact, it
seemed to me that more errors were reported with the hitatchi
vs. the maxtor and those report themselves as udma/100 and
udma/133 respectively.

I'm rather out of ideas for what to do next, and I'd really
like to be able to take advantage of this controller if I can.

Thanks,

--phil
