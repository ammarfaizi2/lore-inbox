Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbREaJWP>; Thu, 31 May 2001 05:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263040AbREaJWG>; Thu, 31 May 2001 05:22:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64267 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263039AbREaJVv>;
	Thu, 31 May 2001 05:21:51 -0400
Date: Thu, 31 May 2001 10:21:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Leif Sawyer <lsawyer@gci.com>,
        linux kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 -ac series broken on Sparc64
Message-ID: <20010531102113.A17090@flint.arm.linux.org.uk>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446E125@berkeley.gci.com> <E1550s0-0005XN-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1550s0-0005XN-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, May 30, 2001 at 08:58:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 08:58:19AM +0100, Alan Cox wrote:
> > include/linux/irq.h:61: asm/hw_irq.h: No such file or directory
> > *** [sched.o] Error 1
> 
> The sparc64 tree isnt very well integrated with -ac. What I have I merge but
> where -ac varies from the Linus tree or the Linus tree requires new files
> tends to break it.
> 
> It can probably be an empty file

I've had reports of this on the ARM tree.  I've always taken the view that
if a driver is including linux/irq.h, then it is buggy.  It has no business
including that file - it only contains structures and definitions relating
to architecture specific code.

In Linus' tree, the only reference outside arch code to linux/irq.h is:

drivers/pcmcia/hd64465_ss.c:#include <linux/irq.h>

and it'd be good to get rid of that one as well, but AFAICS this is a
sh specific driver.

Please, lets not make it compulsary for architectures to implement the irq
handling described in linux/irq.h.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

