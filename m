Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbQKVAR6>; Tue, 21 Nov 2000 19:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130022AbQKVARu>; Tue, 21 Nov 2000 19:17:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31316 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129692AbQKVARl>; Tue, 21 Nov 2000 19:17:41 -0500
Subject: Re: 53c400 driver
To: maillist@chello.nl (Igmar Palsenberg)
Date: Tue, 21 Nov 2000 23:48:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel devel list)
In-Reply-To: <Pine.LNX.4.21.0011220019220.25688-100000@server.serve.me.nl> from "Igmar Palsenberg" at Nov 22, 2000 12:27:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yN98-0005N6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 53c400a non-PNP still lock this system hard. It starts barking about a
> busy SCSI bus, and then I can fsck again.
> 
> To Alan : How hard is it to get thing beast (53c400 and family) to be SMP
> safe ?? Or is it better to start over again ?

The problem is that the code takes spinlocks recursively. The original
code (see 2.0's 5380 generic C code) uses cli/sti. It was converted to
use spin_lock() but not allowing for the recursive locking cases. I tried
to untangle the code paths but they are so ugly and some of the code is
sufficiently messy and unmaintained (for about 6 years) that I gave up
trying to decode it.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
