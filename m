Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUALW3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUALW3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:29:45 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:61105 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266445AbUALW3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:29:42 -0500
Date: Mon, 12 Jan 2004 14:28:39 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: hch@infradead.org, schwab@suse.de, paulus@samba.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040112142839.3dbda2d0.pj@sgi.com>
In-Reply-To: <20040112220024.GA12748@tsunami.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040109064619.35c487ec.pj@sgi.com>
	<je1xq9duhc.fsf@sykes.suse.de>
	<20040109152533.A25396@infradead.org>
	<20040109092309.42bb6049.pj@sgi.com>
	<20040112000923.GA2743@tsunami.ccur.com>
	<20040112134112.2dd0ec42.pj@sgi.com>
	<20040112220024.GA12748@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> MASK_CHUNKSZ is a named constant not a variable.  Once we pick a value
> it can never change.  The specified legal values are for 1) varying to
> test for algorithmic correctness, and 2) giving the list of values from
> which we must pick the permanent value before too much more time goes by.

I can see where the testing for algorithmic correctness would be useful.

The final code should reflect the final choices.

> No.  snprintf will fill to the end of the buffer and not place the

Correct - snprintf will not nul terminate if it runs out of buffer.

But then again, I wouldn't expect a "mask_snprintf" (such as might wrap
this __mask_snprintf_len() code) to guarantee nul termination in the
full buffer case either.  Rather the caller has to watch for a returned
length that is too close to the length of the buffer, and handle it as
an error.  If you look at the cpumask_snprintf() calls, they do just
this.

snprintf-like calls should behave like snprintf calls, no fancier.

> I am pretty sure the code is within a hairsbreadth of being minimal.

We'll see.  I'm still poking at it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
