Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289963AbSAKOaj>; Fri, 11 Jan 2002 09:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289967AbSAKOa2>; Fri, 11 Jan 2002 09:30:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26373 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289963AbSAKOaV>; Fri, 11 Jan 2002 09:30:21 -0500
Subject: Re: Big patch: linux-2.5.2-pre11/drivers/scsi compilation fixes
To: adam@yggdrasil.com (Adam J. Richter)
Date: Fri, 11 Jan 2002 14:42:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020111051456.A12788@baldur.yggdrasil.com> from "Adam J. Richter" at Jan 11, 2002 05:14:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P2sd-0007pd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (!atomic_dec_and_test(&main_running)) {
>  		NCR5380_main();

This change is not required

>  /* Run the coroutine if it isn't already running. */
> +	spin_unlock_irq(&instance->host_lock);
>  	run_main();
> +	spin_lock_irq(&instance->host_lock);

This hangs the machine recursively re-entering under load.


I specifically told people not to hack on the old NCR5380 driver. You've 
taken a semi broken driver, destroyed it completely and risked disk corruption
for anyone who uses it.

What really annoys me is that I've already asked you specifically not to
submit patches to that driver but to take the 2.4.18pre version of the
driver and port that one forward if you must fiddle with it. Instead you've
wasted your time, and tried to make the future merge harder.

Its absolutely obvious from the changes that you have no grasp how the
locking in that driver is handled, nor what it depends upon. If you had 
understood that locking you'd have realised you were hacking on a driver 
version that was totally flawed.

How many other maintainers have you ignored trying to send in untested
patches to their drivers ?

Alan
