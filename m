Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEPwf>; Fri, 5 Jan 2001 10:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbRAEPwZ>; Fri, 5 Jan 2001 10:52:25 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:40884 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129267AbRAEPwT>; Fri, 5 Jan 2001 10:52:19 -0500
Message-ID: <3A55EF19.1BD5EE39@uow.edu.au>
Date: Sat, 06 Jan 2001 02:58:17 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: I Lee Hetherington <ilh@sls.lcs.mit.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
In-Reply-To: <3A54E717.11A43B42@sls.lcs.mit.edu> <3A557D12.A5383794@uow.edu.au> <3A55E15B.F39D6B87@sls.lcs.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Lee Hetherington wrote:
> 
> Andrew Morton wrote:
> 
> > Please do.  The boot-time messages which come out of the driver
> > would be interesting.  It would help if you add `debug=7' to
> > the 3c59x modprobe command line also.
> 
> OK.  I've included dmesg output due to modprobe with debug=7 followed by ifup
> (using pump -- problems persist with static IP as well), cat /proc/interrupts
> showing no eth0, and ifconfig eth0.

OK, that's wierd.  Why on earth isn't it showing up in 
/proc/interrupts?  It's certainly generating Tx interrupts,
and the ISR is being called.

Is this a new NIC?  3Com have just started shipping a
new flavour of the 905c, the 3c905CX.  With this device
the RxReset command takes tens of milliseconds to complete,
not tens of microseconds like all the others.  This
breaks the driver.  You end up being able to transmit but
not receive.

And the old media interface selection algorithms don't work
right with the 3c905CX either.   We only got this sorted
a few days ago and we missed the 2.4.0 boat :(

Could you please test this 2.2 driver?

	http://www.uow.edu.au/~andrewm/linux/3c59x.c-2.2.19-pre2-2.gz

Thanks.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
