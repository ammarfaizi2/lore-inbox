Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSIOX10>; Sun, 15 Sep 2002 19:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSIOX1Z>; Sun, 15 Sep 2002 19:27:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53259 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318292AbSIOX1X>;
	Sun, 15 Sep 2002 19:27:23 -0400
Message-ID: <3D851863.3040107@mandrakesoft.com>
Date: Sun, 15 Sep 2002 19:31:47 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Albert Cranford <ac9410@attbi.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/9]Four new i2c drivers and __init/__exit cleanup to
 i2c
References: <Pine.LNX.4.44.0209151845330.7637-200000@home1> <3D851556.7070203@mandrakesoft.com> <20020916002619.D30390@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Sep 15, 2002 at 07:18:46PM -0400, Jeff Garzik wrote:
> 
>>Albert Cranford wrote:
>>
>>>--- linux/drivers/i2c/i2c-elektor.c.orig	2002-09-14 22:10:45.000000000 -0400
>>>+++ linux-2.5.34/drivers/i2c/i2c-elektor.c	2002-09-15 01:18:55.000000000 -0400
>>>@@ -125,12 +125,12 @@
>>> 	int timeout = 2;
>>> 
>>> 	if (irq > 0) {
>>>-		cli();
>>>+		local_irq_disable();
>>> 		if (pcf_pending == 0) {
>>> 			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
>>> 		} else
>>> 			pcf_pending = 0;
>>>-		sti();
>>>+		local_irq_enable();
>>> 	} else {
>>> 		udelay(100);
>>> 	}
>>
>>
>>
>>this is _not_ the way to fix...   use a proper spinlock
> 
> 
> You can't hold a spinlock and sleep though, was one of my points back
> in August.  (Albert submitted a patch with all cli()/sti() converted
> to spin_lock_irqsave()/spin_unlock_irqrestore().)
> 


whoops, you're right.

That follows along with my suggestion in another email, then :)  use a 
semaphore.  The timeout can be handled with a kernel timer.  The timeout 
is clearly multiple seconds, so there's no fine grain involved.

AND, since the timeout is multiple seconds, the code should not be 
disable interrupts for that long anyway.

	Jeff



