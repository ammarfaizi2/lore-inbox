Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbVJZOsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVJZOsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 10:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVJZOsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 10:48:35 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:31684 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S932613AbVJZOse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 10:48:34 -0400
Message-ID: <435F9737.3050409@emc.com>
Date: Wed, 26 Oct 2005 10:48:23 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eugene Crosser <crosser@rol.ru>
CC: linux-ide@vger.kernel.org, multiman@rol.ru, linux-kernel@vger.kernel.org
Subject: Status of Marvell SATA driver (was Re: Trying latest sata_mv - and
 getting freeze)
References: <435F8AFF.3030404@rol.ru>
In-Reply-To: <435F8AFF.3030404@rol.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.10.26.12
X-PerlMx-Spam: Gauge=, SPAM=1%, Reasons='EMC_FROM_00+ -3, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Crosser wrote:
> My hardware is SMP Supermicro with 6 disks on
> Marvell MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
> and the sata_mv.c is version 0.25 dated 22 Oct 2005
> 
> The thing works with "old" mvsata340 driver, but the "new" kernel with
> your driver freezes when it starts to probe disks.  Even Magic SysRq
> does not work.  The last lines I see on screen are like this:
> 
> sata_mv version 0.25
> ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 185
> sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via MSI
> ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 185
> ata2: .... <same things>            0xF8C24120 ...
> ...
> ata8: .... <same thing>             0xF8C38120 ...
> ATA: abnormal status 0x80 on port 0xF8C2211C
> ... <five more lines identical to the above>
> ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
> 
> - and at this point it freezes hard.
> Any suggestions for me?  Any information I can collect to help
> troubleshooting?

Hey Eugene,

Thanks for the bug report.  Here's the story on the Marvell SATA driver. 
  We have custom hardware here with integrated 6081 controllers and a 
uniprocessor board.  The driver was developed and tested solely on that 
platform and works very well for me.  However, I haven't had the time to 
try it on normal 6xxx or 5xxx HBA cards (like everyone else in the world 
is using) or on an SMP system.  It's been something I've been meaning to 
do for some time now.

Compounded with that, I've decided to leave my current position to 
pursue my career at another company (still doing Linux kernel 
development but in a different area).  Thus, I will be less focused on 
the driver and might not have access to HW and specifications.  I know 
there are others on this list who do have both of those necessary 
requirements for development so it's possible they can help pick up the 
slack.

In the meantime, try turning off SMP and seeing if that makes a 
difference.  There still might be a problem with the spinlocks and if so 
it should go away in uniprocessor mode.

Thanks for your interest,
BR
