Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275092AbRJFOlI>; Sat, 6 Oct 2001 10:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275041AbRJFOk6>; Sat, 6 Oct 2001 10:40:58 -0400
Received: from sushi.toad.net ([162.33.130.105]:27044 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274684AbRJFOkw>;
	Sat, 6 Oct 2001 10:40:52 -0400
Subject: Re: Question about rtc_lock
From: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15prGs-0001G3-00@the-village.bc.nu>
In-Reply-To: <E15prGs-0001G3-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 06 Oct 2001 10:40:54 -0400
Message-Id: <1002379256.857.3.camel@thanatos>
Mime-Version: 1.0
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 09:13, Alan Cox wrote:
> > No, but what if the rtc interrupts while the lock is held in this
> > bit of code?
> 
> Thats fine. It wont take the lock

But the first line of irq_interrupt() is:
   spin_lock (&rtc_lock);

If one has a multi-processor machine, and CPUx is going through
the bootflag code, which takes the rtc_lock, and that CPU is
interrupted and enters rtc_interrupt(), which tries to take the
rtc_lock, won't it deadlock?

If not, then I'm missing some clue about how these spinlocks work.

Thomas

