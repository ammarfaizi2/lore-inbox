Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131933AbQKQKzI>; Fri, 17 Nov 2000 05:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131946AbQKQKy7>; Fri, 17 Nov 2000 05:54:59 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:65276 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131933AbQKQKyu>; Fri, 17 Nov 2000 05:54:50 -0500
Date: Fri, 17 Nov 2000 12:24:33 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jacob Luna Lundberg <jacob@velius.chaos2.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
Message-ID: <20001117122433.I703@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0011170905030.19287-100000@callisto.yi.org> <Pine.LNX.4.21.0011170026130.10109-100000@velius.chaos2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0011170026130.10109-100000@velius.chaos2.org>; from jacob@velius.chaos2.org on Fri, Nov 17, 2000 at 12:35:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 12:35:03AM -0800, Jacob Luna Lundberg wrote:
> > atomic_dec_and_test() returns true.
> 
> Indeed, after studying the asm in question I think I see how it ticks.
> What is the reasoning behind reversing the result of the test instead of
> returning the new value of the counter?

The full name of this operation is: "Decrement the value given
and test the result for equality with zero in one atomic operation".

So basically: 

#define dec_and_test(i) ( (--i) ? 0 : 1)

but atomically.

This is implemented in hardware for some archs and a required
operation for proper and fast refcounting.

Regards

Ingo Oeser
-- 
To the systems programmer, users and applications
serve only to provide a test load.
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
