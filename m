Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310782AbSCMQhn>; Wed, 13 Mar 2002 11:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310783AbSCMQhf>; Wed, 13 Mar 2002 11:37:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27411 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310782AbSCMQhQ>; Wed, 13 Mar 2002 11:37:16 -0500
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 13 Mar 2002 16:51:49 +0000 (GMT)
Cc: adam@yggdrasil.com (Adam J. Richter), linux-kernel@vger.kernel.org
In-Reply-To: <20020312234256.B13558@flint.arm.linux.org.uk> from "Russell King" at Mar 12, 2002 11:42:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lByf-0006ph-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe changes to NCR53c80 were recently reverted back because
> these "fixes" lead to massive data corruption.  It is preferable
> that the driver remains unbuildable, and therefore doesn't cause
> data corruption than to be buildable and case data corruption.

Someone "fixed" the 2.5 one by just frobbing randomly with the
io_request_lock without noticing its not always used per queue in the driver
(study the host list code - and dont think you can just clean that up by
 using SHIRQ - that wont help on some non x86 stuff). I fed Dave Jones
the 2.4 stuff where the locking is fixed (tho using io_request_lock) and
actually works SMP.

Dave then I suspect fed it to Linus
