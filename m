Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbQLHAsf>; Thu, 7 Dec 2000 19:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130456AbQLHAsP>; Thu, 7 Dec 2000 19:48:15 -0500
Received: from k2.llnl.gov ([134.9.1.1]:34982 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S130205AbQLHAsB>;
	Thu, 7 Dec 2000 19:48:01 -0500
From: Reto Baettig <baettig@k2.llnl.gov>
Message-Id: <200012080017.QAA00379@k2.llnl.gov>
Subject: io_request_lock question (2.2)
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Dec 2000 16:17:30 -0800 (PST)
Reply-To: Reto Baettig <baettig@scs.ch>
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm trying to write a block device driver which does some network stuff to satisfy the requests. The problem is, that the network stuff wants to grab the io_request_lock which does not work because this lock is already locked when I come into the request_fn of my device.

I looked at the implementation of the nbd which just calls 

	spin_unlock_irq(&io_request_lock);
	... do network io ...
	spin_lock_irq(&io_request_lock);

This seems to work but it looks very dangerous to me (and ugly, too). Isn't there a better way to do this?

Thanks very much

Reto 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
