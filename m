Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129956AbRBIEbe>; Thu, 8 Feb 2001 23:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129951AbRBIEbZ>; Thu, 8 Feb 2001 23:31:25 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:11283 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S129930AbRBIEbH>;
	Thu, 8 Feb 2001 23:31:07 -0500
Message-ID: <3A83727A.7E70944C@yahoo.co.uk>
Date: Thu, 08 Feb 2001 23:30:50 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Bug: 2.4.0 w/ PCMCIA on ThinkPad: KERNEL: 
 assertion(dev->ip_ptr==NULL)failed at 
 dev.c(2422):netdev_finish_unregister
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem has been resolved (sort of).  See the follow up to 
"[PATCH] to deal with bad dev->refcnt in unregister_netdevice()"

Thomas Hood

> Here is a patch which may not solve the underlying
> problem but which does prevent the kernel from 
> generating an infinite number of error messages
> on "cardctl eject" and from hanging up on shutdown.
> 
> ----------------------------------------------------
> jdthood@thanatos:/usr/src/kernel-source-2.4.1-ac3/net/core# diff dev.c_ORIG dev.c
> 2558c2558
> < 	while (atomic_read(&dev->refcnt) != 1) {
> ---
> > 	while (atomic_read(&dev->refcnt) > 1) {
> -----------------------------------------------------
> 
> The underlying problem is that refcnt is zero or less
> at this point.  This is erroneous.  The error in 
> maintaining the refcnt appears to occur only when 
> I configure the eth0 interface using pump or dhclient.
> Be that as it may, because of the erroneous refcnt,
> this while loop loops forever in the original.  As
> modified it falls through; and this makes the kernel
> usable for me.
> 
> I hope the networking gurus can find the real bug.
> 
> Thomas Hood
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
