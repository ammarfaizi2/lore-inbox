Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVC0RTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVC0RTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVC0RTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:19:40 -0500
Received: from colin2.muc.de ([193.149.48.15]:13068 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261182AbVC0RTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:19:35 -0500
Date: 27 Mar 2005 19:19:34 +0200
Date: Sun, 27 Mar 2005 19:19:34 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050327171934.GB18506@muc.de>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de> <424324F1.8040707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424324F1.8040707@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We -used- to need data from RNG directly into the kernel randomness 

Are you sure? I dont think there was ever code to do this in
mainline. There might have been something in -ac*, but not mainline.

> pool.  The consensus was that the FIPS testing should be moved to userspace.

Consensus from whom? And who says the FIPS testing is useful anyways?

I think you just need to trust the random generator, it is like
you need to trust any other piece of hardware in your machine. Or do you 
check regularly if you mov instruction still works? @)

I think it is a trade off between easy to use and saving of 
resources and overly paranoia. With an user space solution
which near nobody uses currently (I am not aware of 
any distribution that runs that daemon)
it means most people wont have hardware supported randomness
in their ssh, and I think that is a big drawback.

Also I dont like the memory consumption of the daemon. It needs
at least 20+k for kernel stack, page tables etc. I know
a lot of people dont care about memory usage anymore, but I still
do.  It is not a lot of memory, but bloat does usually not come in big
pieces but in small amounts of a time. And the code to do it
from kernel space is really simple. 

And it would suddenly make a lot of peoples ssh/https etc. more secure, 
which is a good thing. Probably would help Linux security a lot 
more than all these crazy - "ABI, what ABI?" - buffer overflow 
workarounds.

If you are really paranoid you can always turn off the sysctl
and do it from userspace. 

-Andi
