Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQL0LaB>; Wed, 27 Dec 2000 06:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQL0L3w>; Wed, 27 Dec 2000 06:29:52 -0500
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:43498 "EHLO
	fw-cam.cambridge.arm.com") by vger.kernel.org with ESMTP
	id <S129428AbQL0L3j>; Wed, 27 Dec 2000 06:29:39 -0500
Message-Id: <4.3.2.7.2.20001227105214.00beaf00@cam-pop.cambridge.arm.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 27 Dec 2000 10:59:09 +0000
To: Felix von Leitner <leitner@convergence.de>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@arm.com>
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001226002944.A6058@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:29 PM 12/25/00, you wrote:
>To verify that this is not an issue of the Promise controller, I started
>two instances of my test tool at the same time, one working on hde, the
>other on hdg (the two channels).  Both yielded approximately 25 meg/sec,
>so it does not appear to be a hardware or driver issue.  Is the RAID
>code really this slow?  Any ideas what I can do?

Use two PDC controller cards. You have shown that you can read 50MB/s from 
disks into memory, and so neither the IDE not PCI bus is overloaded. 
However, the RAID code is contending for control of the IDE busses because 
it is not optimized for the case that the disks cannot be controlled 
independently.

>By the way: I noticed another thing: one of the Maxtor hard disks was
>broken.  It caused the whole box to freeze solid (no numlock, no console
>switches, no sysrq).  That to me severely limits the usefulness of IDE

Did you not read the RAID FAQ? look on the raidtools web site: it 
specifically states:

a) you cannot hot swap IDE
b) if you put RAID disks on the same IDE bus (i.e. use master/slave) you 
can expect abysmal performance. Only use the master for a given IDE bus 
(i.e. the PDC supports 2, not 4, disks).

>RAID.  While SCSI problems cause trouble, too, I have never seen one
>cause a complete freeze.  How am I supposed to hot-swap the disks?

On IDE, you don't. IDE never supports hot-swap, RAID or no. If you want 
that, use SCSI.

Regards,

Ruth

-- 

Ruth 
Ivimey-Cook                       ruthc@sharra.demon.co.uk
Technical 
Author, ARM Ltd              ruth.ivimey-cook@arm.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
