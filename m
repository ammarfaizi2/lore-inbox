Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWGPMsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWGPMsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWGPMsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 08:48:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36360 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751576AbWGPMsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 08:48:39 -0400
Date: Sun, 16 Jul 2006 13:48:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Albert Cahalan <acahalan@gmail.com>, dwmw2@infradead.org,
       arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.18 Headers - Long
Message-ID: <20060716124824.GA11883@flint.arm.linux.org.uk>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	Albert Cahalan <acahalan@gmail.com>, dwmw2@infradead.org,
	arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com> <6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 08:34:53AM -0400, Kyle Moffett wrote:
> There is *NO* portable way to get atomic operations or locking in  
> userspace except through libpthread.

And as one of the maintainers of an architecture where this is true
(neither atomic.h nor bitops.h will work in userspace atomically) I
whole heartedly agree that the kernel's atomic operations must not
be exported to userspace via header files.

Anyone who thinks they will or should do is just kidding themselves.

The final point to add to this is that folk might be lucky, and the
kernel's atomic ops might _appear_ to work without raising any faults,
but that does _not_ mean that they are necessarily atomic in their
operation.  For example:

	unsigned long *a;

	a[bit >> 5] |= 1 << (bit & 31);

and

	set_bit(bit, &a);

are 100% equivalent in userspace if you use the kernel's asm-arm/bitops.h.
Neither will be atomic.  More importantly, _neither_ could be made to be
atomic.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
