Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbRERNax>; Fri, 18 May 2001 09:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbRERNao>; Fri, 18 May 2001 09:30:44 -0400
Received: from [195.6.125.97] ([195.6.125.97]:3084 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S262311AbRERNae>;
	Fri, 18 May 2001 09:30:34 -0400
Date: Fri, 18 May 2001 15:28:34 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: [newbie] timer in module
Message-Id: <20010518152834.7308d344.sebastien.person@sycomore.fr>
In-Reply-To: <E150jbF-00073J-00@the-village.bc.nu>
In-Reply-To: <20010518135441.59bab0ce.sebastien.person@sycomore.fr>
	<E150jbF-00073J-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, 18 May 2001 13:43:21 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> a ecrit :

> > I've no experience of a regularly call that let the hand to the
module.
> > My aim is to do a get data call every x seconds (x is variable).
> 
> 	init_timer()
> 	add_timer()
> 	del_timer()
> 
> are your frinnds.
> 
> > In the case of a network module wich is able to send and receive data,
> > whats happen if the driver is sollicited when he received or send data
?
> > the tbusy bit is it designed to avoid this case ?
> 
> Your timer is like an interrupt (in fact it runs from one) so you will
need
> to lock it against transmit, receive, multicast list loads and get_stats
> all of which can happen at the same time.

So I must disable interrupt when I handle another function like receive
etc ...

> 
> tbusy on 2.2 (its replaced on 2.4 with nicer stuff) is for write path
locking,
> and the kernel ensures your send packet routine wont be re-entered by
another
> send packet. It ensures you wont get an IRQ while handling the IRQ
> 
> The rest is up to you

Thanks
