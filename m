Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbRDEA1q>; Wed, 4 Apr 2001 20:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbRDEA1d>; Wed, 4 Apr 2001 20:27:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131878AbRDEA1X>; Wed, 4 Apr 2001 20:27:23 -0400
Subject: Re: vmalloc on 2.4.x on ia64
To: hiren_mehta@agilent.com
Date: Thu, 5 Apr 2001 01:28:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880A08@xsj02.sjs.agilent.com> from "hiren_mehta@agilent.com" at Apr 04, 2001 06:11:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kxdr-00035g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am calling during initialization only from detect() entry point.
> But I guess, before the detect() is called, scsi layer acquires
> the io_request_lock. So, you mean to say that I need to release it

That depends if your driver is doing old or new style initialization

> before calling vmalloc() ? I was doing the same thing on 2.2.x
> and even on 2.4.0 and it was working fine and now suddenly
> it stopped working on 2.4.2. So what are the guidelines for using
> vmalloc() if we want to use it in scsi low-level (HBA) driver ?

You can use vmalloc in any situation where you are in task context
and can sleep.

> I am currently using the new error handling code. (use_new_eh_code = TRUE).

Then yes you would need to drop the lock if my memory serves me rightly.
