Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275482AbRIZSzM>; Wed, 26 Sep 2001 14:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275483AbRIZSzI>; Wed, 26 Sep 2001 14:55:08 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:39616 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S275482AbRIZSyy>; Wed, 26 Sep 2001 14:54:54 -0400
Date: Wed, 26 Sep 2001 19:55:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ben LaHaise <bcrl@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010926195513.A3664@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 26, 2001 at 06:44:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 06:44:03PM +0200, Ingo Molnar wrote:
>  - the generic definition of __cpu_raise_softirq() used to override
>    any lowlevel definitions done in asm/softirq.h. It's now conditional so
>    the architecture definitions should actually be used.

Ingo,

The generic definition is the one to use - we used to allow
__cpu_raise_softirq from outside IRQ context, but all RISC architectures
ended up with code as follows:

	restore irqs
	save + disable irqs
	set bit
	restore irqs

In the latest kernels, you will notice that __cpu_raise_softirq is always
within an IRQ protected region (thanks to Andrea for that work), so there
is no reason for it to protected itself from interrupts.  Hence the comment
above cpu_raise_softirq:

 * This function must run with irq disabled!


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

