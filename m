Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311403AbSDECxJ>; Thu, 4 Apr 2002 21:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311917AbSDECw7>; Thu, 4 Apr 2002 21:52:59 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:51420 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311403AbSDECwn>;
	Thu, 4 Apr 2002 21:52:43 -0500
Date: Thu, 4 Apr 2002 18:52:32 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [QUESTION] How to use interruptible_sleep_on() without races ?
Message-ID: <20020404185232.B27209@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I've got a problem on using interruptible_sleep_on(). I hope
you will help me fix that ;-)

	I want to wait for a task to finish :
----------------------------------
	if(my_condition == TRUE)
		interruptible_sleep_on(&my_wait_queue);
----------------------------------

	Then, at some point, a timer/BH/soft-irq will do :
-------------------------------
	my_condition == FALSE;
	wake_up_interruptible(&my_wait_queue);
-------------------------------

	It seems straightforward, but it doesn't work. There is a race
condition between the test of the condition and the call to
sleep_on().
	I looked at it in every possible way, and I don't see how it
is possible to use safely interruptible_sleep_on(). And I wonder :
what's the point of having a function in the kernel if you can't use
it safely ?
	As a matter of fact, the TCP code doesn't use
interruptible_sleep_on() but use some complex code around schedule()
(and there must be a simpler and cleaner solution for such a simple
problem).

	Any comments ?

	Jean
