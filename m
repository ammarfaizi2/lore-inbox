Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130308AbQLHAwz>; Thu, 7 Dec 2000 19:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLHAwg>; Thu, 7 Dec 2000 19:52:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15118 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129477AbQLHAwW>; Thu, 7 Dec 2000 19:52:22 -0500
Subject: Re: io_request_lock question (2.2)
To: baettig@scs.ch
Date: Fri, 8 Dec 2000 00:24:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200012080017.QAA00379@k2.llnl.gov> from "Reto Baettig" at Dec 07, 2000 04:17:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144BKn-0003EO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I looked at the implementation of the nbd which just calls 
> 
> 	spin_unlock_irq(&io_request_lock);
> 	... do network io ...
> 	spin_lock_irq(&io_request_lock);
> 
> This seems to work but it looks very dangerous to me (and ugly, too). Isn't there a better way to do this?

It is only dangerous if you unlock it in the wrong place, unlocking it as much
as possible is good behaviour. You need it locked until you get the actual
request off the queue, you need it locked when you complete the request. The
rest of the time you can be polite

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
