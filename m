Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272364AbRHYAJq>; Fri, 24 Aug 2001 20:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272356AbRHYAJg>; Fri, 24 Aug 2001 20:09:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29191 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272351AbRHYAJU>; Fri, 24 Aug 2001 20:09:20 -0400
Subject: Re: oops in 3c59x driver
To: wichert@wiggy.net (Wichert Akkerman)
Date: Sat, 25 Aug 2001 01:12:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010825020022.B21339@wiggy.net> from "Wichert Akkerman" at Aug 25, 2001 02:00:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aR40-0006qp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Decoded oops is below. The machine died in the middle of transferring
> a large chunk of data (500Mb or so) via ssh. It did that twice in a row
> now so it seems to be reprocuable.

Beautiful trace. You took an IRQ during PnPBIOS call and your machine
exploded. Do me a favour -

Change the semaphore in drivers/pnp/pnp_bios.c to a spinlock_irqsave
and __cli/ spin_unlock_irqrestore.  See if the crashes then go away.

Alan
