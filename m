Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312141AbSDEDDV>; Thu, 4 Apr 2002 22:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSDEDDL>; Thu, 4 Apr 2002 22:03:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35858 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312141AbSDEDC6>; Thu, 4 Apr 2002 22:02:58 -0500
Subject: Re: [QUESTION] How to use interruptible_sleep_on() without races ?
To: jt@hpl.hp.com
Date: Fri, 5 Apr 2002 04:20:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <20020404185232.B27209@bougret.hpl.hp.com> from "Jean Tourrilhes" at Apr 04, 2002 06:52:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tKGi-0007Sy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	if(my_condition == TRUE)
> 		interruptible_sleep_on(&my_wait_queue);
> ----------------------------------
> 
> 	Then, at some point, a timer/BH/soft-irq will do :
> -------------------------------
> 	my_condition == FALSE;
> 	wake_up_interruptible(&my_wait_queue);
> 
> 	I looked at it in every possible way, and I don't see how it
> is possible to use safely interruptible_sleep_on(). And I wonder :

It isnt for interrupt stuff - its going back to the old kernel behaviour
when it used to be usable

> interruptible_sleep_on() but use some complex code around schedule()
> (and there must be a simpler and cleaner solution for such a simple
> problem).

Actually the code it uses is clean, slightly verbose but clean. It puts
the phases in the right order and that fixes the race cleanly. You
could just use completions in that case or you could use

	wait_event_interruptible(&my_wait_queue, my_condition==FALSE)

which is a macro that generates the right stuff.

Alan
