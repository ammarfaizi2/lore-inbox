Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129539AbQLWSMJ>; Sat, 23 Dec 2000 13:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQLWSMA>; Sat, 23 Dec 2000 13:12:00 -0500
Received: from colorfullife.com ([216.156.138.34]:31757 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129539AbQLWSLx>;
	Sat, 23 Dec 2000 13:11:53 -0500
Message-ID: <3A44E4D0.E8F177B9@colorfullife.com>
Date: Sat, 23 Dec 2000 18:45:52 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: mulder.abg@sni.de, jgarzik@mandrakesoft.com
CC: linux-kernel@vger.kernel.org
Subject: Q: natsemi.c spinlocks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff, Tjeerd,

I spotted the spin_lock in natsemi.c, and I think it's bogus.

The "simultaneous interrupt entry" is a bug in some 2.0 and 2.1 kernel
(even Alan didn't remember it exactly when I asked him), thus a sane
driver can assume that an interrupt handler is never reentered.

Donald often uses dev->interrupt to hide other races, but I don't see
anything in this driver (tx_timeout and netdev_timer are both trivial)


--
  Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
