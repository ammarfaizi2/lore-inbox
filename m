Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbRERMqn>; Fri, 18 May 2001 08:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262313AbRERMqd>; Fri, 18 May 2001 08:46:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5644 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262310AbRERMqU>; Fri, 18 May 2001 08:46:20 -0400
Subject: Re: [newbie] timer in module
To: sebastien.person@sycomore.fr (sebastien person)
Date: Fri, 18 May 2001 13:43:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (liste noyau linux)
In-Reply-To: <20010518135441.59bab0ce.sebastien.person@sycomore.fr> from "sebastien person" at May 18, 2001 01:54:41 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150jbF-00073J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've no experience of a regularly call that let the hand to the module.
> My aim is to do a get data call every x seconds (x is variable).

	init_timer()
	add_timer()
	del_timer()

are your frinnds.

> In the case of a network module wich is able to send and receive data,
> whats happen if the driver is sollicited when he received or send data ?
> the tbusy bit is it designed to avoid this case ?

Your timer is like an interrupt (in fact it runs from one) so you will need
to lock it against transmit, receive, multicast list loads and get_stats
all of which can happen at the same time.

tbusy on 2.2 (its replaced on 2.4 with nicer stuff) is for write path locking,
and the kernel ensures your send packet routine wont be re-entered by another
send packet. It ensures you wont get an IRQ while handling the IRQ

The rest is up to you

