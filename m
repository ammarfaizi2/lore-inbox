Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbTCQReG>; Mon, 17 Mar 2003 12:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbTCQRdX>; Mon, 17 Mar 2003 12:33:23 -0500
Received: from dp.samba.org ([66.70.73.150]:34523 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261810AbTCQRdL>;
	Mon, 17 Mar 2003 12:33:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Oliver Neukum <oliver@neukum.name>
Subject: Re: PCI driver module unload race? 
Cc: Greg KH <greg@kroah.com>, Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
In-reply-to: Your message of "Tue, 11 Mar 2003 17:07:09 BST."
             <200303111707.09119.oliver@neukum.name> 
Date: Mon, 17 Mar 2003 00:13:39 +1100
Message-Id: <20030317174406.B3B012C2D8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200303111707.09119.oliver@neukum.name> you write:
> 
> > This means the module refcount must remain at 0, even after it's bound to
> > devices. Changing this would require a change in visible behavior, and
> > require an extra step by a user to disconnect the driver before they
> > unload the module.
> 
> Yes, that would mean changing behaviour. On the other hand, we require
> new module utilities for 2.6 anyway, so why not?

Because I think it's silly, from a user point of view.  Why are you
removing the module, after all?

Anyway, a pre-removal notifier in sys_module_delete would have the
same effect (with the same issues if the refcount isn't 0 after all,
and you then want to fail the rmmod).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
