Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTHaQqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTHaQqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:46:14 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:3747 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262420AbTHaQqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:46:13 -0400
Message-ID: <3F522756.9000105@terra.com.br>
Date: Sun, 31 Aug 2003 13:50:30 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, rnp@netlink.co.nz
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver
References: <3F51B1A3.4080307@colorfullife.com>
In-Reply-To: <3F51B1A3.4080307@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Manfred,

Manfred Spraul wrote:
> Additionally, you must replace the sleep_on calls with wait_event, or an 
> open-coded wait queue: sleep_on is racy, it only works with cli().

	Oh, I didn't no that..

> IMHO the right way to fix cli() is
> - add a single spinlock to the driver or the device structure. Do not 
> forget the spin_lock_init().
> - replace cli/sti with spin_lock_irqsave/spin_unlock_irqsave.

	Yes.

> - Additionally acquire the spinlock in every interrupt handler (cli() 
> stops all interrupts, spinlocks only stop interrupt on the current cpu).
> - check if there were recursive cli() calls. Fix them.
> - replace all sleep_on calls with wait queue calls.
> - check if there are any kmalloc or schedule calls in the area now under 
> the spinlock, and reorganize the code.

	But doesn't wait_queue call schedule()?

> And please add a changelog entry that code was converted without testing.

	Ok.

	Thanks for your review, will work on those.

Felipe
-- 
It's most certainly GNU/Linux, not Linux. Read more at
http://www.gnu.org/gnu/why-gnu-linux.html

