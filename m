Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRAVK3o>; Mon, 22 Jan 2001 05:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131825AbRAVK3e>; Mon, 22 Jan 2001 05:29:34 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:47278 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130154AbRAVK3R>; Mon, 22 Jan 2001 05:29:17 -0500
Message-ID: <3A6C0D3A.39F5793E@uow.edu.au>
Date: Mon, 22 Jan 2001 21:36:42 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jeffml@pobox.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 Oops
In-Reply-To: <01012111414100.15973@earth>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Lightfoot wrote:
> 
> Nothing special with this box.  SMP no modules, Squid proxy and
> running VNC/Pan at the time.  Using kernel version of reiserfs on
> filesystems other than root.
> 
> Be glad to offer any other info if needed.

Would I be correct in assuming that you're using a serial
console, and that the oops was caused by the NMI watchdog?

It seems that this is _bound_ to happen - we're busy
waiting on the UART with interrupts disabled....

Some fixes which come to mind are:

1: the serial console code tells the NMI oopser that it knows what
   it's doing.

2: the serial console code aborts the write if it doesn't make any
   progress for 1/10th of a second.

3: Boot the kernel with the `nmi_watchdog=0' LILO option if you're
   using an unreliable serial console.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
