Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSKZWx7>; Tue, 26 Nov 2002 17:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSKZWx6>; Tue, 26 Nov 2002 17:53:58 -0500
Received: from dp.samba.org ([66.70.73.150]:11474 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261450AbSKZWx6>;
	Tue, 26 Nov 2002 17:53:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Subject: Re: Modules with list 
In-reply-to: Your message of "Mon, 25 Nov 2002 22:49:35 -0800."
             <200211260649.WAA22216@adam.yggdrasil.com> 
Date: Wed, 27 Nov 2002 09:40:29 +1100
Message-Id: <20021126230116.123E82C480@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211260649.WAA22216@adam.yggdrasil.com> you write:
> >TCP for example, sets the destructor function for the skb.  It can be
> >called an arbitrary time later.  Netfilter modules do a similar thing,
> >for similar reasons.  You'd better grab a reference to *something*.
> 
> 	The ->remove() function of a network device driver will
> not return until it has freed all receive skb's that it allocated
> and all transmit skb's that were passed to its transmit function.

I'm not talking about a device driver, but modularizing the IPv4
stack.

> >This would only happen if someone says "rmmod --wait".

As I realized last night after I wrote this, there is a bug in
module.c.  If O_NONBLOCK is specified, we shouldn't drop the module
sempaphore at all, for exactly this reason.  A bug I introduced while
"cleaning up" the "--wait" path.

Sorry for the confusion.

> 	I think of people would consider it to be progress to have
> non-removable modular IP, which what I run, but I digress again.

Non-removable is easy.  It's now possible to do removable IPv4 and
IPv6, which was kind of the point of the exercise.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
