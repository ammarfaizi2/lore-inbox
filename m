Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129454AbQKHBIp>; Tue, 7 Nov 2000 20:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129967AbQKHBIg>; Tue, 7 Nov 2000 20:08:36 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:40700 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S129454AbQKHBI2>; Tue, 7 Nov 2000 20:08:28 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0 
In-Reply-To: Your message of "Mon, 06 Nov 2000 20:55:49 +1100."
             <3A068025.38D62785@uow.edu.au> 
Date: Tue, 07 Nov 2000 13:23:47 +1100
Message-Id: <20001107022348.62CD3820D@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A068025.38D62785@uow.edu.au> you write:
> Paul Gortmaker wrote:
> > - extern void ether_setup(struct net_device *dev);
> > + extern void __ether_setup(struct net_device *dev);
> > + static inline void ether_setup(struct net_device *dev){
> > +       dev->owner = THIS_MODULE;
> > +       __ether_setup(dev);
> > + }
> > 
> > Ugh. Probably should just add it to each probe and be done with it...
> 
> mm..  Seeing as failure to set dev->owner is a fatal mistake,
> it would be good to enforce this via the compiler type system.
> 
> How about making THIS_MODULE an argument to register_netdevice()
> and, hence, register_netdev() and init_etherdev()?

Bear in mind that in 2.5, the THIS_MODULE registration cancer
infesting the kernel[1] will vanish with two-stage module delete[2].

	http://www.wcug.wwu.edu/lists/netdev/200006/msg00250.html

Rusty.

[1] And getting worse.
[2] Which was the correct solution for 2.4, only I was all out of
    `get out of code freeze free' cards.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
