Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbQL3R3z>; Sat, 30 Dec 2000 12:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133037AbQL3R3o>; Sat, 30 Dec 2000 12:29:44 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5130 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132865AbQL3R3k>; Sat, 30 Dec 2000 12:29:40 -0500
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Sat, 30 Dec 2000 17:01:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20001230133910.A5341@emma1.emma.line.org> from "Matthias Andree" at Dec 30, 2000 01:39:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CPNo-0006ny-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, reading from /proc/apm triggers BIOS calls which involve
> certain action, maybe switching to Real Mode and other things, and I
> suspect that either IRQs are still disabled while the BIOS is called or
> the BIOS plays bad games which Linux would have to compensate for. :-/

Looking at the one laptop with this problem I could acquire access to it seems
that the box switches to SMM mode with interrupts disabled for several timer
ticks. During this time the i2c bus is active and it appears to be having a
slow polled conversation with the battery or something attached to the battery
and monitoring it.

Doing

	while { true }
	do
		cat /proc/apm
	done

made the box visibly stall and jerk doing X operations


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
