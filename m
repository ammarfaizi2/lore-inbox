Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131054AbRCGMyC>; Wed, 7 Mar 2001 07:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131055AbRCGMxw>; Wed, 7 Mar 2001 07:53:52 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:63936 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131054AbRCGMxq>; Wed, 7 Mar 2001 07:53:46 -0500
Message-ID: <3AA62F4E.AB901CBB@uow.edu.au>
Date: Wed, 07 Mar 2001 23:53:34 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: spinlock help
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27157@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" wrote:
> 
> The kdb trace was accurate, we could actually see the e100 ISR pop from no
> where right in the middle of our ans_notify every time the TX queue would
> fill up. When we commented out the call to spin_*_irqsave(), it worked fine
> under heavy stress for days.
> 
> Is it possible it was something wrong with 2.4.0-test10 specifically ?
> 

Sorry, no.  If spin_lock_irqsave()/spin_unlock_irqrestore()
were accidentally reenabling interrupts then it would be
the biggest, ugliest catastrophe since someone put out a kernel
which forgot to flush dirty inodes to disk :)

Conceivably it was a compiler bug.  Were you using egcs-1.1.2/x86?

-
