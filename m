Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293317AbSCKWDC>; Mon, 11 Mar 2002 17:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293362AbSCKWCx>; Mon, 11 Mar 2002 17:02:53 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:49149 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293317AbSCKWCq>;
	Mon, 11 Mar 2002 17:02:46 -0500
Date: Mon, 11 Mar 2002 14:02:44 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.6] New wireless driver API part 2
Message-ID: <20020311140244.A10810@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020311115523.A10682@bougret.hpl.hp.com> <3C8D2693.9000801@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8D2693.9000801@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 11, 2002 at 04:50:11PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 04:50:11PM -0500, Jeff Garzik wrote:
> Jean Tourrilhes wrote:
> 
> Overall looks good.  My only minor objection would be that this function 
> should return an error value.  Clearly the kmalloc can fail, at least.
> 
>     Jeff

	Thanks for the quick review (as usual), very much appreciated.

	Now, for the return value...
	I've debated this precise point. Here is the comment that I
wrote in the code you just quoted :
		/* Note : we don't return an error to the driver, because
		 * the driver would not know what to do about it. It can't
		 * return an error to the user, because the event is not
		 * initiated by a user request.
		 * The best the driver could do is to log an error message.
		 * We will do it ourselves instead...
		 */
	The failure to deliver an event to the user is not critical,
and I don't really see what the driver code would do with a return
code. In fact, event delivery to user space is not reliable (netlink
may drop it in case its queues are full - this is more likely than
kmalloc failure), and my code only check a few of those failure
conditions, so the driver has no way to know if the message reached
its intended destination.
	In fact, I eliminated the return code *on purpose*, to prevent
driver writer to do stupid things (like shutting down the driver) or
adding additional log message (waste at this point).
	Convincing enough ?

	Have fun...

	Jean
