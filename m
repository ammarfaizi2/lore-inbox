Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285210AbRL2Set>; Sat, 29 Dec 2001 13:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285186AbRL2Sei>; Sat, 29 Dec 2001 13:34:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12562 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285193AbRL2Se1>; Sat, 29 Dec 2001 13:34:27 -0500
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
To: harald.holzer@eunet.at (Harald Holzer)
Date: Sat, 29 Dec 2001 18:45:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <1009649897.12942.2.camel@hh2.hhhome.at> from "Harald Holzer" at Dec 29, 2001 07:18:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KOTk-0005F3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there some i686 SMP systems with more then 12 GB ram out there ?

Very very few.

> Is there a known problem with 2.4.x kernel and such systems ?

Several 8)

Hardware limits:
	-	36bit addressing mode on x86 processors is slower
	-	Many device drivers cant handle > 32bit DMA
	-	The CPU can't efficiently map all that memory at once

Software:
	-	The block I/O layer doesn't cleanly handle large systems
	-	The page struct is too big which puts undo loads on the
		memory that the CPU can map
	-	We don't discard page tables when we can and should
	-	We should probably switch to a larger virtual page size
		on big machines.

The ones that actually bite hard are the block I/O layer and the page
struct size. Making the block layer handle its part well is a 2.5 thing.

> It looks like as the buffer_heads would fill the low memory up,
> whether there is sufficient memory available or not, as long as
> there is sufficient high memory for caching.

That may well be happening. The Red Hat supplied 7.2 and 7.2 errata kernels
were tested on 8Gb, I don't know what else larger.

Because much of the memory cannot be used for kernel objects there is an
imbalance in available resources and its very hard to balance them sanely.
I'm not sure how many 8Gb+ machines Andrea has handy to tune the VM on
either.

Alan
