Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278932AbRKFKvk>; Tue, 6 Nov 2001 05:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278986AbRKFKva>; Tue, 6 Nov 2001 05:51:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20488 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278962AbRKFKvO>; Tue, 6 Nov 2001 05:51:14 -0500
Subject: Re: Using %cr2 to reference "current"
To: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 6 Nov 2001 10:58:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9s82rl$k51$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 05, 2001 11:18:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1613vx-00005r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is using %cr2 really faster than the old implementation, or is there
> another reason?  It seems that the alignment constraints on the stack
> still remains, since the %esp solution still remains in places...

The stack is no longer aligned. We allocate two pages and disturb the stack
by upto 1.5K. We slab the task structs.

> It might also be worth considering a segment-register based
> implementation instead.  The reason we're not using %fs and %gs in the
> kernel anymore is because of the setup slowness, but perhaps using
> them (use %fs since it's much more likely to be NULL and thus faster
> to restore) would be faster than using %cr2?

It may be. Likewise its not clear if %cr2 should hold current or a cpu ident
pointer (so you dont reload on switch of task). This needs more
benchmarking. Its in current -ac to verify the theory is correct not the
tuning.
