Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132124AbQLHONV>; Fri, 8 Dec 2000 09:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132158AbQLHONL>; Fri, 8 Dec 2000 09:13:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12048 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132124AbQLHONE>; Fri, 8 Dec 2000 09:13:04 -0500
Subject: Re: io_request_lock question (2.2)
To: baettig@scs.ch
Date: Fri, 8 Dec 2000 13:44:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200012080127.RAA13144@k2.llnl.gov> from "Reto Baettig" at Dec 07, 2000 05:27:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144NpK-0003ti-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	spin_lock_irq(&io_request_lock);
> we finish the request and return to the add_request function which calls
> 	spin_unlock_irqrestore(&io_request_lock,flags);
> and restores the flags.     
> 
> Isn't it possible now that the flags which we restore are out of date now?
> Is this idiom the right one to use for 2.2?

It is fine for 2.2 as well.

The flags you restore are ok. It restores the interrupt state to the state it
was in when you were called. Think of save_flags/restore_flags as bracketing
regions of code (and being nestable in pairs). The only real bizarre rule is
that you cannot save_flags in one function and restore_flags in another without
upsetting DaveM - as it breaks on the sparc if you do that

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
