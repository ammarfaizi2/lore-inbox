Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbQKJHfy>; Fri, 10 Nov 2000 02:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130760AbQKJHfo>; Fri, 10 Nov 2000 02:35:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3078 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130113AbQKJHfc>;
	Fri, 10 Nov 2000 02:35:32 -0500
Date: Fri, 10 Nov 2000 07:35:29 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: jiffies wrap question...
Message-ID: <20001110073529.K2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <3A0BA1F8.E3ABCD18@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A0BA1F8.E3ABCD18@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Nov 10, 2000 at 02:21:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 02:21:28AM -0500, Jeff Garzik wrote:
> The following is a piece of code from the latter half of
> schedule_timeout, in kernel/sched.c.  Is it possible that
> schedule_timeout could return an incorrect value, if the jiffy value
> wraps between the first and last lines shown below.

let's say the first line happens n ticks before the wrap and the second,
m ticks afterwards.

>         expire = timeout + jiffies;

expire = timeout + 2^32/2^64 - n = timeout - n

>         timeout = expire - jiffies;

timeout = expire - m = timeout - n - m = timeout - (n+m)

(n+m) is the time that actually passed while we were asleep, and timeout
has the correct value (timeout - ticks that happened)>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
