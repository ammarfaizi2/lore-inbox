Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbQJaTBJ>; Tue, 31 Oct 2000 14:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbQJaTA6>; Tue, 31 Oct 2000 14:00:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7024 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129623AbQJaTAr>; Tue, 31 Oct 2000 14:00:47 -0500
Subject: Re: Locking question, is this cool?
To: george@mvista.com (George Anzinger)
Date: Tue, 31 Oct 2000 19:01:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.redhat.com)
In-Reply-To: <39FF14C9.33AE7325@mvista.com> from "George Anzinger" at Oct 31, 2000 10:51:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qgf5-00089s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At line 1073 of ../drivers/char/i2lib.c (2.4.0-test9) we find:
> 
> WRITE_LOCK_IRQSAVE(...
> 
> this is followed by:
> 
> COPY_FROM_USER(...
> 
> It seems to me that this could result in a page fault with interrupts
> off.  Is this ok?

It wont do what you want - it'll re-enable irqs and may then deadlock. It might
need to copy the buffer to a temporary space then take the lock >
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
