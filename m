Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSFFXBl>; Thu, 6 Jun 2002 19:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSFFXBk>; Thu, 6 Jun 2002 19:01:40 -0400
Received: from air-2.osdl.org ([65.201.151.6]:64398 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S311898AbSFFXBj>;
	Thu, 6 Jun 2002 19:01:39 -0400
Date: Thu, 6 Jun 2002 15:57:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.44.0206061706230.31896-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.33.0206061551170.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, you're basically right, whether you use the refcount in struct driver 
> or the module use count doesn't make any difference. Except for one thing:
> You cannot call module_exit() when the module count is > 0. Since only 
> then unregister_driver() is called, there's no way to get the use count to 
> zero and thus unload the module. One could of course change the policy to 
> call unregister_driver() not from module_exit(), but e.g. by
> "echo remove > /driversfs/../my_driver", but it's surely not that I'm 
> suggesting this.

We can keep the same policy as modules now - keep the usage count at 0 
when not in use. That way the module can unload at any time. module_exit() 
calls driver_unregister(), which, down the line, calls the drivers' 
remove() for each device attached to it. 

That seems a lot cleaner than anything so far; we leverage the existing
module infrastructure as much as possible. I'll see about codifying the
concept in the next day or so and sending it out..

	-pat

